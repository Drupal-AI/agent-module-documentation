<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Lorem Ipsum CKEditor 5 plugin

The whole module is one CKEditor 5 plugin. This page covers its definition, how to turn it on
for a text format, and exactly what it inserts.

## Install / enable

- `drush en ckeditor5_lorem_ipsum -y` (or enable via *Extend*). Only dependency: core
  **`ckeditor5`** (declared in `ckeditor5_lorem_ipsum.info.yml`). No Composer requirements.
- Per text format: *Admin → Configuration → Content authoring → Text formats and editors*
  (`/admin/config/content/formats`) → edit a **CKEditor 5** format → drag the **Lorem Ipsum**
  toolbar button from *Available* into *Active toolbar*, then save. No other configuration.

## Plugin definition (`ckeditor5_lorem_ipsum.ckeditor5.yml`)

- Plugin id: `ckeditor5_lorem_ipsum_loremIpsum`.
- `ckeditor5.plugins: [ loremIpsum.LoremIpsum ]` — the JS plugin exported by the built asset.
- `drupal.label: Lorem Ipsum`; `class:
  \Drupal\ckeditor5_lorem_ipsum\Plugin\CKEditor5Plugin\LoremIpsum`.
- `library: ckeditor5_lorem_ipsum/ckeditor5_lorem_ipsum` (editor JS);
  `admin_library: ckeditor5_lorem_ipsum/ckeditor5_lorem_ipsum_admin` (admin CSS).
- `elements: false` — the plugin declares **no** managed HTML elements/attributes, so adding it
  to a toolbar does **not** change the format's allowed-HTML/filter settings.
- `toolbar_items.loremIpsum.label: Lorem Ipsum`; `conditions: []` (always available once added).

## PHP side

- `src/Plugin/CKEditor5Plugin/LoremIpsum.php`: `class LoremIpsum extends CKEditor5PluginDefault`
  with an **empty body** — no `getDynamicPluginConfig()`, no `defaultConfiguration()`, no
  config form. All behavior is in JavaScript. Class is annotated `@internal`.
- `ckeditor5_lorem_ipsum.module`: only `hook_help()` for `help.page.ckeditor5_lorem_ipsum`,
  returning the module description string. No other hooks.

## Libraries (`ckeditor5_lorem_ipsum.libraries.yml`)

- `ckeditor5_lorem_ipsum`: loads `js/build/loremIpsum.js`; depends on `core/drupal` and
  `core/ckeditor5`.
- `ckeditor5_lorem_ipsum_admin`: loads `css/loremIpsum.css` (theme group), for the admin UI.

## What it inserts (from `js/build/loremIpsum.js`)

- Registers a toolbar **dropdown** (`componentFactory.add('loremIpsum', …)` via
  `createDropdown`); each list entry carries a `numParagraphs` value. Selecting one runs
  `editor.execute('loremIpsum', { numParagraphs })` and refocuses the editing view.
- The `loremIpsum` **command** (`execute({ numParagraphs = 1 } = {})`) calls
  `_generateLoremIpsum(numParagraphs)`, then inside `model.change(writer => …)`: splits the
  generated string on the literal marker `[PARAGRAPH_SEPARATOR]`, and for each piece creates a
  `paragraph` element (`writer.createElement('paragraph')`) containing a text node
  (`writer.createText(piece)`), appends it, and `insertContent`s it at the selection (or the
  root end if there is no selection). Selection is moved after the last inserted paragraph.
- `_generateLoremIpsum()` composes text from a **hardcoded word array** inside the JS (begins
  `["Lorem","ipsum","Innovation","technology","development","research","science",…]`). Output is
  therefore fixed, in-browser, and inserted as **plain text** — no HTML markup is generated and
  no network request is made.

## Operating notes

- To offer different lengths, the dropdown already exposes multiple `numParagraphs` options;
  there is no admin setting to customize the word list or counts (they are baked into the JS).
- Because `elements: false`, the inserted paragraphs are ordinary `<p>` content already allowed
  by any CKEditor 5 format — nothing to add to *Allowed HTML tags*.
- If the button does not appear, confirm the module is enabled, the format uses the CKEditor 5
  editor (not the legacy CKEditor 4), and clear caches (`drush cr`) so the plugin asset loads.
