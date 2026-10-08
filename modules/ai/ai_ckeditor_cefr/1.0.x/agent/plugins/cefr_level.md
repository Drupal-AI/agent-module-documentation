<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "CEFR level" AI CKEditor plugin

## Install & enable

```bash
composer require drupal/ai_ckeditor_cefr
drush en ai_ckeditor_cefr -y
drush cr
```

Depends on `ai_ckeditor` (from the drupal/ai suite) and core `taxonomy`. No sub-modules, no Drush,
no permissions of its own.

## Where it lives in the UI

This is a plugin of the **ai_ckeditor** plugin type, not a standalone feature. Configure it on a
CKEditor 5 text format:

1. *Structure → (or) /admin/config/content/formats* → edit a format that uses **CKEditor 5**.
2. In the editor settings enable the **AI (ai_ckeditor_ai)** integration and its **CEFR level**
   plugin.
3. Expand the CEFR-level plugin settings (below).

At runtime the editor's **AI Assistant** dialog (parent route `ai_ckeditor.dialog`, permission
`use ai ckeditor`) lists **CEFR level**; selecting text and choosing it opens the modal with a CEFR
selector and a **Rewrite** button.

## Plugin settings

From `defaultConfiguration()` and `buildConfigurationForm()` in
`src/Plugin/AiCKEditor/CefrLevel.php` (schema: `config/schema/ai_ckeditor_cefr.schema.yml`,
extends `ckeditor5.plugin.ai_ckeditor_ai_base`):

| Key | Default | Meaning |
|---|---|---|
| `provider` | `NULL` | AI provider/model for this plugin. Empty → AI module chat default. Options from `aiProviderManager->getSimpleProviderModelOptions('chat', FALSE)`. |
| `default_level` | `'B1'` | Default CEFR level shown in the dialog. One of `A1,A2,B1,B2,C1,C2` (`getLevelOptions()`). |
| `protected_terms_vocabulary` | `''` | Optional taxonomy vocabulary machine name; its terms are kept unchanged in the rewrite. Options are all `taxonomy_vocabulary` entities. |
| `prompt` | long template | Rewrite prompt template. Placeholders: `{{ level }}`, `{{ level_style_target }}`, `{{ protected_words_instruction }}`. |

`submitConfigurationForm()` casts the vocabulary id and prompt to strings and saves them into the
format's editor settings. The prompt field is required only when the CEFR plugin is enabled
(`#states`).

## How a rewrite is generated

`ajaxGenerate(array &$form, FormStateInterface $form_state)`:

1. Reads `plugin_config`: `cefr_level` (falls back to `default_level`) and `selected_text`.
2. Loads the prompt template (`configuration['prompt']` or the default).
3. Builds `protected_words_instruction`: if `protected_terms_vocabulary` is set,
   `getVocabularyTerms()` calls `entityTypeManager->getStorage('taxonomy_term')->loadTree($vid)`
   and joins the term names into `"Do not rewrite or translate these words/phrases: …"`; otherwise
   `"None."`.
4. `str_replace()`s the three placeholders and appends `"\n\nText to rewrite:\n" . $selected_text`.
5. Returns an `AjaxResponse` with
   `new AiRequestCommand($prompt, $values['editor_id'], $this->pluginDefinition['id'], 'ai-ckeditor-response')`.
   The **parent `ai_ckeditor`** module (controller `Drupal\ai_ckeditor\Controller\AiRequest`,
   route `ai_ckeditor.do_request`, POST, permission `use ai ckeditor`) runs the drupal/ai chat call
   and streams the answer into the `#ai-ckeditor-response` wrapper for the editor to review/save.
6. On exception, logs to the `ai_ckeditor` logger channel and returns an inline error string.

### Per-level style targets

`getLevelStyleTarget(string $level)` returns a fixed style description per level (A1 = very basic
vocabulary/very short sentences … C2 = highly fluent/nuanced), substituted into
`{{ level_style_target }}`. Unknown levels fall back to a generic "clear, direct language" target.

## Operating notes

- The whole feature runs through the configured **AI provider** — rewrites incur provider usage
  cost. Provider/model and default level are set per text format.
- Protected-words support needs at least one taxonomy vocabulary; if none exists the field
  description tells the admin to create one first.
- The plugin only builds and dispatches the prompt; provider credentials, the request endpoint,
  and output handling are the parent `ai_ckeditor` module's responsibility.
