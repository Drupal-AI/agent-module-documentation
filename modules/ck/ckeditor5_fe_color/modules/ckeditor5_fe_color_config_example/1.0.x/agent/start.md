<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor5 FeColor Config Example (ckeditor5_fe_color_config_example) — agent index

Submodule of **ckeditor5_fe_color**. A working **reference/example** module that registers a
custom FeColor palette and loads editor content CSS via hooks — nothing more. Enable it to see the
recommended customization pattern in action; use it as a copy-paste template for your own module.
Depends on **`ckeditor5_fe_color`**. Core requirement `^10 || ^11`. License GPL-2.0-or-later.
Version 1.0.2 (version-dir `1.0.x`). Parent: [../../../1.0.x/agent/start.md](../../../1.0.x/agent/start.md).

- **The three hooks, the palette it adds, and how to reuse it** →
  [config/example.md](config/example.md)

## What it actually is

- No PHP classes, no routes, no permissions, no services, no config schema of its own. Just
  `ckeditor5_fe_color_config_example.module` (three hook implementations) + `css/ckeditor5.css`.
- `.info.yml` declares `ckeditor5-stylesheets: [ css/ckeditor5.css ]` — the content CSS injected
  into the CKEditor 5 editing view.

## What it does (from source)

- `hook_editor_js_settings_alter()` — sets the FeColor palette for the **`basic_html`** format to
  four colors: Black/White (as in the parent default) plus **Red** (`color-red`) and **Green**
  (`color-green`), each `{label, class, color: var(--color-*)}`.
- `hook_ckeditor5_plugin_info_alter()` — appends `<span class="color-black color-white color-red
  color-green">` to the parent plugin's allowed `elements` so those classes survive HTML filtering.
- `hook_library_info_alter()` — turns the module's `ckeditor5-stylesheets` entries into the
  `internal.drupal.ckeditor5.stylesheets` library so `css/ckeditor5.css` styles the editor.
- `css/ckeditor5.css` defines `--color-black/white/red/green` and `span.color-*` rules (hard-coded
  values, module's own file — no external/remote URLs).

## Operating notes

- Enable this module (pulls in the parent), then add the Fe Font Color button to the `basic_html`
  format's toolbar to see the 4-color palette. To adapt: copy the `.module` + `.info.yml` +
  `css/ckeditor5.css` into your own module, rename the functions, and edit the color list / target
  format.
