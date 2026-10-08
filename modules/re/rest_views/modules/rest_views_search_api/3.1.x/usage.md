<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
REST Views Search API is a submodule of REST Views that lets a Search API field (the nested-field handler used on Search API index views) be exported as structured JSON in a Views REST Export display.

---

Search API's Views integration provides a special `search_api_field` handler that can render
nested fields from indexed items. This submodule mirrors REST Views' approach for it: a
`hook_views_data_alter()` finds every handler with id `search_api_field` and adds a parallel
**"(serializable)"** entry (`field.id = search_api_field_export`, exposed as `<field>_export`),
and it ships the matching Views field plugin **`search_api_field_export`** (class
`SearchApiEntityFieldExport`, annotation `@ViewsField("search_api_field_export")`, extending
Search API's `SearchApiEntityField`). Used in a Search API–based REST Export view, it serializes
the (possibly nested) Search API field values as real data via REST Views' `SerializedData`
wrapper and normalizers, instead of a flattened string. It has no configuration, permissions,
Drush, or plugin types of its own; it requires `rest_views` and `search_api`.

---

- Export Search API index results as structured JSON over a Views REST Export.
- Serialize nested Search API fields (e.g. rendered nested entity fields) as data.
- Build a decoupled search endpoint backed by a Search API index.
- Feed a headless front-end typed search results instead of HTML strings.
- Export faceted-search result rows as JSON for a client app.
- Serialize a Search API field that aggregates multiple values as an array.
- Combine Search API field exports with other export fields in one feed.
- Power an autocomplete/typeahead API from a Search API index.
- Return nested indexed entity data in a search REST response.
- Avoid custom normalization code for Search API result fields.
- Provide a mobile app a clean JSON search feed from Drupal.
- Export Solr/Database-backed index results via Views configuration.
- Serialize computed/processed Search API fields for an API.
- Keep search result values typed for client-side rendering.
- Drive an instant-search UI from a Views REST endpoint.
- Expose a curated search view as a structured data source.
