Adds the CKEditor 5 Word Count plugin, showing a live word and character count beneath the rich text editor.

---

This submodule of CKEditor 5 Plugin Pack registers the Word Count editor plugin (class `Plugin/CKEditor5Plugin/WordCount`), which displays an always-updating word and/or character total under the CKEditor 5 field as the author types. Unlike most plugins it is not a toolbar button — enabling the module and turning it on for a text format is enough for the counter to appear. Its settings (which counters to show) live in the plugin configuration for the format at Admin → Configuration → Content authoring → Text formats and editors. It depends on the base `ckeditor5_plugin_pack` module and ships its own config schema and CSS. Use it to help authors meet length guidelines for SEO, summaries, or editorial standards.

---

- Show authors a live word count while writing.
- Show a live character count for length-limited fields.
- Help meta description fields stay within recommended length.
- Enforce editorial word-count guidelines for articles.
- Give social/teaser fields a visible character budget.
- Track summary length for search snippets.
- Encourage concise product descriptions.
- Display both word and character counts together.
- Show only characters where words are irrelevant (codes, IDs).
- Help translators gauge content length parity.
- Provide feedback for SEO title/description sizing.
- Assist grant/abstract fields with strict limits.
- Monitor length of press releases.
- Give writers immediate feedback without external tools.
- Enable the counter only on formats where length matters.
- Reduce over-long content in listing teasers.
- Support editorial QA by surfacing content size.
- Help meet accessibility guidance on plain-language brevity.
- Track long-form content growth as it is drafted.
- Standardize length awareness across content types.
