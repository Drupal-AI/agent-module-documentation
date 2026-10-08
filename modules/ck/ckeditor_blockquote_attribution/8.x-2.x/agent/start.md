<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Blockquote Attribution — agent start

Legacy CKEditor 4 plugin (`@CKEditorPlugin` id `blockquote_attribution`) requiring the `ckeditor` module.
Adds a toolbar button + dialog that wraps a selection in `<figure><blockquote>…</blockquote><figcaption>Source</figcaption></figure>`.

- Allowed content it wants: `figure(quote) blockquote[cite]`; ensure the text format permits figure/figcaption/blockquote.
- Citation typed in the dialog is inserted via CKEditor DOM API and filtered by the text format on output (no unfiltered raw HTML path).
- No routes/permissions/settings form. Key files: `src/Plugin/CKEditorPlugin/BlockquoteAttributionCKEditorButton.php`,
  `js/plugins/blockquote_attribution/plugin.js`, `.../dialogs/blockquote_attribution.js`.
- See ../usage.md.
