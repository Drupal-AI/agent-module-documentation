<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services, stylers, processor & theme hooks

How rendered citation text is actually produced. Everything hangs off BibCite's citeproc-php styling.

## Services (`bibcite_footnotes.services.yml`)

- `bibcite_footnotes.citation_tools` → `Drupal\bibcite_footnotes\CitationTools`. One method,
  `getRenderableReference($reference_entity)`: loads the `bibcite_reference` entity (if given a
  numeric id), normalizes it to CSL via the `serializer`, and returns
  `['#theme' => 'bibcite_footnotes_citation', '#data' => $data]`. (Note: the class is also
  instantiated directly with `new CitationTools()` in several module preprocess hooks, so its
  constructor takes no args despite the service definition listing arguments.)
- `bibcite_footnotes.inline_citation_styler` → `InlineCitationStyler` (extends BibCite's
  `CitationStyler`). Renders a single in-text citation. `render($data, $filter)` fetches the CSL text
  + language, forwards filter settings to the processor, and calls `processor->render(…, 'citation', $filter)`.
- `bibcite_footnotes.works_cited_styler` → `WorksCitedStyler` (extends `CitationStyler`). Same shape
  but `render($data, $citation_items)` calls the processor in `'bibliography'` mode. Also exposes
  `getCssStyles()`.
- Both stylers add `setFilterSettings(array)` (backlink/bibliography options passed down from the filter).
- The file also re-declares core's `plugin.manager.filter` service (`FilterPluginManager`).

## BibCite processor — `CiteprocPhpInline`

`src/Plugin/BibCiteProcessor/CiteprocPhpInline.php` — `@BibCiteProcessor(id = "citeproc-php-inline")`,
extends `BibCiteProcessorBase`. Wraps `Seboettg\CiteProc\CiteProc` (citeproc-php, provided via
`drupal/bibcite`).

- `render($data, $csl, $lang, $mode, $citation_items)` builds a citeproc instance with an
  `$additionalMarkup` map that injects the anchor/backlink HTML:
  - **citation** mode wraps each entry in `<a id="{id}_cite_N" href="#{id}">…</a>` (or a simpler
    `<a href="#{id}">` when bidirectional links are disabled), tracking instance ids in a static map.
  - **bibliography** mode prefixes `<a id="{id}" href="#{id}"></a>` and, when bidirectional, appends a
    `<span class="bibcite-backlinks">[ … ]</span>` of `<a class="bibcite-backlink">{symbol}</a>`
    backlinks to every citation instance, positioned by `backlink_position`.
  - Backlink symbol/position/on-off come from the filter settings via `setFilterSettings()`.
  - Whitespace between rendered lines is collapsed with `preg_replace`. The bibliographic text itself
    is produced by citeproc-php from the CSL style + normalized reference data.
- `renderCssStyles($csl, $lang)` returns citeproc's CSS for the style.

The single Default CSL style configured in BibCite settings governs formatting; the styler uses
`setStyleById()` / `setStyle(NULL)`.

## Theme hooks (`bibcite_footnotes_theme()`)

- `bibcite_footnotes_citation` — one rendered citation; preprocess
  `bibcite_footnotes_preprocess_bibcite_footnotes_citation()` runs the inline styler
  (processor `citeproc-php-inline`) and sets `content` = `#markup`. Template
  `templates/bibcite-footnotes-citation.html.twig`.
- `bibcite_footnotes_works_cited` — the bibliography; preprocess
  `bibcite_footnotes_preprocess_bibcite_footnotes_works_cited()` runs the works-cited styler and
  attaches the CSL CSS to `html_head`. Template `templates/bibcite-footnotes-works-cited.html.twig`.
- `bibcite_footnote_link` / `bibcite_footnote_list` — older footnote-list rendering
  (`bibcite_footnotes_preprocess_bibcite_footnote_link/list()` build backlinked `<a>` links and
  ibid/notes lists); templates `bibcite-footnote-link.html.twig`, `bibcite-footnote-list.html.twig`.

## Other hooks

- `bibcite_footnotes_preprocess_field()` — sorts a `field_bibcite_fn_works_cited` field's items by
  their rendered citation text (author → title) using
  `_bibcite_footnotes_sort_rendered_references()`.
- `hook_form_node_form_alter` / `hook_inline_entity_form_entity_form_alter` — see
  [../plugins/editor-integration.md](../plugins/editor-integration.md).

## Config

- `config/schema/bibcite_footnotes.schema.yml` defines `bibcite_footnotes.settings`
  (config_object with `enable_bidirectional_links`) and `filter_settings.filter_reference_footnotes`
  (the per-format filter settings, see [../plugins/filter.md](../plugins/filter.md)). There is no
  settings form/route for `bibcite_footnotes.settings`; all live configuration is the filter settings.
