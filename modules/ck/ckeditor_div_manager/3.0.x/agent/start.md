<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Div Manager — agent index

Pure CKEditor 5 JS plugin. Adds one toolbar button that inserts a `<div>` container with
optional class/id/title/lang/style. **No PHP, no config schema, no permissions, no Drush, no
`configure` route.** All state is per text format (an `editor.editor.<format>` config entity).

- **Enable the button on a text format, allowed tags, config structure** →
  [configure/text-format.md](configure/text-format.md)
- **What the JS plugin actually does (model, converters, command, UI)** →
  [api/plugin-behavior.md](api/plugin-behavior.md)

Key facts:
- Toolbar item id: **`DivManager`** (label "Div Manager"). Add it to
  `editor.editor.<format>` → `settings.toolbar.items`.
- CKEditor 5 plugin id: `divManagerPlugin.DivManager`; Drupal plugin definition id
  `ckeditor_div_manager_plugin`.
- Grants elements `<div>` and `<div class="simple-box-description">`; needs filter_html to
  allow `<div>` (with `class id title` for the extra attributes).
- Depends on `drupal:ckeditor5`. Legacy Composer dep on `drupal-ckeditor-libraries-group/div`
  (CKEditor 4 library) is unused by the 3.0.x CKEditor 5 build.
