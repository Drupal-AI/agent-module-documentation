<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The FixAccessibility AiCKEditor plugin

`src/Plugin/AiCKEditor/FixAccessibility.php` — id `ai_editoria11y_fix`, extends
`Drupal\ai_ckeditor\AiCKEditorPluginBase`, attribute `#[AiCKEditor(... module_dependencies:
['editoria11y'])]`. It plugs into the AI CKEditor framework; this module defines no route or
controller of its own.

## Install & enable

```bash
composer require drupal/ai_editoria11y   # pulls drupal/editoria11y ^3.0@beta, drupal/ai ^1.2
drush en ai_editoria11y -y
```

Then:
1. Enable the **AI CKEditor** submodule (`ai_ckeditor`) and configure at least one AI provider.
2. In each CKEditor 5 text format, enable the AI CKEditor plugin and turn on the
   **AI Editoria11y** (`ai_editoria11y_fix`) plugin, choosing its provider.
3. Grant **`use ai editoria11y`** to the roles that should see the button.
4. Ensure Editoria11y is configured to check the relevant content.

## Configuration form (`buildConfigurationForm`)

Rendered inside the text format's AI CKEditor plugin settings:
- **`provider`** — `provider__model` chat option (stored in the plugin's own configuration, default
  from `AiProviderPluginManager::getSimpleDefaultProviderOptions('chat')`).
- **`system_prompt`** / **`user_prompt`** — saved to the shared config object
  `ai_editoria11y.settings` (`prompts.system`, `prompts.user`) by `submitConfigurationForm()`, not
  to the per-format plugin config.
- **`debug`** — boolean, saved to `ai_editoria11y.settings` `debug`.

Config object `ai_editoria11y.settings` (schema `config/schema/ai_editoria11y.schema.yml`, defaults
`config/install/`): `enabled` (bool), `button_label` (string, "Fix with AI"), `debug` (bool),
`prompts.system`, `prompts.user`. Defaults for the prompts come from `getDefaultSystemPrompt()` /
`getDefaultUserPrompt()`.

## The dialog form (`buildCkEditorModalForm`)

Reads the Editoria11y context (`getEditoria11yContext()`) from, in order: form state,
the `editoria11y_context` hidden field, or the POSTed `ed11y_context` / `ed11y_issue_*` request
params. Builds an issue-info fieldset and a custom preview area (status / label / preview /
description) plus a **hidden `ai_raw_response`** field. It deliberately replaces the default
CKEditor response field so the AI HTML is previewed unfiltered (CKEditor would otherwise rewrite,
e.g. `<th>`→`<p>`); the raw response is stored in the hidden field by the JS and only enters editor
content on save (where the text format's own filters still apply). The Save button starts disabled
and is enabled by JS once a fix streams in. When `debug` is on, `addDebugInfoToForm()` adds an
element/context/prompt dump — every value is emitted through `htmlspecialchars()` / `t()`
placeholders.

## Prompt building (`buildPrompt`)

`system_prompt` + "\n\n" + `user_prompt` after `str_replace` of placeholders:
`{{ issue_description }}` (run through `strip_tags()`), `{{ element_tag }}`, `{{ element_text }}`,
`{{ element_html }}`, `{{ before_text }}`, `{{ after_text }}`, `{{ before_html }}`,
`{{ after_html }}`, `{{ attributes_info }}` (from `buildAttributesInfo()`, which skips
`data-ed11y-fix-target`, `data-ai-ed11y-target`, `contenteditable`). The context values originate
from the current editor's own content (captured client-side).

## Generate & save flow

- `ajaxGenerate()` builds the prompt and returns an `AjaxResponse` carrying
  `AiRequestCommand(prompt, editor_id, plugin_id, 'ai-ckeditor-response')`. The `ai_ckeditor`
  framework's endpoint (`api/ai-ckeditor/request/{editor_id}/{plugin_id}`) performs the actual
  provider call and streams the reply.
- `submitCkEditorModalForm()` reads the client-supplied
  `plugin_config[response_wrapper][ai_raw_response]` and returns
  `EditorDialogSave(['attributes' => ['value' => $value, 'returnsHtml' => TRUE]])` +
  `CloseModalDialogCommand`. The value is handed to the editor as content, subject to the text
  format's filters on save/display.

## Notes

- All model egress is through `drupal/ai` (TLS + API key handled by the provider/Key layer, not
  this module). No request-supplied URL is fetched server-side.
- Access to the AI-invoking endpoint is governed by the `ai_ckeditor` framework (the dialog +
  request routes), not by this module; `use ai editoria11y` gates whether the integration library
  is attached to the format element (see `ai_editoria11y.module`).
