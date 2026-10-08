<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Remove Div (ckeditor_remove_div) — agent index

A small, **entirely client-side** CKEditor 5 plugin that adds a **"Remove Div"** toolbar button.
Clicking it removes the `<div>` that contains the cursor (nearest `div` ancestor of the selection),
lifting the div's children up to where the div was so the surrounding structure is preserved. Package
`CKEditor`. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Installed **2.0.1-rc1** (version dir
`2.0.x`). Not covered by the security advisory policy; minimally maintained.

## Dependencies

- Drupal modules: **`ckeditor5`** (core) only (`.info.yml`). No composer requirements beyond Drupal.
- No PHP: the module ships **no `.php` files, no routing, no services, no permissions, no config
  schema, no `.module`/`.install`**. It is a JS plugin plus YAML wiring and an icon.

## What it provides (from source)

- **CKEditor 5 plugin definition** `ckeditor_remove_div_plugin` (`ckeditor_remove_div.ckeditor5.yml`):
  registers CKEditor plugin `removeDivPlugin.RemoveDiv`, toolbar item `RemoveDiv` (label "Remove
  Div"), and declares `elements: [ <div> ]` — i.e. enabling the button makes `<div>` an allowed tag
  in that text format's CKEditor 5 filter config.
- **Libraries** (`ckeditor_remove_div.libraries.yml`): `ckeditor_remove_div` loads the built plugin
  JS `js/build/removeDivPlugin.js` (depends on `core/ckeditor5`); `admin.ckeditor_remove_div` loads
  `css/ckeditor_remove_div.admin.css`, which sets the toolbar button's icon
  (`icons/eraser.svg`, an eraser SVG) in the text-format config UI.
- **JS source** under `js/ckeditor5_plugins/removeDivPlugin/src/` (built to `js/build/` via
  `webpack.config.js` using the CKEditor5 DLL):
  - `index.js` — exports `{ RemoveDiv }`.
  - `removediv.js` — `RemoveDiv` Plugin, `pluginName='RemoveDiv'`, `requires` `RemoveDivEditing` +
    `RemoveDivUI`.
  - `removedivediting.js` — registers the `removeDiv` editor command.
  - `removedivui.js` — adds the `removeDiv` `ButtonView` (eraser icon, tooltip); on click runs
    `editor.execute('removeDiv')` then refocuses the editing view.
  - `removedivcommand.js` — the command. `refresh()` enables it only when a selection ancestor's
    model element name matches (case-insensitive `.includes('div')`). `execute()` finds that div
    ancestor: if it holds only text nodes it becomes a `paragraph`; otherwise its direct children are
    moved (in reverse) to the position before the div; then the div element is removed.

## Behaviour notes / gotchas

- Div detection is a loose substring match on the **model element name** (`name.toLowerCase()
  .includes('div')`), which relies on core's General HTML Support / `<div>` allowance producing a
  model element whose name contains "div" (e.g. `htmlDiv…`). No effect on non-div content.
- Removing the button from a format's toolbar removes `<div>` from that format's plugin-contributed
  allowed elements (standard CKEditor 5 plugin `elements` behaviour).
- No settings form and no admin page — configuration is only "add the button to a CKEditor 5
  toolbar" at `/admin/config/content/formats`. `data.json.configure` is null; there is no config
  schema (`provides_config_schema: false`).

## Security / trust

Purely client-side editor UX. Output still passes through the text format's filters on save; the
plugin has no server route, permission, upload, or external call. Nothing content- or
access-sensitive. (Reviewer notes kept out of public docs.)
