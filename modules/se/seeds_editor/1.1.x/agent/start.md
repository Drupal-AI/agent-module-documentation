<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Seeds Editor (seeds_editor) — agent index

Editor layer of the **Seeds distribution**: on install it creates ready-made text formats and their
bound editors (CKEditor 5 + ACE) and pulls in ~12 contrib editor modules. Version **1.1.14**.
Core `^10 || ^11`. Package `Seeds`. License GPL-2.0-or-later.

The module's own PHP is tiny — three hooks and one config form. Almost all of its value is the
**shipped configuration** in `config/install` and `config/optional`.

## What it actually provides

- **Text formats + editors** (`config/install`, always created): `simple_editor` (CKEditor 5,
  restricted `filter_html`) and `advanced_editor` (ACE source-code editor, no `filter_html`).
- **Optional** (`config/optional`, created only when deps present): `basic_editor` (full CKEditor 5
  — media embed, Linkit, entity_embed, ckeditor_media_resize, style dropdown, tables).
- **One route/form**: `seeds_editor.config` → `/admin/config/content/seeds-editor`
  (`SeedsEditorConfigForm`), permission **`administer seeds editor`** (`restrict access: true`).
  Menu link `seeds_editor.settings` under `system.admin_config_content`.
- **Config object**: `seeds_editor.settings` — keys `load_ckeditor_styles` (bool),
  `ckeditor_ltr_style`, `ckeditor_rtl_style` (CSS paths). No config schema shipped.
- **Three hooks** in `seeds_editor.module`: `hook_library_info_alter()` (defines `ltr_css`/`rtl_css`
  libraries), `hook_ckeditor_css_alter()`, `hook_field_widget_complete_form_alter()` — all load the
  direction-matching custom stylesheet into CKEditor / textarea widgets.
- No entities, no plugins, no services, no Drush, no update hooks.

## Dependencies (17)

Core: `ckeditor5`, `editor`, `filter`, `image`, `media`, `media_library`. Contrib: `ace_editor`,
`allowed_formats`, `smart_trim`, `blazy`, `editor_advanced_link`, `entity_embed`, `linkit`,
`ckeditor_bidi`, `ckeditor5_plugin_pack`, `media_embeddable`, `ckeditor_responsive_table`,
`ckeditor_media_resize`.

## Solution docs

- **Settings form, config object, and the LTR/RTL custom-CSS hooks** →
  [config/settings.md](config/settings.md)
- **The installed text formats and editors (simple / advanced / basic) — what each enables** →
  [config/text-formats.md](config/text-formats.md)
