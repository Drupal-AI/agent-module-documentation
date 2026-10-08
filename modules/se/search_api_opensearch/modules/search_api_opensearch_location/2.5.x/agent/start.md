<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API OpenSearch Location — agent index

Submodule of Search API OpenSearch. Adds a Search API **data type** with id **`location`**
(label "Geopoint") so `geofield` latitude/longitude values can be indexed into OpenSearch as a
`geo_point`. Depends on `search_api_opensearch` + `geofield`. No settings page, no permissions,
no config schema, no plugin types.

## How to use

1. Add a geofield to your entity (e.g. a node) and add that field to a Search API **index**.
2. Set the index field's **Search API data type** to `location`. In index config
   (`search_api.index.<id>`), the field entry's `type` becomes `location`:

   ```yaml
   field_settings:
     field_geo:
       label: 'Geo'
       datasource_id: 'entity:node'
       property_path: field_geo      # a geofield property
       type: location                # <- provided by this submodule
   ```

3. On an OpenSearch backend the value is mapped to an OpenSearch `geo_point`.

## Mechanism

- Data type plugin `GeoPointDataType` (`@SearchApiDataType id = "location"`, label "Geopoint"),
  using `geofield.geophp`.
- `DataTypeEventSubscriber` subscribes to the parent module's `SupportsDataTypeEvent` and calls
  `setIsSupported(TRUE)` when the type is `location`, so the OpenSearch backend accepts it.

Grounding note: this site has no live OpenSearch cluster, so geo_point mapping/queries can't be
exercised — reason about the index field's `location` data type in config. See the parent
module's `configure/backend.md` and `hooks/events.md`.
