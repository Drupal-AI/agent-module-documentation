<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LaTeX Toolbar — settings

## Configure the selector
1. Go to **Configuration → Content authoring → LaTeX Toolbar** (`/admin/config/content/texbar`, permission `administer texbar`).
2. Enter the **Textarea jQuery Selector** that should receive the toolbar (a default HTML id is pre-filled). Examples: `#edit-body-0-value`, `.js-text-full`.
3. Save — the form flushes all caches so the new selector takes effect immediately.

## How it attaches
`texbar_page_attachments()` adds `texbar/markitup` and `texbar/texbar` libraries and sets `drupalSettings.texbar.selector` on every page; the JS binds the LaTeX button set to matching textareas. Because it loads sitewide, keep the selector narrow.

## Assets / Drush
Button sets live in `sets/`; `texbar.codemirror_modes.yml` lists CodeMirror modes. The `LibraryBuilder` service composes the library. The Drush command service `texbar.commands` (library discovery + HTTP client + state + time) can fetch/build the third-party editor assets.

## Rendering
Texbar only inserts LaTeX source into the field. To display rendered math, add a separate renderer (MathJax/KaTeX) via a text filter or theme.
