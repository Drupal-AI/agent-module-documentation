# Geofield plugin types

Geofield defines two plugin types you can implement.

## GeofieldBackend — geometry storage
- Manager: `plugin.manager.geofield_backend` (`GeofieldBackendManager`), directory
  `Plugin/GeofieldBackend`, interface `GeofieldBackendPluginInterface`, annotation
  `@GeofieldBackend` (`id`, `admin_label`, `description`). Alter hook: `hook_geofield_alter`.
- Interface: `schema()` (returns the DB column schema for the stored `value`) and
  `save($geometry)` (transform the geometry into the stored representation).
- Bundled: `geofield_backend_default` (WKB), `geofield_backend_postgis` (PostGIS geometry).

```php
/**
 * @GeofieldBackend(
 *   id = "my_backend",
 *   admin_label = @Translation("My backend"),
 *   description = @Translation("Stores geometry as …")
 * )
 */
class MyBackend extends GeofieldBackendBase {
  public function schema() { /* return ['type' => …] */ }
  public function save($geometry) { /* return string to store */ }
}
```
Selected per field via the `backend` storage setting.

## GeofieldProximitySource — distance origin for Views
- Manager: `plugin.manager.geofield_proximity_source` (`GeofieldProximitySourceManager`),
  directory `Plugin/GeofieldProximitySource`, interface `GeofieldProximitySourceInterface`,
  annotation `@GeofieldProximitySource` (`id`, `label`, `description`, `context`
  [filter|sort|field], `exposedOnly`). Alter hook: `hook_geofield_geofield_proximity_source_info_alter`.
- Key methods: `getOrigin()/setOrigin()`, `getProximity($lat, $lon)`, `getUnits()/setUnits()`,
  `buildOptionsForm()`, `validateOptionsForm()`, `setViewHandler()`.
- Extend `GeofieldProximitySourceBase`. Bundled sources listed in
  [api/views.md](../api/views.md).
