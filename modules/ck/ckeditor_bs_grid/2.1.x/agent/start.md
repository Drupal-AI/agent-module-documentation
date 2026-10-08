<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Bootstrap Grid — agent index

One CKEditor 5 plugin (`ckeditor_bs_grid_grid`, toolbar item **`bootstrapGrid`**) that inserts
Bootstrap rows/columns into a rich-text field. Depends on core `ckeditor5`.

- **Turn the button on for a text format and set its per-format options** →
  [configure/enable-in-text-format.md](configure/enable-in-text-format.md)
- **The site-wide breakpoint/layout catalogue (`ckeditor_bs_grid.settings`)** →
  [configure/breakpoints-and-layouts.md](configure/breakpoints-and-layouts.md)
- **Routes, dialog steps, theming hooks and the schema alter** →
  [api/dialog-and-hooks.md](api/dialog-and-hooks.md)

Key facts:

- Per-format config: `editor.editor.<format>` → `settings.toolbar.items[]` must contain
  `bootstrapGrid`, and `settings.plugins.ckeditor_bs_grid_grid` holds
  `use_cdn` (bool, default TRUE), `cdn_url`
  (`https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css`),
  `available_columns` (default 1–12) and `available_breakpoints` (default `xs,sm,md,lg,xl,xxl`).
- Site-wide config: `ckeditor_bs_grid.settings` → `breakpoints.<xs|sm|md|lg|xl|xxl>` with
  `label`, `prefix` (`none` for xs, otherwise the Bootstrap infix) and `columns.<1..12>.layouts`.
- Routes: `ckeditor_bs_grid.settings` → `/admin/config/content/ckeditor_bs_grid`
  (permission `administer ckeditor_bs_grid`); `ckeditor_bs_grid.dialog` →
  `/ckeditor_bs_grid/dialog/{editor}` (permission `access content`).
- Allowed elements declared by the plugin: `<div>` and `<div class data-*>` — the format's
  filters must not strip them.
- No Drush, no submodules, no new plugin types (it *implements* core's CKEditor 5 plugin type).
