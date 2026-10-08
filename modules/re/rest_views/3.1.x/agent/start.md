<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# REST Views — agent index

Makes Views **REST Export** displays serialize fields as real JSON (arrays, nested objects,
booleans, numbers) instead of flattened strings. No settings form, configure route,
permissions, Drush, or plugin types — everything is configured per field inside a view.
Depends on `views` + `rest`.

- **Use the "Field (serializable)" handler + the export formatters (ids, config)** →
  [configure/serializable-fields.md](configure/serializable-fields.md)
- **Write your own export formatter (`SerializedData` / `RenderableData`)** →
  [extend/custom-formatter.md](extend/custom-formatter.md)
- **How it works: `field_export` handler + normalizers** →
  [api/mechanism.md](api/mechanism.md)

Key facts: for every core `field` handler, `hook_views_data_alter()` adds a `field_export`
handler ("… (serializable)", exposed as `<field>_export`). Export formatter ids:
`boolean_export`, `number_export`, `entity_reference_export`,
`entity_reference_entity_id_export`, `entity_path`, `file_export`, `image_export`,
`link_export`, `list_export` (they work **only** with the serializable handler). Submodules:
`rest_views_geo`, `rest_views_revisions`, `rest_views_search_api`.
