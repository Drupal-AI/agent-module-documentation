<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 5 Custom Paste (ckeditor5_custom_paste) — agent index

A CKEditor 5 plugin that rewrites clipboard input on paste, flattening pasted content to plain
paragraphs. Configured per text format. Depends on core `ckeditor5`. Version **1.0.3** (2024).
Core requirement `^9.3 || ^10 || ^11`. License GPL-2.0-or-later.

## What it actually does
- Registers one CKEditor 5 plugin, `pasteFilter.PasteFilter` (PHP definition
  `\Drupal\ckeditor5_custom_paste\Plugin\CKEditor5Plugin\PasteFilter`), library
  `ckeditor5_custom_paste/custom_paste_filter` (built file `js/build/pasteFilter.js`).
- On paste, the JS listens to `ClipboardPipeline`'s `inputTransformation` event. When enabled it
  serialises the pasted content to HTML, then **replaces every tag with a `</p><p>` boundary**,
  keeps only `<br>`, wraps the result in `<p>…</p>`, and drops empty paragraphs. Net effect: all
  inline formatting (bold, links, spans, fonts, colours, inline styles) and block structure
  (headings, lists, tables) is discarded — the text arrives as plain paragraphs.
- This is **not** a selective Word/Docs cleanup that preserves semantic headings or table shape.
  It is closest to "paste as plain paragraphs."

## Configuration (per text format)
- The plugin has **no toolbar button and no conditions**, so its settings tab appears on every
  CKEditor 5 text format. Editing a format (Configuration > Content authoring > Text formats and
  editors) shows a **Ckeditor 5 Custom Paste** vertical tab.
- Settings: `enabled` (checkbox "Enable CKEditor5 custom paste") and `excluded_tags`
  (comma-separated tag names). Config schema key `ckeditor5.plugin.ckeditor5_custom_paste_pasteFilter`.
- Paste filtering runs **only when the checkbox is ticked**; the plugin is otherwise loaded but inert.

## Two things to keep straight
1. **Editorial hygiene, not a security control.** The plugin runs **in the browser** and is
   bypassed by the source-editing button or any API write. The security boundary for pasted markup
   is the **text format's server-side filter chain** (`filter_html` etc.), applied on **render**,
   regardless of how the markup entered the field. Never let this substitute for a correct
   `filter_html`.
2. **Filtering is a full flatten.** An editor who pastes a formatted table gets plain paragraphs.
   Expect to re-format deliberately afterward.

## Known caveat in 1.0.3
The **Excluded tags** field is effectively **inert** in this release: the PHP publishes the list at
`pastefilter.excluded_tags` (via `getDynamicPluginConfig`), but the JavaScript reads it from the
top-level key `editor.config.get('excluded_tags')`, which is never set — so it always resolves to an
empty list and **every** tag is flattened regardless of what is entered. Do not rely on tag
exclusion working until this is fixed upstream.

## Files
- `../data.json` — metadata (categories, deps, version).
- `../usage.md` — short / dense / use-case bullets.
- `ckeditor5/paste-filter.md` — mechanism, config, and the excluded-tags caveat in detail.
