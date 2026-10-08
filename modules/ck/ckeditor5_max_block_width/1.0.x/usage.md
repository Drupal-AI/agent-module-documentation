<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor 5 max block width gives editors a toolbar dropdown to set how wide a block element renders — regular, wide, or full — by toggling a fixed CSS class on the element, without leaving the WYSIWYG.

The module ships a single CKEditor 5 JS plugin (`maxWidth.MaxWidth`) exposed as the `maxWidth` toolbar item labelled "Block width". Choosing an option sets a model attribute that downcasts to exactly one of two classes (`max-w-wide` or `max-w-full`) — "Regular width" removes both. The plugin declares the tags allowed to carry a `class` for this feature (`<table class>`, `<img class>`, `<drupal-media class>`), which Drupal merges into the text format's allowed HTML. A `hook_page_attachments` hook loads the `styles` CSS library so the width classes take visual effect on rendered content, while an editor CSS library styles the widget inside CKEditor. Actual widths are defined as CSS custom properties (`--max-w-regular: 740px`, `--max-w-wide: 1032px`, `--max-w-full: 100%`) that a theme can override; content must sit inside a `.max-w-container` wrapper for the front-end styles to apply.

Setup is per text format only: enable a CKEditor 5-based format, drag the "Block width" button into its toolbar, and ensure the tags/classes are permitted. There are no routes, permissions, services or configuration forms of the module's own — behaviour is entirely the CKEditor 5 plugin plus its CSS.
---
Add the "Block width" button to a CKEditor 5 toolbar; editors then set regular/wide/full width per block (table, image, media) via a CSS class.
---
- Let editors mark an image as full-width from the toolbar
- Make a table span a wide content column
- Set a media embed (`<drupal-media>`) back to regular width
- Provide breakout / full-bleed layouts from the WYSIWYG
- Apply width via a fixed class instead of hand-edited inline styles
- Add the Block width control to a specific text format's toolbar
- Allow the `class` attribute on `<img>` for width styling
- Allow the `class` attribute on `<table>` for width styling
- Allow the `class` attribute on `<drupal-media>` for width styling
- Load front-end CSS so `max-w-wide` / `max-w-full` classes actually render
- Give editors a small, consistent set of width presets
- Override `--max-w-regular` / `--max-w-wide` / `--max-w-full` in a theme to retune widths
- Wrap a body field in `.max-w-container` so preset widths take effect
- Avoid custom source-HTML editing for common width tweaks
- Keep width choices within the text format's allowed-HTML sandbox
- Preserve width choices across edit sessions (upcast + downcast round-trip)
- Set width on inline images sitting inside a paragraph
- Standardize breakout widths across many pieces of content on a site
