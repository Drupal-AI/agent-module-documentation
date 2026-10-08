# Hooks (`leaflet.api.php`)

| Hook | Purpose |
|---|---|
| `hook_leaflet_map_info()` | Register named map definitions — `label`, `settings` (Leaflet map options: center, zoom, controls), and `layers` (base/overlay tile layers). Returned array is what the formatter/service pick a map from. |
| `hook_leaflet_map_info_alter(&$map_info)` | Alter map definitions from any module (change layers, defaults, controls). |
| `hook_leaflet_default_widget_alter(&$map_settings, $leafletDefaultWidget)` | Add/alter the JS map settings used by the Leaflet **widget**. |
| `hook_leaflet_default_map_formatter_alter(&$map_settings, &$items)` | Add/alter the JS map settings used by the Leaflet **formatter**. |
| `hook_leaflet_formatter_feature_alter(&$feature, $item, $entity)` | Adjust a single rendered feature/marker — `type` (point/polygon/linestring/…), `popup`, `lat`/`lon`/`points`, icon, etc. |

`leaflet_map_info_default_settings()` in the api file shows the baseline settings structure a
map definition supplies. Also present: `hook_leaflet_map_info()` results are cached, so clear
the `leaflet` cache (or caches) after changing a definition.
