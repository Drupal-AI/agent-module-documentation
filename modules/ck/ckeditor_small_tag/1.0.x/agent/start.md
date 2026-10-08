<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Small Tag — agent index

Adds one CKEditor 5 toolbar button ("Small") that toggles a `<small>` element around the selection,
like Bold/Italic. Pure CKEditor 5 plugin + YAML; depends on core `ckeditor5`. No settings page
(`configure` null), no permissions, no schema, no Drush, no PHP services.

- **Add the button to a format's toolbar, the `<small>` allowed-tag behavior, plugin internals** →
  [configure/toolbar.md](configure/toolbar.md)

Key facts:
- Plugin definition `ckeditor_small_tag.ckeditor5.yml`: id `smallPlugin.Small`, toolbar item `small`
  (label "Small"), declares `elements: [ <small> ]`.
- JS libraries `ckeditor_small_tag/small` (editor) and `ckeditor_small_tag/admin.small` (toolbar
  icon CSS); build at `js/build/smallPlugin.js`, sources in `js/ckeditor5_plugins/smallPlugin/src/`.
- No global config — enable per text format via the CKEditor 5 toolbar builder.
