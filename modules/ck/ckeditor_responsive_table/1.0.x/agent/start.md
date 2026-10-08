<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 5 Responsive Table — agent index

Adds a **"Responsive Table"** button (`customTable` toolbar item) to CKEditor 5 that inserts
accessible, mobile-stacking tables. Enable it per text format; a separate admin form tunes
the front-end responsive script.

- **Add the button to a text format's CKEditor 5 toolbar (enable per format)** →
  [configure/editor-toolbar.md](configure/editor-toolbar.md)
- **Module settings form + `ckeditor_responsive_table.settings` config keys** →
  [configure/settings.md](configure/settings.md)

Key facts:
- CKEditor 5 plugin declared in `ckeditor_responsive_table.ckeditor5.yml`
  (group `ckeditor_responsive_table_custom`); toolbar item id **`customTable`**.
- Enabling stores `customTable` in the editor's `settings.toolbar.items`
  (config `editor.editor.<format>`).
- `info.yml` has **no `configure` key**, so `configure` is `null` even though the settings
  form exists at route `ckeditor_responsive_table.form`
  (`/admin/config/content/ckeditor-responsive-table`, permission `administer site configuration`).
- Front-end script attached on non-admin routes via `hook_page_attachments()`.
