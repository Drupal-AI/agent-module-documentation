# Geolocation field, widgets & formatters

## Field type
`geolocation` (`src/Plugin/Field/FieldType/GeolocationItem.php`) — stores `lat` and `lng`
(plus derived/computed proximity data). Add it like any field at
`/admin/structure/types/manage/<bundle>/fields`.

## Widgets (Manage form display)
- **Geolocation Lat/Lng** (`GeolocationLatlngWidget`) — plain numeric lat/lng inputs.
- **Geolocation Map** (`GeolocationMapWidget`) — pick a point on an interactive map, with
  optional geocoding of an address into coordinates. Requires an enabled map provider submodule.

## Formatters (Manage display)
- **Map** (`GeolocationMapFormatter`) — interactive map with markers.
- **Lat/Lng** (`GeolocationLatlngFormatter`) — raw decimal coordinates.
- **Sexagesimal** (`GeolocationSexagesimalFormatter`) — degrees/minutes/seconds.
- **Token** (`GeolocationTokenFormatter`) — text built from tokens.
- **Image EXIF Map** (`ImageExifMapFormatter`) — map from image GPS EXIF data.

## Choosing a map provider
Maps need a provider: enable `geolocation_google_maps` (set API key at
`geolocation_google_maps.settings`) or `geolocation_leaflet` (open tiles, no key). The map
widget/formatter settings then let you select the provider, map center strategy, and map
features (markers, clustering, controls, popups).

## Config
Schema under `config/schema/geolocation.*.schema.yml`; all field/formatter/widget settings are
exportable configuration. A field-map-widget block is also provided
(`config/schema/geolocation.block.schema.yml`).
