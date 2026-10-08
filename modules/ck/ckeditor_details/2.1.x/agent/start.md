<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Accordion (Detail Plugin) — agent index

Adds an **"Add accordion"** button to CKEditor 5 that inserts a native HTML5
`<details>`/`<summary>` accordion. No module config (`configure: null`); everything is per text
format.

- **Add the accordion button to a CKEditor 5 text format; where it is stored; allowed HTML** →
  [configure/toolbar.md](configure/toolbar.md)

Key facts:
- CKEditor 5 plugin id `ckeditor_details_detail` (JS `detail.Detail`); **toolbar item `detail`**
  (label "Add accordion"). Declared in `ckeditor_details.ckeditor5.yml`.
- Inserted elements: `<details>`, `<summary>`, `<div>`, `<div class="details-wrapper">`.
- Enabling = add `detail` to a format's editor toolbar → stored in
  `editor.editor.<format>` at `settings.toolbar.items`; the format's `filter_html` must allow the
  `<details>`/`<summary>` tags.
- Legacy support: a CKEditor 4 `CKEditorPlugin` (`detail`) and a `CKEditor4To5Upgrade` plugin
  (`ckeditor_details`) that maps the old `detail` button to the new `detail` toolbar item.
- Depends only on core CKEditor 5. No permissions, no Drush, no config schema, no plugin types.
