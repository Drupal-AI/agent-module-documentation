A demo submodule that installs a ready-made "Article with References" content type and "Basic HTML with References" text format so you can see BibCite Footnotes working end to end.

---

`bibcite_footnotes_article_with_citations` ships only configuration (no PHP). Enabling it imports a complete example setup: the `bibcite_fn_article_references` node type ("Article with References") carrying a "Works Cited" entity-reference field (`field_bibcite_fn_works_cited`) that targets every `bibcite_reference` type through an Inline Entity Form – complex widget, plus body, image and tags fields; the `basic_html_with_references` text format with the `filter_reference_footnotes` (Inline citation filter) enabled alongside the usual filter_html/align/caption filters; and the CKEditor editor, form-display and view-display config wiring the "Insert Citation" toolbar button. It depends on the parent module and on several BibCite import formats (bibtex, endnote, ris, marc, bibcite_import) and Inline Entity Form. Intended for evaluation and as a configuration reference — not a building block for production content models. (Its `.info.yml` still declares `core_version_requirement: ^8 || ^9` and has a typo in the parent dependency name `bibcite_footnotees`.)

---

- Evaluate BibCite Footnotes quickly with a working content type and text format instead of building them by hand.
- Create "Article with References" nodes that support in-text citations and an auto-generated bibliography.
- See how a Works Cited entity-reference field to `bibcite_reference` is configured (target bundles, sort, IEF widget).
- Study the "Basic HTML with References" format to learn which filters and weights the inline citation filter needs.
- Author references inline in the node form via the Inline Entity Form – complex widget.
- Import citations from BibTeX, EndNote, RIS or MARC using the bundled BibCite import format dependencies.
- Copy the shipped config as a starting template for your own citation-enabled content type.
- Demonstrate the CKEditor 5 "Insert Citation" button and reference dropdown on a real content type.
- Provide a fixture for functional/manual testing of the parent module's filter and editor integration.
- Show editors the expected node-edit workflow (Works Cited field + body citations) before rolling out a custom type.
