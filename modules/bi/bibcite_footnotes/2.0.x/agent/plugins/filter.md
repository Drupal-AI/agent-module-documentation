<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Inline citation filter (`filter_reference_footnotes`)

`src/Plugin/Filter/ReferenceFootnotesFilter.php` — `@Filter` id `filter_reference_footnotes`,
title "Inline citation filter", type `TYPE_TRANSFORM_IRREVERSIBLE`, `cache = FALSE`, weight 0.
This is the piece that turns placeholder tags into rendered citations + a bibliography. Enable it on
a text format (the same format whose editor has the Insert Citation button).

## Input it consumes

The CKEditor plugin writes tags of the form:

    <bibcite-footnote data-entity-id="123" data-page-range="45-47"></bibcite-footnote>

- `data-entity-id` — id of a `bibcite_reference` entity (required; empty/invalid tags are dropped).
- `data-page-range` — optional page/locator, becomes the citation `locator` (label `page`).

Allowed by the CKEditor plugin's declared elements (`bibcite_footnotes.ckeditor5.yml`):
`<bibcite-footnote>` and `<bibcite-footnote data-entity-id data-page-range>`. The format's
`filter_html` must allow the tag for it to survive to the filter.

## `process($text, $langcode)`

1. Fast-exit if the string `bibcite-footnote` is absent.
2. Parse the HTML into a `\DOMDocument` (`loadHTML` with `LIBXML_HTML_NOIMPLIED | LIBXML_HTML_NODEFDTD`),
   XPath-query `//bibcite-footnote`.
3. `processAllCitations()` — for each tag, load the reference via
   `bibcite_footnotes.citation_tools`→`getRenderableReference($entity_id)` (which normalizes the
   entity to CSL with the `serializer`). Tags with no `data-entity-id` or no valid `citation-label`
   are skipped. Builds a `citations` map (id, locator, label, DOM fragment) and a de-duplicated
   `bibliography` map keyed by citation label.
4. `replaceAllFootnotes()` — replaces each tag with `<span class="bibcite-citation">…</span>`
   containing the citation rendered by `renderCitation()` (`#theme` `bibcite_footnotes_citation`).
5. `removeInvalidFootnotes()` — deletes any leftover `<bibcite-footnote>` nodes.
6. `addBibliographySection()` — if enabled, appends
   `<div class="bibcite-footnotes-section"><h3>{label}</h3><div class="bibcite-bibliography">…</div></div>`
   at document-root level, rendered via `#theme` `bibcite_footnotes_works_cited`.
7. Returns a `FilterProcessResult`, adding `$this` as a cacheable dependency (so cached HTML varies
   with the filter settings).

Rendering of the citation/bibliography text itself is delegated to the theme preprocessors and the
citeproc-php processor — see [../api/services.md](../api/services.md).

## Settings (config schema `filter_settings.filter_reference_footnotes`)

Defined in the plugin annotation + `settings()`, form built in `settingsForm()`. Schema:
`config/schema/bibcite_footnotes.schema.yml`.

| Key | Type | Default | Effect |
|---|---|---|---|
| `enable_bidirectional_links` | boolean | `TRUE` | Citations link to bibliography entries and each entry gets backlinks to every citation instance. |
| `backlink_symbol` | string | `↑` | Glyph used for a backlink (shown only when bidirectional links on). |
| `backlink_position` | string | `after` | `before` or `after` the bibliography entry text. |
| `enable_bibliography_section` | boolean | `TRUE` | Print the inline "Bibliography" block at the end of the content. |
| `bibliography_section_label` | string | `Bibliography` | Heading text for the inline bibliography (`<h3>`). |

Settings are edited per text format at Admin › Configuration › Content authoring › Text formats and
editors (managing a format requires the core "administer filters" permission). Backlink markup is
built in `CiteprocPhpInline::render()` from these settings.

## Tips / help

`tips()` returns "Use the citation button in the editor to insert citations." No `hook_help` beyond a
one-line About.
