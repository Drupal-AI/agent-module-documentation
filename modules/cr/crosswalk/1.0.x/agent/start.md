<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Crosswalk (crosswalk) — agent index

Integrates Drupal with the standalone **`crosswalk` CLI** to convert a node's serialized JSON into
**schema.org JSON-LD, BibTeX, and CSL-JSON** and render them on node pages. Package `Custom`.
Core `^10 || ^11`. License GPL-2.0-or-later. Version 1.0.0-beta1.

## Dependencies & external requirements

- Drupal module dep: core **`serialization`** only (info.yml `drupal:serialization`). No composer runtime deps.
- **External CLI**: the `crosswalk` binary must be installed in the web server's PATH. The module shells
  out to `crosswalk convert drupal <format>` via Symfony `Process` (array args, stdin = the node JSON).
- **RDF mappings** for your content, OR a manually authored crosswalk profile, so the CLI knows how to map fields.
- Citation widget loads **`citation-js` 0.7** from `cdn.jsdelivr.net` (external JS) and fetches MLA/Chicago CSL
  styles from the CSL GitHub CDN at runtime.

## What it provides (from source)

- **3 block plugins** (`src/Plugin/Block/`, all extend `CrosswalkBlockBase`):
  - `crosswalk_schema` (`CrosswalkSchemaBlock`) — emits `<script type="application/ld+json">` schema.org markup.
  - `crosswalk_bibtex` (`CrosswalkBibtexBlock`) — emits an HTML-escaped `<pre>` BibTeX record.
  - `crosswalk_citation` (`CrosswalkCitationBlock`) — tabbed APA/MLA/Chicago/CSL-JSON/BibTeX/Schema.org widget
    via `#theme = crosswalk_citation` + library `crosswalk/citation`.
- **1 service**: `crosswalk.entity_enricher` → `Drupal\crosswalk\EntityEnricher` (walks/enriches serialized JSON).
- **1 theme hook**: `crosswalk_citation` (`crosswalk_theme()`), template `templates/crosswalk-citation.html.twig`.
- **1 asset library**: `citation` (`crosswalk.libraries.yml`) → `css/citation.css`, `js/citation.js`, external citation-js.
- **1 logger channel**: `logger.channel.crosswalk`.
- **No** routes, permissions, config objects/schema, forms, Drush commands, or entity/plugin types.

## Solution docs

- **Blocks — the three block plugins, the shared convert pipeline, DOI/URL resolution, caching, and the
  citation widget/library** → [blocks/blocks.md](blocks/blocks.md)
- **EntityEnricher service — reference resolution, recursion, strip_tags, supported/skipped types** →
  [api/entity-enricher.md](api/entity-enricher.md)
