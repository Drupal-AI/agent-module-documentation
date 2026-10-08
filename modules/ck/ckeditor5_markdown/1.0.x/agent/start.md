<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor5 Markdown (ckeditor5_markdown) — agent index

A CKEditor 5 toolbar button ("Paste Markdown") that converts pasted/typed Markdown to HTML with the bundled `marked` library and inserts it into the editor. **Purely client-side** — the module ships no PHP.

- **Version:** 1.0.x · **Core:** `^10.3 || ^11 || ^12` · **Package:** CKEditor5 · **License:** GPL-2.0-or-later
- **Dependency:** core `ckeditor5` (`dependencies: drupal:ckeditor5` in `ckeditor5_markdown.info.yml`).
- **Bundled JS lib:** `marked` `^9.0.0` (MIT), compiled into `js/build/markdownPaste.js` via Webpack.

## What it provides

- **One CKEditor 5 plugin** declared in `ckeditor5_markdown.ckeditor5.yml`: `markdownPaste.MarkdownPaste`, toolbar item `markdownPaste` (label "Paste Markdown"), `elements: false` — it declares **no new allowed HTML tags**.
- **Two libraries** (`ckeditor5_markdown.libraries.yml`): `markdownPaste` (the built JS + `css/markdown_paste.css`, depends on `core/ckeditor5`) and `markdownPasteAdmin` (`css/markdown_paste.admin.css`, referenced as `admin_library`).
- **No PHP surface:** no `*.module`/`*.install`, routes, permissions, services, hooks, config schema, `config/install`, or database. `configure` is null.

## Solution docs

- **The plugin: dialog flow, conversion pipeline, and setup** → [plugins/markdown-paste.md](plugins/markdown-paste.md)

## Setup (one step)

Enable the module, then edit a CKEditor 5 text format at `/admin/config/content/formats/manage/<format>` and drag **Paste Markdown** into the active toolbar. Conversion is what the editor's enabled plugins accept; the saved value is still processed by the format's filters. Access is governed by who may use that text format.
