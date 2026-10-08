<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "WCAG" AI CKEditor plugin

## Install & enable

```bash
composer require drupal/ai_ckeditor_wcag
drush en ai_ckeditor_wcag -y
drush cr
```

Depends on core `ckeditor5`, the AI module (`ai`) and its `ai_ckeditor` submodule. No sub-modules,
no Drush, no permissions or config schema of its own.

## Where it lives in the UI

This is a plugin of the **ai_ckeditor** plugin type. Configure it on a CKEditor 5 text format:

1. */admin/config/content/formats* → edit a format using **CKEditor 5**.
2. Enable the **AI (ai_ckeditor_ai)** integration and its **WCAG** plugin.
3. Set the plugin options (below).

At runtime the editor's **AI Assistant** dialog (parent route `ai_ckeditor.dialog`, permission
`use ai ckeditor`) lists **WCAG**; selecting text and choosing it opens the modal with a
*"Check the selected text"* button.

## Plugin settings

From `buildConfigurationForm()` in `src/Plugin/AICKEditor/WCAG.php` (no config schema ships; values
are stored in the text format's editor settings):

| Key | Default | Meaning |
|---|---|---|
| `provider` | `NULL` | AI provider/model for this plugin. Empty → AI module chat default. Options from `aiProviderManager->getSimpleProviderModelOptions('chat')`. |
| `wcag_version` | `'2.2'` | WCAG version to check against: `1.0`, `2.0`, `2.1`, `2.2`. |
| `wcag_level` | `'AAA'` | WCAG conformance level: `A`, `AA`, `AAA`. |

`submitConfigurationForm()` writes all three into the format's editor settings.

## How a check is generated

`buildCkEditorModalForm()`:
- If there is no selected text in form storage, returns a `#markup` message telling the editor to
  select text first.
- Otherwise renders the disabled **Selected text to check** textarea and a **`text_format`**
  response field (`#ai-ckeditor-response`) bound to the current editor's filter format, and sets the
  action button to *"Check the selected text"* (the default submit button is removed).

`ajaxGenerate(array &$form, FormStateInterface $form_state)`:
1. Builds
   `"Check if the content of the following text is in line with WCAG version <wcag_version> level
   <wcag_level> rules: " . $values['plugin_config']['selected_text']`.
2. Appends `"\n\nRespond in the same language as the text."`.
3. Returns an `AjaxResponse` carrying
   `new AiRequestCommand($prompt, $values['editor_id'], $this->pluginDefinition['id'],
   'ai-ckeditor-response')`.
4. The **parent `ai_ckeditor`** module (controller `Drupal\ai_ckeditor\Controller\AiRequest`, route
   `ai_ckeditor.do_request`, POST, permission `use ai ckeditor`) runs the drupal/ai chat call and
   streams the answer into `#ai-ckeditor-response` for review inside the dialog.
5. On exception it logs and returns an inline error string.

## Operating notes

- The whole feature runs through the configured **AI provider** and incurs provider usage cost.
- The AI feedback is **advisory** — it flags potential WCAG issues in prose; it does not modify the
  content or produce a formal audit.
- The plugin only assembles and dispatches the prompt; credentials, the request endpoint and output
  handling belong to the parent `ai_ckeditor` module.
- Source note: the `create()` method injects `ai.vdb_provider`, but the plugin does not use it for
  the WCAG check.
