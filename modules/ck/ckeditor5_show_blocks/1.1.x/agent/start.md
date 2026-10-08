<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 5 Show Blocks (ckeditor5_show_blocks) — agent index

Adds a CKEditor 5 toolbar button that outlines every **block-level element** in the editing
area and labels each with its tag name. Version **1.1.1**. Core `^9 || ^10 || ^11`. Depends only
on the core `ckeditor5` module. GPL-2.0-or-later. No configuration UI, no routes, no permissions
of its own, no config schema, no Drush commands.

## What it actually is

A thin Drupal wrapper around CKEditor 5's **built-in ShowBlocks plugin** — it ships no editor
logic of its own:

- `ckeditor5_show_blocks.ckeditor5.yml` declares one CKEditor 5 plugin that maps the CKEditor
  package plugin `showBlocks.ShowBlocks` to a Drupal toolbar item named `showblocks` (label
  "Show Blocks"), with `elements: false` — it adds **no new allowed HTML tags/attributes**, so it
  never touches the text format's filtering or the stored markup.
- `js/ckeditor5_plugins/showblocks/src/index.js` simply re-exports `showBlocks` from
  `@ckeditor/ckeditor5-show-blocks`; the compiled bundle is `js/build/show-blocks.js`, served
  **locally** (library `ckeditor5_show_blocks/showblocks`, dependency `core/ckeditor5`) — no CDN.
- `css/showblocks.css` (the `showblocks` theme library) draws the dashed outlines and the tag-name
  labels once the plugin has added the `ck-show-blocks` class to the editable area. It styles
  `address`, `aside`, `blockquote`, `details`, `div`, `footer`, `h1`–`h6`, `header`, `main`, `nav`,
  `pre`, `ol`, `ul`, `p`, `section`, and figure `figcaption` — widgets are excluded.
- `css/showblocks.admin.css` + `icons/marker.svg` give the toolbar button its icon in the
  text-format admin UI (`.ckeditor5-toolbar-button-showblocks`).
- `ckeditor5_show_blocks.module` implements only `hook_help()`.

## How to enable it

1. Enable the module (it requires core `ckeditor5`).
2. Go to **admin/config/content/formats**, edit a text format that uses the CKEditor 5 editor.
3. Drag the **Show Blocks** button from the available items onto the format's active toolbar and
   save. (This configuration is gated behind the core **"administer filters"** permission.)
4. When editing content in that format, click the Show Blocks button to toggle the outlines on and
   off. It is a **view toggle** — nothing is saved, nothing changes in the output HTML.

## What it closes

A WYSIWYG shows what text **looks like** and hides what it **is** — the source of most markup
problems on a content-managed site:
- a "heading" that is a **bold 18pt paragraph** — absent from tables of contents, skipped by
  screen-reader heading navigation, worth nothing to search;
- **empty paragraphs as spacers**, invisible until the design changes;
- nested lists that are really **two separate lists**;
- a blockquote that is an **indented paragraph** and has lost its meaning.

Its most common use is **accessibility remediation**: it turns an abstract audit finding
(*"heading levels are used inconsistently"*) into something an editor can see and correct on the
page they are editing. But note it **shows structure, not correctness** — an `h3` after an `h1` is
visible as an `h3`; whether that is a skipped level remains the editor's judgement. Pairs naturally
with an accessibility checker rather than replacing one.

## Files (on disk)

- `ckeditor5_show_blocks.info.yml` — deps: `drupal:ckeditor5`; `package: CKEditor 5`.
- `ckeditor5_show_blocks.ckeditor5.yml` — the CKEditor 5 plugin + toolbar item definition.
- `ckeditor5_show_blocks.libraries.yml` — `showblocks` (JS build) and `admin.showblocks` / theme CSS.
- `ckeditor5_show_blocks.module` — `hook_help()` only.
- `js/build/show-blocks.js` — compiled CKEditor 5 plugin bundle (minified, local).
- `js/ckeditor5_plugins/showblocks/src/index.js` — re-export of the upstream `showBlocks` plugin.
- `css/showblocks.css`, `css/showblocks.admin.css`, `icons/marker.svg`.

No `config/`, no routing, no controllers, no services, no schema.
