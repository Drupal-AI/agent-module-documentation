<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# REST Views Search API — agent index

Submodule of **rest_views**. Exports a Search API field (the `search_api_field` nested-field
handler) as structured JSON in a Views REST Export. Requires `rest_views` + `search_api`.
No config/route/permissions/Drush.

- **Export a Search API field: the serializable handler** →
  [configure/search-api-export.md](configure/search-api-export.md)

Key facts: Views field plugin **`search_api_field_export`** (class `SearchApiEntityFieldExport`,
`@ViewsField("search_api_field_export")`, extends Search API's `SearchApiEntityField`). A
`hook_views_data_alter()` adds this serializable handler for `search_api_field` handlers
(exposed as `<field>_export`). Serialization uses the parent module's `SerializedData` +
normalizers.
