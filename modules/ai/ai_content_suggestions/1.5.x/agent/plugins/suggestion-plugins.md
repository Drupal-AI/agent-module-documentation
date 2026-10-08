<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The AiContentSuggestions plugin type & the six shipped plugins

## Plugin type

- Manager `AiContentSuggestionsPluginManager` (`src/AiContentSuggestionsPluginManager.php`),
  service `plugin.manager.ai_content_suggestions`, extends `DefaultPluginManager`. Discovery dir
  `Plugin/AiContentSuggestions`, interface `AiContentSuggestionsInterface`, annotation
  `@AiContentSuggestions` (`src/Annotation/AiContentSuggestions.php`: `id`, `title`, `description`,
  `operation_type`). Alter hook `ai_content_suggestions_info`; cache key
  `ai_content_suggestions_plugins`.
- Base class `AiContentSuggestionsPluginBase` (`src/AiContentSuggestionsPluginBase.php`) extends
  `ConfigurablePluginBase` and implements `AiContentSuggestionsInterface`, `PluginFormInterface`,
  `ContainerFactoryPluginInterface`. Injects `ai.provider`
  (`Drupal\ai\AiProviderPluginManager`) only.

### Key base-class methods

- `defaultConfiguration()` → `['enabled' => FALSE, 'model' => NULL]`.
- `getModels()` → `providerPluginManager->getSimpleProviderModelOptions(operationType(), $empty)`;
  `getDefaultModel()` falls back to the provider's default `provider_id__model_id` for the op type.
- `isAvailable()` → TRUE when `count(getModels(FALSE)) > 0` (a usable model exists).
- `isEnabled()` → config `enabled`.
- `buildConfigurationForm()` builds the per-plugin fieldset (enable checkbox + model select,
  `#empty_option` "-- Default from AI provider --"); subclasses append prompt fields.
- `getAlterFormTemplate($fields)` → the on-form UI: a `details` in the `advanced` group with a
  multi-select **`target_fields`** (default = all discovered fields), an AJAX `response` container
  (id `response-<pluginid>` from `getAjaxId()`), and a `*_submit` button whose `#ajax.callback` is
  `[$this, 'getPluginResponse']`. Attaches library `ai_content_suggestions/ai_content_suggestions_js`.
- `getTargetFieldValue($form_state)` reads the selected `target_fields` from form state (supports
  `:`-delimited paragraph subfield paths) and joins their `[0]['value']` values with blank lines.
- `sendChat($prompt)` — builds a `ChatInput` with a single `user` `ChatMessage`, system prompt
  "You are helpful assistant.", resolves provider via
  `providerPluginManager->getSetProvider(operationType(), config['model'])`, calls
  `$provider->chat($messages, $model_id, ['ai_content_suggestions'])->getNormalized()`, returns
  trimmed text; any `\Exception` → a generic "error obtaining a response from the LLM" message.
- `getPluginResponse()` (AJAX callback) calls the plugin's `updateFormWithResponse()` and returns
  `$form[pluginId]['response']`. (Static `AiContentSuggestionsFormAlter::getPluginResponse()` is
  **deprecated** in 1.4.0, removed in 2.0.0; also `buildSettingsForm()`/`saveSettingsForm()`.)

## The six plugins (`src/Plugin/AiContentSuggestions/`)

| id | class | op type | extra config | button | render |
|----|-------|---------|--------------|--------|--------|
| `summarise` | Summarise | chat | `prompt` (≤130-word summary) | "Summarize" | `#markup` of chat text |
| `title_suggest` | Title | chat | `prompt` (SEO title ≤10 words) | "Suggest title" | `#markup` |
| `readability` | Readability | chat | `prompt` (Flesch score + HTML block) | "Score readability" | `#markup`, strips ``` /```` fences |
| `tone` | Tone | chat | `prompt` w/ `{{ tone }}`, `taxonomy_enabled`, `taxonomy` | "Adjust Tone" | `#markup` |
| `taxonomy_suggest` | Taxonomy | chat | `prompt_open`, `prompt_from_voc` (ai.ai_prompt ids) | "Suggest taxonomy terms" | `#markup` |
| `moderate` | Moderate | moderation | — (uses `model` only) | "Analyze" | `item_list` of violated policies |

Notes on the non-trivial ones:

- **Tone** injects a `tone` select on the form. Options are a fixed list (Friendly, Professional,
  Helpful, high-school, college, "Explain like I'm 5") unless `taxonomy_enabled` + `taxonomy` are
  set, in which case options come from `getTerms($vid)` — a `loadTree()` filtered by an
  access-checked entity query. `updateFormWithResponse()` substitutes `{{ tone }}` into the prompt.
- **Taxonomy** adds an optional "Use source vocabulary" checkbox + vocabulary select (only for
  vocabularies that have accessible terms). Prompts are **`ai.ai_prompt` config entities** loaded
  via `AiPrompt::load()`. With a source vocabulary it appends an access-checked JSON term list
  (`getTermsJson()`, hierarchy-aware) and instructs the model to pick from it. Config form uses
  `#type => 'ai_prompt'` elements (from the AI module).
- **Moderate** does not chat: it calls `$provider->moderation($value, $model_id)->getNormalized()`
  and lists flagged `getInformation()` categories via `Unicode::ucfirst`; empty ⇒ "does not violate
  any content policies".

## Request flow (per suggestion click)

1. Editor is on a content entity edit form; `hook_form_alter` → form-alter service adds each enabled
   plugin's UI (see api/form-alter.md). 2. Editor selects `target_fields`, picks any plugin-specific
   option, clicks the plugin button. 3. Drupal form AJAX (with the form's CSRF token) invokes
   `getPluginResponse()` → `updateFormWithResponse()`. 4. The plugin reads the chosen field values
   from form state, calls the model via `ai.provider`, and writes the answer into the
   `response` container, which the AJAX response replaces in-place. Nothing is persisted; output is
   shown only to the editor who triggered it.
