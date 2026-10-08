<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor5 Fullscreen — agent index

Adds one CKEditor 5 toolbar button, **`Fullscreen`**, that expands the editor to fill the
browser viewport. No settings form, no configure route, no permissions, no Drush, no config
schema, no field type or plugin *type*. Its entire persistent state is the string
`Fullscreen` inside a text format's CKEditor 5 toolbar items.

- **Add/remove the fullscreen button on a text format's toolbar, and where that choice is
  stored** → [configure/enable-fullscreen.md](configure/enable-fullscreen.md)
- **How the fullscreen overlay is styled (`data-fullscreen` attribute, z-index, overriding
  it in a theme)** → [theming.md](theming.md)

Key fact: the toolbar item id is exactly `Fullscreen` (capital F, as declared in
`ckeditor5_fullscreen.ckeditor5.yml` → `drupal.toolbar_items`). It lives in
`editor.editor.<format>` → `settings.toolbar.items`, alongside the format's other CKEditor 5
buttons (e.g. `bold`, `italic`).
