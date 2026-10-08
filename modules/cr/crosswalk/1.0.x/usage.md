Crosswalk pipes a node's serialized JSON through the external `crosswalk` CLI to render schema.org JSON-LD, BibTeX, and formatted citations on scholarly content pages.

---

Crosswalk is a bridge between Drupal's serialized entity data and the standalone `crosswalk` command-line tool, which converts scholarly metadata between formats (schema.org, BibTeX, CSL-JSON). It ships three block plugins that appear on node pages: one injects `application/ld+json` schema.org markup into the page, one prints a BibTeX record, and one renders an interactive, tabbed citation widget (APA / MLA / Chicago / CSL-JSON / BibTeX / Schema.org) using the browser-side `citation-js` library. Before conversion, an `EntityEnricher` service walks the node's serialized JSON, resolves entity references (nodes, taxonomy terms, media, files) by loading and nesting the referenced entity data, strips HTML tags from string values, and sets a canonical `_url` (a DOI when the node carries a `field_identifier` DOI value, otherwise the absolute node URL). The enriched JSON is piped as stdin to `crosswalk convert drupal <format>` and the CLI output is post-processed to guarantee the URL is present. The module has no admin UI, routes, permissions, or configuration objects of its own; it depends only on core `serialization` plus the `crosswalk` binary being installed in the web server's PATH, and (for the citation widget) RDF mappings or a crosswalk profile describing your content type.

---

- Emit schema.org JSON-LD structured data for scholarly articles so search engines and scholarly indexes can parse them.
- Improve SEO of a publications or repository site by adding machine-readable Article/Dataset metadata to node pages.
- Display a ready-to-copy BibTeX record on each publication node for researchers to import into reference managers.
- Show an interactive citation widget that formats the same work as APA, MLA, and Chicago on the fly in the browser.
- Offer a "CSL-JSON" tab so downstream tools can consume the raw Citation Style Language data.
- Provide one-click "copy to clipboard" buttons for each citation format on a publication page.
- Resolve a node's DOI (from a `field_identifier` field tagged `doi`) into a canonical `https://doi.org/...` URL inside the citation and schema output.
- Fall back to the absolute canonical node URL when no DOI is present, so every citation still carries a resolvable link.
- Enrich exported metadata by inlining referenced taxonomy terms (subjects, keywords), media, and files into the serialized payload.
- Convert a Drupal content type into structured scholarly metadata without writing custom serialization normalizers.
- Drive an institutional repository (e.g. an Islandora-style publications site) that needs standards-compliant citation output.
- Place the schema.org block in the page `<head>`/content region to feed Google Scholar and rich-result crawlers.
- Present multiple citation styles in a tabbed UI that works with or without Bootstrap's JS loaded (a built-in tab fallback is included).
- Give editors a preview of exactly how a work will be cited across common academic styles.
- Standardize citation output across a large catalog of nodes by centralizing conversion in the crosswalk CLI.
- Strip stray HTML out of field values before they reach the citation formatter, keeping output clean.
- Reuse existing RDF field mappings to feed the crosswalk conversion instead of maintaining a separate metadata mapping.
- Add BibTeX export to a Drupal site without a PHP BibTeX library by delegating to the external CLI.
- Cache citation output per-node (blocks add the node as a cache dependency and vary by route) so conversion runs only when content changes.
- Support library, archive, or journal sites that must expose citations in several formats side by side.
- Degrade gracefully: if the CLI fails or the page is not a node, the blocks render nothing rather than erroring.
- Let theme developers restyle the citation widget via the `crosswalk_citation` theme hook and `css/citation.css` custom properties.
