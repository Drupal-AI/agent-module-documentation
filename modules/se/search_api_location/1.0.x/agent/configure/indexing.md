<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Indexing locations & data types

There is no dedicated settings form. You work inside Search API's own UI; the module's
`configure` route is `search_api.overview`
(`/admin/config/search/search-api`).

## The two Search API data types
| Data type id | Label | Use it for |
|---|---|---|
| `location` | Latitude/Longitude | Views distance filter/argument/sort (`search_api_location_views`). |
| `rpt` | Spatial Recursive Prefix Tree | Facet heatmaps (`facets_map_widget`). Requires lat/lon input. |

Both are `@SearchApiDataType` plugins. At index time `getValue()` runs the geofield's stored
value through geoPHP (`\geoPHP::load($value)`), takes the centroid, and returns `"lat,lon"`.
`getFallbackType()` returns **NULL** so Search API won't treat the value as a string or run text
processors on it. `rpt` extends `location` (same conversion).

## Index a geofield (UI)
1. The source field must be a **geofield** storing a lat/lon value.
2. Go to `/admin/config/search/search-api/index/<INDEX>/fields`, **Add fields**, and add the
   geofield property.
3. Set that field's **Type** to **Latitude/longitude** (`location`) to use it with
   `search_api_location_views`, and/or add it again as **Recursive Prefix Tree** (`rpt`) to use
   it with `facets_map_widget`. You can index the same geofield twice under different field ids.
4. Reindex.

## Backend support (important)
The backend service class must support these data types or nothing happens. **Search API Solr**
is the known-good backend; **Elasticsearch** may work with patches; the **database backend does
not** support spatial search. Check `Server::supportsDataType('rpt')` / `'location'`.
`facets_map_widget` only offers its heatmap query type when the backend
`supportsDataType('rpt')` (see `facets_map_widget_facets_search_api_query_type_mapping_alter`).

## Programmatic field setup
```php
use Drupal\search_api\Entity\Index;
use Drupal\search_api\Item\Field;

$index = Index::load('my_index');
$f = new Field($index, 'my_geo');           // field id
$f->setLabel('Location');
$f->setDatasourceId('entity:node');
$f->setPropertyPath('field_geo');           // the geofield
$f->setType('location');                    // or 'rpt'
$index->addField($f);
$index->save();
// read back: $index->getField('my_geo')->getType();
```

## Distance units
`search_api_location_get_units()` returns the supported units, all multipliers relative to 1 km:
`km` (Kilometers, ×1) and `mi` (Miles, ×1.60935). Distance searching is kilometre-based. Add or
change units with `hook_search_api_location_units_alter(&$units)`. Location Input plugins expose
`radius_type` (select/textfield), `radius_options` (one option per line, `"-"` distance ignores
filtering but still computes distance) and `radius_units` settings.
