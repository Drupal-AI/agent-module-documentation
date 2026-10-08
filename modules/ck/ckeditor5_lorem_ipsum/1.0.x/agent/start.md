<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor5 Lorem Ipsum Plugin (ckeditor5_lorem_ipsum) — agent index

A CKEditor 5 toolbar **dropdown** that inserts one or more paragraphs of Lorem Ipsum
placeholder text at the cursor. Text is generated **client-side** from a fixed word list in
the plugin JS — no server call, no external service. Package `CKEditor5`. Depends only on core
**`ckeditor5`**. Core requirement `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.2.

- **The plugin, how to enable it on a text format, and how insertion works** →
  [plugins/lorem-ipsum.md](plugins/lorem-ipsum.md)

## What it actually is

- One CKEditor 5 plugin definition, `ckeditor5_lorem_ipsum_loremIpsum`, in
  `ckeditor5_lorem_ipsum.ckeditor5.yml`. Its Drupal plugin class is
  `src/Plugin/CKEditor5Plugin/LoremIpsum.php` — an **empty** subclass of core
  `CKEditor5PluginDefault` (no PHP behavior; marked `@internal`). `elements: false`, so it
  registers **no new HTML elements/attributes** and does not widen a format's allowed HTML.
- Toolbar item `loremIpsum` (label *"Lorem Ipsum"*). Front-end code lives in the built asset
  `js/build/loremIpsum.js` (library `ckeditor5_lorem_ipsum/ckeditor5_lorem_ipsum`); admin CSS
  `css/loremIpsum.css` via `ckeditor5_lorem_ipsum_admin`.
- **No** routes, permissions, services, config forms, config/install, config/schema, or Drush.
  The only PHP hook is `ckeditor5_lorem_ipsum_help()` in the `.module` file (a help.page string).

## Mechanism (from source)

- The JS defines a `loremIpsum` dropdown (`createDropdown`) whose list items pass a
  `numParagraphs` value, and a `loremIpsum` **command** whose `execute({numParagraphs})` calls
  `_generateLoremIpsum()`, joins paragraphs with a `[PARAGRAPH_SEPARATOR]` marker, splits on it,
  and for each part does `writer.createElement('paragraph')` + `writer.createText(part)` +
  `model.insertContent(...)`. Text is inserted as **plain text nodes** in paragraph elements.
- `_generateLoremIpsum()` builds strings from a **hardcoded word array** in the JS (starts
  `["Lorem","ipsum","Innovation","technology",…]`) — not a fetch, not classic-only lorem text.

## Enable it

Enable the module (`drush en ckeditor5_lorem_ipsum`), then at *Admin → Config → Content
authoring → Text formats and editors*, edit a CKEditor 5 format and drag the **Lorem Ipsum**
button into the active toolbar. See [plugins/lorem-ipsum.md](plugins/lorem-ipsum.md).
