<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Editoria11y (ai_editoria11y) — agent index

Bridges the **Editoria11y** accessibility checker and the **AI CKEditor** integration: injects a
**"Fix with AI"** button into Editoria11y tooltips in CKEditor 5, sends the flagged element +
context to the AI provider through `ai_ckeditor`'s request endpoint, streams back a suggested
corrected HTML snippet, shows a **before/after diff**, and applies the reviewed fix in place
(preserving undo history). Package **Editoria11y**. Version **1.0.x** (project 1.0.0-beta1).
Core `^10.3 || ^11`. License GPL-2.0-or-later.

- **Dependencies:** `editoria11y`, `ckeditor5`, `ai`, `ai_ckeditor`.
  composer: `drupal/editoria11y:^3.0@beta`, `drupal/ai:^1.2`.
- **No routing.yml of its own** — the AI call goes to the `ai_ckeditor` request endpoint
  (`api/ai-ckeditor/request/{editor_id}/{plugin_id}`) and the dialog to `ai_ckeditor.dialog`.
- **No standalone settings route** — prompts/model/debug are edited inside the text format's
  AI CKEditor plugin config form. `configure` is null.

## What it provides

- **AiCKEditor plugin** `FixAccessibility` (`src/Plugin/AiCKEditor/FixAccessibility.php`, id
  `ai_editoria11y_fix`, extends `ai_ckeditor\AiCKEditorPluginBase`, `module_dependencies:
  ['editoria11y']`). Builds the modal form, the prompt, the AJAX generate flow
  (`AiRequestCommand`) and the save command (`EditorDialogSave`). `needsSelectedText()` = FALSE.
  See [plugins/fix-accessibility.md](plugins/fix-accessibility.md).
- **Front-end library** `ai_editoria11y/integration` (`js/ai-editoria11y.js`,
  `css/ai-editoria11y.css`; deps `editoria11y/editoria11y`, `ai_ckeditor/ai_ckeditor`). Injects the
  button on the `ed11yPop` event, overrides the `aiRequest` AJAX command to stream into a custom
  preview, builds the diff, and applies the fix via CKEditor's model.
  See [integration/behavior.md](integration/behavior.md).
- **Config** object `ai_editoria11y.settings` (schema `config/schema/`, defaults `config/install/`):
  `enabled`, `button_label`, `debug`, `prompts.system`, `prompts.user`. Also declares the CKEditor
  plugin config schema `ckeditor5.plugin.ai_ckeditor_ai.ai_editoria11y_fix`.
- **Permission** (`ai_editoria11y.permissions.yml`): `use ai editoria11y`
  ("Use AI to fix accessibility issues", not restricted) — gates library attachment in the
  `hook_element_info_alter()` after-build.
- **Hook** `ai_editoria11y_element_info_alter()` (`ai_editoria11y.module`): attaches the library +
  `drupalSettings.aiEditoria11y` (enabled, buttonLabel, `ai_ckeditor.dialog` URL) to a text_format
  element only when the active ckeditor5 format has the `ai_editoria11y_fix` plugin enabled and the
  user holds the permission.
- **Tests** (`tests/src/Kernel/`): plugin, library-attachment and uninstall kernel tests.

## Solution docs

- [plugins/fix-accessibility.md](plugins/fix-accessibility.md) — the AiCKEditor plugin, config
  form, prompt building, generate/save flow.
- [integration/behavior.md](integration/behavior.md) — the JS: supported tests, button injection,
  streaming preview, diff, applying the fix.
