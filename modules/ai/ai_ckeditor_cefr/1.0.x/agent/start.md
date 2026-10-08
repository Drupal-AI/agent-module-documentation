<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI CKEditor CEFR (ai_ckeditor_cefr) — agent index

A single **AI CKEditor plugin** that rewrites selected CKEditor 5 text to a chosen **CEFR level**
(A1–C2). Package `AI`. Version 1.0.0 (dir `1.0.x`). Core `^10.4 || ^11`. License GPL-2.0-or-later.

- **The plugin, its config keys, the prompt template, and the rewrite flow** →
  [plugins/cefr_level.md](plugins/cefr_level.md)

## What it actually is

- One plugin class: `CefrLevel` (id **`ai_ckeditor_cefr`**, label *"CEFR level"*) in
  `src/Plugin/AiCKEditor/CefrLevel.php`, extending `Drupal\ai_ckeditor\AiCKEditorPluginBase` and
  declared with the `#[AiCKEditor(...)]` attribute (`module_dependencies: ['taxonomy']`).
- It is a plugin **of the `ai_ckeditor` plugin type** — this module defines **no routes, no
  controllers, no services, no permissions, no menu links, no hooks, no libraries**. The dialog and
  the AI request endpoint belong to the parent `ai_ckeditor` module (route
  `ai_ckeditor.do_request`, gated by permission **`use ai ckeditor`**).
- Dependencies: `ai:ai_ckeditor` and core `drupal:taxonomy`.

## Config schema (only config it provides)

- `config/schema/ai_ckeditor_cefr.schema.yml` extends `ckeditor5.plugin.ai_ckeditor_ai_base` with
  keys **`default_level`** (string), **`protected_terms_vocabulary`** (string), **`prompt`** (text).
  These are stored inside the text format's editor settings, not in a standalone config object.
  No settings route of its own; configured on the CKEditor 5 text-format form.

## Mechanism (from source)

- `defaultConfiguration()` sets `provider = NULL`, `default_level = 'B1'`,
  `protected_terms_vocabulary = ''`, and a long default `prompt` template.
- `ajaxGenerate()` reads the dialog values, substitutes `{{ level }}`, `{{ level_style_target }}`
  (from `getLevelStyleTarget()`), and `{{ protected_words_instruction }}` (built from the selected
  vocabulary's `loadTree()` term names), appends the selected text, and dispatches an
  `AjaxResponse` carrying `Drupal\ai_ckeditor\Command\AiRequestCommand` — the parent module then
  calls the configured drupal/ai chat provider and streams the result into `#ai-ckeditor-response`.
- Levels: `getLevelOptions()` = A1–C2. Errors are logged to the `ai_ckeditor` channel.

## Notes

- No standalone admin page; enable and configure the plugin on a CKEditor 5 text format where the
  AI CKEditor (`ai_ckeditor_ai`) integration is active. See
  [plugins/cefr_level.md](plugins/cefr_level.md).
