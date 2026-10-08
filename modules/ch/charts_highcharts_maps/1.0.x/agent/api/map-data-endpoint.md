<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Map-data endpoint (taxonomy-term geometry source)

When the Views style's data source is the **taxonomy-term** mode (`vid` + `tid` +
`json_field_name`), the browser fetches the map geometry from this route rather than from a file URL.

## Route
`charts_highcharts_maps.routing.yml`:
```
charts_highcharts_maps.map_data:
  path: '/charts-highmap/map-data/{json_field_name}/{taxonomy_term}'
  defaults:
    _controller: '\Drupal\charts_highcharts_maps\Controller\MapDataController::json'
  requirements:
    _custom_access: '\Drupal\charts_highcharts_maps\Controller\MapDataController::checkAccess'
```
- `{json_field_name}` — the machine name of the field on the term that stores the geometry.
- `{taxonomy_term}` — upcast to a `Term` entity (invalid id → 404).

## Controller — `src/Controller/MapDataController.php`
- **`json($json_field_name, TermInterface $taxonomy_term)`** returns
  `new JsonResponse(Json::decode($taxonomy_term->{$json_field_name}->value ?? '{}'))` — i.e. the
  GeoJSON/TopoJSON string stored in that term field, decoded and re-emitted as a JSON response
  (core-encoded).
- **`checkAccess($json_field_name, TermInterface $taxonomy_term)`** returns
  `$taxonomy_term->access('view', $this->currentUser(), TRUE)` — access is granted when the current
  user may **view** the referenced term.

## How it is called
`js/charts_highcharts_maps.js` builds the URL client-side:
```js
`${drupalSettings.path.baseUrl}${drupalSettings.path.pathPrefix}charts-highmap/map-data/${json_field_name}/${tid}`
```
fetches it, and assigns the decoded geometry to `config.chart.map` before
`Highcharts.mapChart(config)`.

## Operating notes
- Store valid GeoJSON or TopoJSON (as a JSON string) in the chosen term field; a missing/empty field
  yields `{}` and an empty map.
- The endpoint returns exactly the decoded JSON — do it once and cache-friendly per term; there is no
  server-side transformation of the geometry.
