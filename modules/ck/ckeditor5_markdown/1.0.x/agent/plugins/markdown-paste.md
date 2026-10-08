<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# markdownPaste.MarkdownPaste — Paste Markdown button

Source: `js/ckeditor5_plugins/markdownPaste/src/markdownpaste.js` (entry `index.js` re-exports it as `MarkdownPaste`). Compiled to `js/build/markdownPaste.js`. Declared to CKEditor in `ckeditor5_markdown.ckeditor5.yml`.

## Registration

`ckeditor5_markdown.ckeditor5.yml` maps drupal plugin id `ckeditor5_markdown_paste` to CKEditor plugin `markdownPaste.MarkdownPaste`, exposes toolbar item `markdownPaste` (label "Paste Markdown"), and sets `elements: false` — the plugin adds **no** entries to the format's allowed-tags set, so it never widens the text format's HTML restrictions. Libraries: `library: ckeditor5_markdown/markdownPaste`, `admin_library: ckeditor5_markdown/markdownPasteAdmin` (`ckeditor5_markdown.libraries.yml`).

## Class (`MarkdownPaste extends Plugin`)

- `static get pluginName()` → `'MarkdownPaste'`.
- `init()` registers UI component `markdownPaste`: a `ButtonView` (label "Paste Markdown", the `icons/markdown.svg` icon, tooltip on). Its `execute` handler calls `_openDialog()`.
- `_openDialog()` builds a plain-DOM modal appended to `document.body`: `.markdown-paste-overlay` (`role="dialog"`, `aria-modal="true"`) containing `.markdown-paste-dialog` with an `<h3>` title, a `.markdown-paste-textarea` (`spellcheck=false`, 15 rows), and Cancel / Insert buttons. Any pre-existing overlay is removed first. An `AbortController` wires up close-on-Escape (`keydown`) and close-on-backdrop-click; `close()` removes the overlay and aborts the listeners. Text is set via `textContent`/`setAttribute` (not innerHTML), so the chrome carries no injection surface.
- `_insertMarkdown(markdown)` — the conversion. `marked.parse(markdown, { gfm: true, breaks: false })` produces an HTML string, then:
  - `editor.data.processor.toView(html)` parses it into a CKEditor **view** fragment,
  - `editor.data.toModel(viewFragment)` converts to a **model** fragment,
  - `editor.model.change(() => editor.model.insertContent(modelFragment))` inserts at the selection.

Insert trims the textarea and only converts when non-empty; then the dialog closes.

## Conversion boundary (important for behavior)

Conversion is **100% client-side**; the module is not a server-side filter and does not touch stored values on its own. Because the Markdown HTML goes through `toView` → `toModel`, only elements the editor's currently loaded plugins/schema understand survive into the document — anything else is dropped by CKEditor rather than rendered. When the content is saved, it is still run through the text format's normal filter pipeline like any other CKEditor output. Practical consequence (per README): Markdown whose target tag is not enabled in that format is silently discarded (e.g. `# Heading` needs the Heading plugin with `h1` allowed).

## Operate it

1. `drush en ckeditor5_markdown` (or via the UI). Only dependency is core `ckeditor5`.
2. Edit a CKEditor 5 text format (`/admin/config/content/formats/manage/<format>`) and drag **Paste Markdown** into the active toolbar; save.
3. In the editor, place the cursor, click the button, paste/type Markdown, click **Insert** (Escape or backdrop click cancels).

## Rebuild the asset

Source lives under `js/ckeditor5_plugins/markdownPaste/src/`; `js/build/markdownPaste.js` is the Webpack bundle (marked is bundled in). Rebuild with `npm install && npm run build` (see `webpack.config.js`, `package.json`).
