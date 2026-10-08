<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Geomap Field (geomap_field) — agent index

A composite **field type** that stores a postal address plus latitude/longitude, with a **map-picker
widget** and a **map formatter** (Leaflet). Package `Field types`. Core requirement
`^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.1.0.

- **The field type, its columns/schema, the widget, the formatter, provider selection, and how to
  operate it** → [fields/geomap.md](fields/geomap.md)

## Dependencies

- `drupal:field` (core).
- **`geolocation_provider`** — pluggable geocoding backends (Nominatim, BANO, …). Supplies the
  `plugin.manager.geolocation_provider_plugin` manager and the `/geolocation_provider/geolocation/…`
  and `/geolocation_provider/reverse/…` endpoints the widget JS calls. **Not** part of this module.
- **`map_provider`** — pluggable map/tile providers and the `#type => 'map'` render element +
  `map_provider/map` (Leaflet) library. Supplies `plugin.manager.map_provider`. **Not** part of
  this module.

## What it actually provides (from source)

- **Field type** `geomap` — `src/Plugin/Field/FieldType/GeomapItem.php` (`@FieldType`, label
  *"Geomap"*, `default_widget = "geomap_default"`, `default_formatter = "geomap_default"`).
  Properties/columns: `address_name`, `street`, `zipcode`, `city`, `country`, `additional`
  (all `varchar(255)`), `lat`, `lon` (`numeric` 18,12), `feature` (`text`, raw GeoJSON).
- **Widget** `geomap_default` — `src/Plugin/Field/FieldWidget/GeomapDefault.php`. Address text
  fields + a draggable-marker map + a *"Try to geolocate the address"* button. Settings:
  `geolocation_provider` (default `bano_geolocation_provider`), `map_provider`
  (default `yaml_map_provider:osm`). JS: `js/geomap-default-widget.js`.
- **Formatter** `geomap_default` — `src/Plugin/Field/FieldFormatter/GeomapDefault.php`. Read-only
  map centred on stored `lat`/`lon` with a fixed marker. Settings: `map_provider`, `height`
  (`350px`), `width` (`350px`). JS: `js/geomap-default-formatter.js`.
- **Install hook** `geomap_field_update_8001` (`geomap_field.install`) — adds the `_address_name`
  column to existing `geomap` field tables/revision tables (schema catch-up update, not a fresh
  install step).

## Not present

No routes, no permissions, no services, no config entities, no config schema, no Drush, no
submodules, no `composer.json`. All geocoding HTTP and all tile/API-key handling live in the two
dependency modules, not here. Configured entirely per view/form-display on *Manage form display*
and *Manage display* — there is no global settings page.
