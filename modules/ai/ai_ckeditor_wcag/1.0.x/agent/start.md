<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI CKEditor WCAG (ai_ckeditor_wcag) — agent index

A single **AI CKEditor plugin** that asks AI to check selected CKEditor 5 text for **WCAG**
compatibility. Package `AI`. Version 1.0.1 (dir `1.0.x`). Core `^10.3 || ^11`. License
GPL-2.0-or-later.

- **The plugin, its config, and the check flow** → [plugins/wcag.md](plugins/wcag.md)

## What it actually is

- One plugin class: `WCAG` (id **`ai_ckeditor_wcag`**, label *"WCAG"*) in
  `src/Plugin/AICKEditor/WCAG.php`, extending `Drupal\ai_ckeditor\AiCKEditorPluginBase` and declared
  with the `#[AiCKEditor(...)]` attribute.
- It is a plugin **of the `ai_ckeditor` plugin type** — this module defines **no routes, no
  controllers, no services, no permissions, no config schema, no menu links, no hooks, no
  libraries**. The dialog and AI request endpoint belong to the parent `ai_ckeditor` module (route
  `ai_ckeditor.do_request`, gated by permission **`use ai ckeditor`**).
- Dependencies: core `drupal:ckeditor5`, `ai:ai`, `ai:ai_ckeditor`.

## Mechanism (from source)

- `defaultConfiguration()` = `provider`/`wcag_version`/`wcag_level` all `NULL`.
- `buildConfigurationForm()` (plugin settings on the text-format form) adds a **provider** select,
  a **WCAG version** select (1.0/2.0/2.1/2.2, default 2.2) and a **WCAG level** select (A/AA/AAA,
  default AAA). `submitConfigurationForm()` saves them into the format's editor settings.
- `buildCkEditorModalForm()` requires selected text (else shows a "select some text" message),
  shows the selected text disabled, and a `text_format` **response** field bound to the editor's
  own format; the primary button is *"Check the selected text"*.
- `ajaxGenerate()` builds
  `"Check if the content of the following text is in line with WCAG version <version> level <level>
  rules: <selected_text>"` + `"\n\nRespond in the same language as the text."`, then dispatches
  `Drupal\ai_ckeditor\Command\AiRequestCommand($prompt, editor_id, plugin_id, 'ai-ckeditor-response')`.
  The parent `ai_ckeditor` controller runs the drupal/ai chat call and streams the answer into the
  `#ai-ckeditor-response` wrapper. Errors are logged and an inline error string returned.

## Notes

- Provides **no config schema of its own** (settings live in the CKEditor 5 text-format config).
- Runs through the configured **AI provider** (provider usage cost). Advisory only.
- Configure by enabling the plugin on a CKEditor 5 text format with the AI CKEditor integration.
  See [plugins/wcag.md](plugins/wcag.md).
