<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
REST Views enhances Views REST Export displays so fields can be serialized as proper JSON structures — arrays for multi-value fields, nested objects for entity references, and real booleans/numbers — instead of the flattened HTML strings core Views produces.

---

Core Views' REST Export runs every field through the Render API, which concatenates values into strings; REST Views works around that. Via `hook_views_data_alter()` it adds, for every field handler, a second **"Field (serializable)"** handler (`plugin_id: field_export`, exposed in Views data as `<field>_export`, class `EntityFieldExport`). That handler wraps output in a `SerializedData` object (implements `MarkupInterface` so it survives rendering) which a normalizer (`serializer.normalizer.serialized` → `DataNormalizer`) unwraps back into real data during serialization; a second normalizer (`serializer.normalizer.render` → `RenderNormalizer`) renders any `RenderableData` render array. The serializable handler automatically exports multi-value fields as arrays based on field cardinality. On top of it, REST Views ships **export field formatters** that emit non-string JSON: `boolean_export`, `number_export`, `entity_reference_export` (nested entity as a structure, with optional `extra` metadata), `entity_reference_entity_id_export` (just the target id), `entity_path` (the referenced entity's path/URL), `file_export`, `image_export` (with `export_alt`/`export_title` options), `link_export`, and `list_export`. These formatters **only work with the Serializable handler**. Submodules extend the set: `rest_views_geo` (geolocation lat/lng), `rest_views_revisions` (entity reference revisions / paragraphs), and `rest_views_search_api` (Search API fields). The module adds no output filtering, so export formatters emit raw values — clients are responsible for safe use. It has no settings form, configure route, permissions, Drush, or plugin types of its own; you configure everything per field inside a view.

---

- Export a Views REST feed with multi-value fields as JSON arrays instead of joined strings.
- Serialize an entity reference as a nested object with several of its fields.
- Output a boolean field as a real JSON `true`/`false` for an API consumer.
- Emit numeric fields as JSON numbers rather than quoted strings.
- Build a decoupled/headless front-end data source from a Views REST Export.
- Return just the target entity id of a reference (`entity_reference_entity_id_export`).
- Include the URL/path of a referenced entity (`entity_path`).
- Export image fields with their alt and title attributes as structured data.
- Serialize file fields as structured file data for an API.
- Export link fields as objects (uri + title) instead of rendered anchors.
- Export list/select fields as their raw values.
- Provide nested paragraph data via `rest_views_revisions` and a display mode.
- Feed a mobile app a clean JSON list of content with typed fields.
- Serialize Search API index fields with `rest_views_search_api`.
- Export geolocation coordinates as lat/lng with `rest_views_geo`.
- Add export metadata to a referenced entity via the formatter's `extra` option.
- Replace a custom REST resource with a configurable Views REST Export.
- Keep some fields rendered (HTML) and others exported (raw) in one feed.
- Power an autocomplete or search endpoint with typed JSON output.
- Write a custom export formatter using `SerializedData` for a bespoke field type.
- Return an empty array (not empty string) for an empty multi-value field.
- Standardize a project's JSON API contract using Views configuration.
- Export taxonomy or user references as nested structures for a client app.
