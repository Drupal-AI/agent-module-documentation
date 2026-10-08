CKEditor Quote adds a CKEditor 5 toolbar button that inserts a `<blockquote>` containing the quote text and an attributed author line, improving on the plain blockquote button.

---

The module registers a single CKEditor 5 plugin, defined declaratively in `ckeditor_quote.ckeditor5.yml` (plugin id `ckeditor_quote_quote`, CKEditor 5 plugin `quote.Quote`) plus a compiled JS bundle (`js/build/quote.js`, library `ckeditor_quote/quote`). It exposes one toolbar item, **`Quote`** (labelled "Quote Dialog"), which you drag into a text format's CKEditor 5 toolbar on the format's configuration page. Pressing it inserts a widget modelled internally as `<quote><quoteQuote/><quoteAuthor/></quote>` and down-cast to the HTML `<blockquote><div class="quote"><p>…</p></div><div class="author">…</div></blockquote>`; on load it up-casts existing `<blockquote>` elements (and treats a child `<div class="author">` or `<cite>` as the author), so it is backward compatible with plain blockquotes that have no author. The plugin declares the elements it needs (`<p>`, `<div>`, `<div class="author">`, `<blockquote>`) so CKEditor 5 automatically allows them in the format's filter. The module has no settings form, no `configure` route, no permissions, no config schema, and no Drush commands — all configuration is per text format. (A legacy CKEditor 4 `CKEditorPlugin` class also ships but is unused on Drupal 10/11, which only has CKEditor 5.)

---

- Add an attributed pull-quote (quote text + author) button to a rich-text format's toolbar.
- Let editors cite the source/author of a quotation inline in body content.
- Produce semantic `<blockquote>` markup with a styled author line instead of a bare blockquote.
- Upgrade existing plain blockquotes to author-aware quotes without re-entering them.
- Insert testimonial blocks (customer name as author) in marketing pages.
- Add press-quote callouts with attribution on a news/blog article.
- Allow multi-line quotes by letting the author break the quote body into paragraphs.
- Give a "Basic HTML"/"Full HTML" format a dedicated Quote button separate from Blockquote.
- Standardize quote formatting across a site so every quote has the same structure.
- Enable the button only on formats where editorial quoting is wanted.
- Render `<div class="author">` that a theme can style (e.g. em-dash prefix, italic).
- Keep quotes accessible/semantic with a real `<blockquote>` wrapper.
- Support `<cite>` in legacy content as the author on load (up-cast).
- Provide a WYSIWYG widget so editors edit quote and author in place.
- Add attributed quotes to Layout Builder text blocks that use a CKEditor 5 format.
- Use in comment or webform rich-text fields that use a CKEditor 5 format.
- Migrate content containing `<blockquote>` and have it recognised as an editable quote.
- Offer a consistent quote component to non-technical authors without custom code.
- Combine with other CKEditor 5 plugins in the same toolbar.
- Add a quotations block to case studies with the client's name attributed.
