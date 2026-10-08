# Hooks (`leaflet_views.api.php`)

| Hook | Purpose |
|---|---|
| `hook_leaflet_map_view_geofield_value_alter(&$geofield_value, &$map, $context)` | Alter the raw geofield value used for a view before it becomes map features. |
| `hook_leaflet_views_feature_alter(&$feature, $row, $rowPlugin)` | Adjust a single feature/marker for one Views result row (icon, popup, geometry). |
| `hook_leaflet_views_features_alter(&$features, &$view_style)` | Alter the whole collection of features for the view. |
| `hook_leaflet_views_features_group_alter(&$group, &$view_style)` | Alter a feature group (e.g. grouped markers). |
| `hook_leaflet_map_view_style_alter(&$map_settings, &$view_style)` | Add/alter the map's JS settings for the Views style. |

These complement the base Leaflet formatter hooks; use them to customize map output that
originates from a View rather than a field formatter.
