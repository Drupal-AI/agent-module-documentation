BibCite Footnotes lets CKEditor 5 authors insert academic-style inline citations that reference BibCite bibliography entities and are rendered, together with an automatic bibliography, by a text-format filter.

---

The module adds a "Insert Citation" CKEditor 5 toolbar button that writes `<bibcite-footnote data-entity-id="…" data-page-range="…">` placeholder tags into the body. On display, the `filter_reference_footnotes` text-format filter parses those tags out of the HTML with DOM/XPath, loads each referenced `bibcite_reference` entity, and renders a formatted citation (via BibCite's citeproc-php processor and the site's selected CSL style) in place of the tag. It also appends a full "Bibliography" / "Works Cited" section at the end of the content, with optional bidirectional links between each in-text citation and its bibliography entry (configurable backlink symbol and position). References available in the editor dropdown come from an entity-reference field on the node that targets `bibcite_reference` (the Works Cited field), populated on the node form via `hook_form_node_form_alter`; Inline Entity Form is suggested so authors can create references without leaving the node form. A Views style plugin ("Bibcite Works Cited List") can render a bibliography from a view of reference entities in a block instead of inline. No routes, permissions, or drush commands are added; behaviour is configured per text format.

---

- Add scholarly in-text citations to Article/blog body content that render in a chosen CSL style (APA, Chicago, MLA, etc.).
- Automatically generate a "Bibliography" or "Works Cited" section at the bottom of a node from the citations used in the body.
- Give editors a WYSIWYG "Insert Citation" button in CKEditor 5 rather than hand-writing citation markup.
- Reuse a shared library of imported references (via bibcite_import from RefWorks/EndNote/Zotero/BibTeX) as selectable footnotes.
- Let authors pick from references already attached to the node's Works Cited entity-reference field.
- Create new reference entities inline on the node edit form when Inline Entity Form is installed.
- Cite the same source multiple times and collapse them into a single numbered bibliography entry with multiple backlinks (a, b, c…).
- Add a page/locator range to an individual citation with the `data-page-range` attribute.
- Turn bidirectional linking on or off so citations link down to the bibliography and bibliography entries link back up to each citation instance.
- Customize the backlink symbol (e.g. ↑, ↖, ↩) and whether it appears before or after each bibliography entry.
- Rename the inline bibliography heading (default "Bibliography") per text format.
- Suppress the inline bibliography section and instead render works cited in a block via the "Bibcite Works Cited List" Views style.
- Build a journal/publication site where articles carry structured, reusable citation metadata.
- Present a sorted works-cited list (author, then title) through the field preprocess sorting.
- Restrict which BibCite reference types (book, journal_article, thesis, website, …) an author may cite by configuring the Works Cited field's target bundles.
- Stand up a ready-made demo (content type + text format + fields) using the `bibcite_footnotes_article_with_citations` example submodule.
- Style the rendered citations and bibliography using the emitted CSS classes (`bibcite-citation`, `bibcite-footnotes-section`, `bibcite-bibliography`, `bibcite-backlink`).
- Keep citation formatting consistent site-wide by relying on the single Default CSL style chosen in BibCite settings.
- Integrate a "Bulk import citations" link into the node form for users who hold the `bibcite import` permission.
