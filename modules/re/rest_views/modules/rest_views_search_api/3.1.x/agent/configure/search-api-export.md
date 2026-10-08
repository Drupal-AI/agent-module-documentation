<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Export a Search API field over REST

Prerequisite: a **Search API** index and a Views display built on that index (base table is the
index), with a Search API field handler (`search_api_field`), plus a **REST Export** display.

## Steps (Views UI)

1. In the Search API–based view, add the Search API field's **(serializable)** variant — the
   handler this submodule adds (`plugin_id: search_api_field_export`, exposed as `<field>_export`).
2. Configure/format it as needed and Save. The (possibly nested) Search API field values
   serialize as structured data instead of a flattened string.

## Config shape

```yaml
# views.view.<id> -> display.<d>.display_options.fields.<field>
plugin_id: search_api_field_export     # this submodule's serializable Views field handler
```

## How it works

- `rest_views_search_api_views_data_alter()` clones every `search_api_field` handler into a
  `<field>_export` entry with `field.id = search_api_field_export` (argument/filter/sort removed).
- `SearchApiEntityFieldExport` (`@ViewsField("search_api_field_export")`) extends Search API's
  `SearchApiEntityField` and, like the parent module's `EntityFieldExport`, wraps output in a
  `SerializedData` object so REST Views' `DataNormalizer` serializes real data.

There is no separate formatter to pick — the serializable **handler** itself produces the
structured output. Requires `rest_views` and `search_api`.
