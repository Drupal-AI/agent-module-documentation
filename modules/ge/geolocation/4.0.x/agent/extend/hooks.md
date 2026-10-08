# Geolocation hooks

Declared in `geolocation.api.php`.

| Hook | Purpose |
|---|---|
| `hook_geolocation_field_map_widget_alter(&$element, $context)` | Alter the map-based field widget render element before display. `$context` = `['widget' => GeolocationMapWidgetBase, 'form_state' => FormStateInterface, 'field_definition' => FieldDefinitionInterface]`. |

Most extension is done through the module's plugin types rather than hooks — see
[plugins/plugins.md](../plugins/plugins.md) to add map providers, features, geocoders, etc.
Hook logic in the module itself is organized under `src/Hook/` (OOP hook classes).
