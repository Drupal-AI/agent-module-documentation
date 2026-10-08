<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Form-alter service & access gating

## Entry point

`ai_content_suggestions.module` implements `hook_form_alter()`: for any form whose form object is a
`ContentEntityFormInterface`, it calls `\Drupal::service('ai_content_suggestions.form_alter')->alter()`.

## Service `ai_content_suggestions.form_alter`

Class `AiContentSuggestionsFormAlter` (`src/AiContentSuggestionsFormAlter.php`), implements
`AiContentSuggestionsFormAlterInterface`. Constructor args:
`@plugin.manager.ai_content_suggestions`, `@entity_type.manager`, `@current_user`,
`@config.factory` (reads `ai_content_suggestions.settings`).

### `alter(&$form, $form_state)`

1. Adds cache contexts `user.permissions`, `ai_content_suggestions_plugins`, `ai_providers`.
2. **Access gate:** proceeds only if
   `currentUser->hasPermission('access ai content suggestion tools')`.
3. **Entity gate:** `isEnabledForCurrentEntity($entity)` — returns FALSE unless the entity's type
   is a key in the `entity_types` config; then for `mode = enable` the entity's bundle must be in
   the `bundles` list, for `mode = disable` it must NOT be. (Note the default install seeds
   `node`/`taxonomy_term`/`block_content` with `mode: disable` and empty bundles ⇒ enabled for all
   their bundles.)
4. For each plugin definition, instantiates it with its stored config and, if `isEnabled()`, calls
   `$plugin->alterForm($form, $form_state, getAllTextFields($entity, $form))`.

### `getAllTextFields($entity, $form)`

Builds the field option list offered to the editor. Includes fields present on `$form` whose type
is `text_with_summary`, `text_long`, `string`, or `string_long` (skips `revision_log` /
`revision_log_message`). For `entity_reference_revisions` (paragraphs) it recurses into each
widget subform, keying nested options as `field:delta:subform:machine_name` and labelling them
`Parent (delta) > Sub label`.

## Access & safety summary (for agents)

- **All editor-facing AI actions require the `access ai content suggestion tools` permission** —
  enforced in `alter()` (on-form plugins) and in `PromptContentSuggestion::isAvailable()`
  (per-field button). There are no custom routes/controllers for the suggestion calls: they run as
  Drupal **form AJAX** inside the content entity edit form, so they inherit that form's access
  check (node/entity edit access) and CSRF token. The only declared route is the admin settings
  form, gated by `administer ai`.
- **No credentials or direct HTTP** in this module — model selection, keys and transport are the
  AI module's (`ai.provider` / `getSetProvider()`); no `verify => false`, no raw `file_get_contents`.
- **No request-supplied URL is fetched** server-side (no SSRF surface); the field-widget action
  only renders the *current* entity to markdown for the prompt.
- Taxonomy term listings (Tone `getTerms`, Taxonomy `getTermsJson`/`getRelevantVocabularies`) run
  an access-checked entity query, so inaccessible terms are excluded from prompts.
- Model output is rendered either through Twig (`field_widget_actions_suggestions`, escaped) or as
  Drupal `#markup` (core `Xss::filterAdmin`), and is shown only to the editor who triggered it and
  never persisted.
