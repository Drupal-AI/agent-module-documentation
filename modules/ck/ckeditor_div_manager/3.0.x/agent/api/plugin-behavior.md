<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Div Manager — CKEditor 5 plugin behavior

Source: `js/ckeditor5_plugins/divManagerPlugin/src/` (built to `js/build/divManagerPlugin.js`).
This is client-side only; there is no server API. Summary so you need not read the JS.

## Composition

`DivManager` (`divmanager.js`) requires two plugins:

- **`DivManagerEditing`** (`divmanagerediting.js`) — schema + converters + the command.
- **`DivManagerUI`** (`divmanagerui.js`) — the toolbar button and pop-up form.

## Model & conversion (`DivManagerEditing`)

- Registers a model element **`divContent`** (`inheritAllFrom: '$inlineObject'`,
  `allowContentOf: '$root'`, allowed attributes: `class`, `title`, `id`, `lang`, `style`).
- **Upcast**: an existing `<div class="simple-grid">` in the HTML becomes a `divContent`
  model element (so previously inserted containers re-open as editable).
- **Downcast**: `divContent` renders to a `<div>` carrying only the non-empty attributes
  among class/title/id/lang/style.
- Registers the editor command **`addDiv`**.

## Command (`divmanagercommand.js`)

`editor.execute('addDiv', { title, content, langcode, className, rawStyles })` creates a
`divContent` element with `class=className`, `lang=langcode`, `style=rawStyles`, `title=title`,
inserts the `content` text inside it, and drops it at the selection. `refresh()` always sets
`isEnabled = true`.

## UI (`divmanagerui.js`)

- Registers a `ButtonView` in the component factory (label "DIV").
- Clicking opens a `ContextualBalloon` with a form (`DivManagerView`) whose fields are:
  **content**, **title**, **id**, **class**, **langcode (lang)**, **style (rawStyles)**.
- On *Save* it calls `addDiv` with those values and hides the balloon; *Cancel* / click-outside
  just closes it. If the selection is non-collapsed, the content input is disabled and seeded
  with the selected text.

## What ends up in the saved HTML

A `<div>` with the attributes you set, e.g.:

```html
<div class="callout" id="intro" title="Intro" lang="en" style="margin:1em;">Your text</div>
```

Whether class/id/title actually persist depends on the format's filter_html allow-list
(see [configure/text-format.md](../configure/text-format.md)).
