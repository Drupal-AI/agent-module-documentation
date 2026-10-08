<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Facets Form Fulltext — agent index

Adds a "Fulltext (inside form)" facet widget (`facets_form_fulltext`): a text box that filters
Search API results by typed keywords, plus a matching query type. Depends on `facets_form`. No config
page, no permissions, no Drush. Ships config schema.

- **Widget config, the `Fulltext` value object, and query-type operator behavior** →
  [configure/fulltext.md](configure/fulltext.md)

Key facts:
- Widget `FulltextWidget` (extends Facets `ArrayWidget`, uses `FacetsFormWidgetTrait`); query type
  `facets_form_fulltext_query_type` mapped via `hook_facets_search_api_query_type_mapping_alter()`.
  `getQueryType()` = `facets_form_fulltext`.
- Config: `label`, `placeholder`, `operator` (`=` phrase, or `AND` per-word).
- `execute()`: `=` → one Search API condition on the field; `AND` → split on whitespace, one
  AND-grouped condition per word. Summary = "Contains @search".
