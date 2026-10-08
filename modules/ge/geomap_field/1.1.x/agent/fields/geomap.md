<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `geomap` field type, widget and formatter

## Install & enable

```bash
composer require drupal/geomap_field drupal/geolocation_provider drupal/map_provider
drush en geomap_field -y
```

Dependencies (from `geomap_field.info.yml`): core `field`, plus contrib `geolocation_provider`
and `map_provider`. No sub-modules, no permissions, no Drush, no global config form. There is no
`composer.json` in the project, so pin the two contrib deps explicitly.

## Field type — `GeomapItem`

`src/Plugin/Field/FieldType/GeomapItem.php`, `@FieldType(id = "geomap", default_widget =
"geomap_default", default_formatter = "geomap_default")`. It is a **composite** field: one field
delta holds a whole address plus coordinates.

`propertyDefinitions()` / `schema()` columns:

| Column | Type | Notes |
|---|---|---|
| `address_name` | `varchar(255)` | Display name for the place. |
| `street` | `varchar(255)` | |
| `zipcode` | `varchar(255)` | |
| `city` | `varchar(255)` | |
| `country` | `varchar(255)` | |
| `additional` | `varchar(255)` | Extra address line. |
| `lat` | `numeric(18,12)` | Latitude. Property type `float`. |
| `lon` | `numeric(18,12)` | Longitude. Property type `float`. |
| `feature` | `text` | Raw GeoJSON of the matched place, set by the widget JS. |

Notes:
- Every property is declared `setRequired(TRUE)`, but `isEmpty()` returns empty only when
  `street`, `zipcode`, `city`, `country`, `lat` **and** `lon` are all empty — so an all-blank
  delta is dropped rather than failing validation.
- `defaultStorageSettings()` adds nothing (its body is commented out); there are no per-field
  storage settings.
- `generateSampleValue()` returns only `['street' => '42 lorem ipsum, 424242, Dolor']` (Devel
  sample data). `setValue()` overrides the base to flatten a nested values tree by walking keys
  that match the known properties.
- **No config schema ships** for the field/widget/formatter settings (there is no `config/schema/`
  directory), so strict config-schema tooling may warn on the view/form-display config; the
  settings still save and work.

## Widget — `geomap_default` (map picker)

`src/Plugin/Field/FieldWidget/GeomapDefault.php`. Select it on *Manage form display*.

`defaultSettings()`: `geolocation_provider` = `bano_geolocation_provider`,
`map_provider` = `yaml_map_provider:osm`. `settingsForm()` builds two selects populated from the
plugin managers `plugin.manager.geolocation_provider_plugin` and `plugin.manager.map_provider`
(`getDefinitions()` → id ⇒ label). `settingsSummary()` echoes the chosen labels.

`formElement()` renders (all inside a `#type => 'details'`):
- text fields `address_name`, `street`, `zipcode`, `city`, `country`, `additional`
  (`#required` mirrors the element's required flag);
- a `#type => 'button'` *"Try to geolocate the address"* (class `geomap-geolocation-btn`);
- a `latlon` details with `lat` / `lon` text fields (classes `geomap-field-lat` /
  `geomap-field-lon`);
- a **hidden** `feature` field holding GeoJSON;
- a `#type => 'map'` element (from `map_provider`) with `#tile_url => $map_provider->getUrl()`,
  `#attribution => $map_provider->getAttribution()`, `#center => [lat ?? 51.505, lon ?? -0.09]`,
  `#zoom => 13`, and `data-geolocation-plugin` set to the chosen geolocation plugin id;
- a suggestions `<ul>` and a spinner `<div>`.
- `#attached` library `geomap_field/geomap_default_widget`.

Widget JS (`js/geomap-default-widget.js`, `Drupal.behaviors.geomapDefaultWidget`, using
`core/once`) — on the Leaflet `map:afterInit` event:
- adds a **draggable** `L.marker`; on `dragend` it writes the new lat/lng into the fields and
  `$.get('/geolocation_provider/reverse/<plugin>/<lat>/<lng>')` to reverse-geocode, filling the
  suggestions list and the hidden `feature` input from `data.features[0]`;
- the geolocate button `$.get('/geolocation_provider/geolocation/<plugin>/<address>')` (address =
  `street, zipcode city, country`) and, on success, sets lat/lon from
  `feature.geometry.coordinates` and re-centres the marker;
- lat/lon `input` events (debounced 200 ms) move the marker;
- clicking a suggestion fills `street`/`zipcode`/`city` from `feature.properties` and stores the
  feature. Suggestion labels are inserted with jQuery `.text()`.

The geocoding endpoints (`/geolocation_provider/…`) belong to the **`geolocation_provider`**
module, not to geomap_field; this widget only calls them.

## Formatter — `geomap_default` (map display)

`src/Plugin/Field/FieldFormatter/GeomapDefault.php`. Select it on *Manage display*.

`defaultSettings()`: `map_provider` = `yaml_map_provider:osm`, `height` = `350px`,
`width` = `350px`. `settingsForm()` offers a map-provider select (from
`plugin.manager.map_provider`) plus Height and Width text fields (the description notes Leaflet
needs an explicit height). `settingsSummary()` lists the three values.

`viewElements()` — for each item builds a `#type => 'map'` element: `#tile_url` /
`#attribution` from the selected map-provider plugin (falls back to `yaml_map_provider:osm` when
empty), `#center => [lat ?? 51.505, lon ?? -0.09]`, `#zoom => 13`, class `geomap-formatter-map`,
`#attached` library `geomap_field/geomap_default_formatter`, and an inline `style` built from the
Height/Width settings. The formatter renders **only the map + marker** — none of the address text
columns are printed. Formatter JS (`js/geomap-default-formatter.js`) adds a **non-draggable**
marker at the map centre on `map:afterInit`.

## Provider selection cheatsheet

- **Geolocation provider** (widget only): plugin id from `geolocation_provider`, e.g.
  `bano_geolocation_provider`, a Nominatim provider, etc. Controls the geocode/reverse-geocode
  backend and thus which third party receives the address string.
- **Map provider** (widget + formatter): plugin id from `map_provider`, e.g.
  `yaml_map_provider:osm`. Controls the Leaflet tile URL, attribution, and any provider API key —
  all of that is configured in `map_provider`, not here.

## Config example (view display)

```yaml
# core.entity_view_display.node.place.default
content:
  field_location:
    type: geomap_default
    label: above
    settings:
      map_provider: 'yaml_map_provider:osm'
      height: '350px'
      width: '350px'
```

```yaml
# core.entity_form_display.node.place.default
content:
  field_location:
    type: geomap_default
    settings:
      geolocation_provider: 'bano_geolocation_provider'
      map_provider: 'yaml_map_provider:osm'
```

## Operate / gotchas

- Coordinates are stored, so display pages **do not geocode at request time** — that is the whole
  performance point.
- The map needs a non-zero height; the formatter's Height setting (or your CSS) must provide it or
  Leaflet renders a collapsed map.
- `geomap_field_update_8001` (in `.install`) back-fills the `_address_name` column on pre-existing
  `geomap` fields and their revision tables — run `drush updatedb` after upgrading an old install;
  it is a schema catch-up, not needed for fresh field creation.
- Geocoding sends the entered address to whichever `geolocation_provider` backend is selected (a
  third-party request); choose the provider accordingly for sites holding personal addresses.
