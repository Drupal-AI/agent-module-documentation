# CKEditor Quote — agent index

One CKEditor 5 plugin that adds a **Quote** toolbar button inserting a `<blockquote>` with an author
line. No settings form, no `configure` route, no permissions, no Drush, no config schema. It is
configured entirely per text format (add the toolbar item to a format's CKEditor 5 toolbar).

- **Add the button to a text format, the plugin/toolbar ids, produced HTML, and allowed elements** →
  [configure/enable.md](configure/enable.md)

Key facts:
- ckeditor5.yml plugin id `ckeditor_quote_quote`; CKEditor 5 JS plugin `quote.Quote`; library `ckeditor_quote/quote`.
- Toolbar item name: **`Quote`** (label "Quote Dialog") — this is what you add to
  `editor.editor.<format>` → `settings.toolbar.items`.
- Data HTML: `<blockquote><div class="quote"><p>…</p></div><div class="author">…</div></blockquote>`;
  up-casts existing `<blockquote>` (author from a child `<div class="author">` or `<cite>`).
- Declared elements auto-allowed in the filter: `<p>`, `<div>`, `<div class="author">`, `<blockquote>`.
