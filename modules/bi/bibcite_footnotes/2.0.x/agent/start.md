<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BibCite Footnotes (bibcite_footnotes) — agent index

Renders academic-style **inline citations + an automatic bibliography** in CKEditor 5 content.
Authors insert `<bibcite-footnote data-entity-id data-page-range>` placeholder tags with a toolbar
button; a text-format filter replaces them with citations rendered from `bibcite_reference` entities
via BibCite's citeproc-php processor and the site's selected CSL style. Version **2.0.0-beta1**,
core `^10 || ^11`.

- **Dependencies:** `bibcite`, `bibcite_entity` (provide the reference entities + CSL styling), core
  `ckeditor5`. Requires `drupal/bibcite:^3.0` (Composer). Suggests `inline_entity_form`.
- **No** routes, permissions, drush commands, or content entities of its own.
- **Provides config schema** for the filter settings (`config/schema/bibcite_footnotes.schema.yml`).

## What it provides

- **Text filter** `filter_reference_footnotes` ("Inline citation filter") — `TYPE_TRANSFORM_IRREVERSIBLE`,
  `src/Plugin/Filter/ReferenceFootnotesFilter.php`. Does the actual rendering. → [plugins/filter.md](plugins/filter.md)
- **CKEditor 5 plugin** `bibcite_footnotes_bibciteFootnotes` (toolbar "Insert Citation") + the
  `hook_form_node_form_alter` that feeds the reference dropdown. → [plugins/editor-integration.md](plugins/editor-integration.md)
- **Views style** `bibcite_footnotes_works_cited` ("Bibcite Works Cited List"),
  `src/Plugin/views/style/WorksCited.php`. → [plugins/views-style.md](plugins/views-style.md)
- **Services, stylers, BibCite processor, theme hooks** (`CitationTools`, `InlineCitationStyler`,
  `WorksCitedStyler`, `CiteprocPhpInline`). → [api/services.md](api/services.md)

## Submodule

- `bibcite_footnotes_article_with_citations` — demo/example: ships a content type, text format,
  editor and fields showing a fully-configured setup.
  → [modules/bibcite_footnotes_article_with_citations/2.0.x/agent/start.md](modules/bibcite_footnotes_article_with_citations/2.0.x/agent/start.md)
