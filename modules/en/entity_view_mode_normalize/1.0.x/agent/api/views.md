<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views row plugins + telephone submodule

## Views "data" row plugins
Both are `@ViewsRow` plugins for `display_types = {"data"}` (REST export displays). They set
`$context['field']['settings']['view_mode']` from a row option and normalize the entity through it, so a REST
export returns view-mode-rendered JSON.

- **`view_mode_data_entity`** — "Entity (with view mode)"
  (`Plugin/views/row/ViewModeDataEntityRow`, extends core `DataEntityRow`).
  Adds a **View mode** select to the row settings form (options from `getViewModeOptions()` for the view's
  entity type). `render()` calls the parent to get the entity render, then
  `serializer->normalize($render, $content_type, $context)` with the chosen view mode. Use it as the row style
  on a REST export display to get one JSON object per entity shaped by the picked view mode.

- **`search_api_data_entity_row`** — "Search API: source entity for search index"
  (`Plugin/views/row/SearchApiDataEntityRow`, extends `DataEntityRow`).
  Row form adds an **Entity type** select and a **View mode** select. `render()` pulls the indexed item's source
  entity (`$row->_item->getOriginalObject()->getValue()`) and normalizes it through the chosen view mode.
  Intended for a Search API-backed data view, to serialize the source entity (not the index fields) as JSON —
  e.g. to store/return view-mode-rendered content for a search result. `getEntityTypeId()` defaults to `node`.

Live preview vs real request: content type comes from the display handler on a real request, or from the
configured `formats` (default `json`) during Views live preview.

## Submodule: telephone_validation_normalize
Separate module (`modules/telephone_validation_normalize/`, disabled by default). Depends on
`entity_view_mode_normalize` + `telephone_validation` (which brings `giggsey/libphonenumber-for-php`).

Adds `PhoneNumberFieldItemListNormalizer` (priority 13) that matches any field-item list whose field definition
carries `telephone_validation` third-party settings. For each phone value it parses the E.164 number and emits:

```
{
  "values": [ { "country_code": 44, "nation_phone_number": "7911123456" }, ... ],
  "list_country_code": [ { "short_name": "GB", "name": "United Kingdom", "code": 44 }, ... ]
}
```

`list_country_code` is the full region → dialing-code list from `@country_manager`, useful for building a phone
input widget. Cardinality collapsing (single value → object) applies as elsewhere.
