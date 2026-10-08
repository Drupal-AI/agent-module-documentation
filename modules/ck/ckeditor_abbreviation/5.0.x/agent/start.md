<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Abbreviation — agent index

A **CKEditor 5 plugin** that adds an **Abbreviation** toolbar button + context-menu item for
wrapping text in `<abbr title="…">`. Almost pure JS: the only PHP is `hook_help()`. No settings
form, no config schema, no permissions, no configure route (`configure: null`). Depends on
`ckeditor5`.

- **Enable the button on a text format, allow `<abbr title>`, and where it's stored** →
  [configure/toolbar.md](configure/toolbar.md)

Key facts (from `ckeditor_abbreviation.ckeditor5.yml`): CKEditor5 plugin id
`ckeditor_abbreviation_abbreviation`; JS plugin `abbreviation.Abbreviation`; **toolbar item id
`abbreviation`**; produces elements `<abbr>` and `<abbr title>`; libraries
`ckeditor_abbreviation/abbreviation` (editor) and `ckeditor_abbreviation/abbreviation.admin`
(config). Enabled by adding `abbreviation` to `editor.editor.<format>` →
`settings.toolbar.items`.
