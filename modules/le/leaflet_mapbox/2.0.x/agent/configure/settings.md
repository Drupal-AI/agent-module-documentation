<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Mapbox maps

- **Route / UI:** `leaflet_mapbox.settings` → `/admin/config/services/leaflet-mapbox`
  (menu: Configuration → Web Services → Leaflet Mapbox). Permission: `administer site configuration`.
- **Config object:** `leaflet_mapbox.settings`, single key `maps` — a sequence keyed by machine name.
- **Form:** `Drupal\leaflet_mapbox\Form\SettingsForm` — AJAX "Add another map" / "Remove this map";
  removal only takes effect on save. New maps get a machine key derived from the label.

## Per-map fields (config schema)

| Key | Type | Notes |
|---|---|---|
| `label` | label | Required. Shown in Leaflet's display-options form. |
| `api_version` | string | `'3'` (Mapbox Studio Classic) or `'4'` (Mapbox Studio, recommended). |
| `code` | string | API 3 only — the map code from Mapbox's mapbox.js button. |
| `style_url` | string | API 4 only — e.g. `mapbox://styles/johndoe/erl4zrwto008ob3f2ijepsbszg`. |
| `token` | string | Mapbox **access token** (use a public `pk.*` token). Required. |
| `zoomlevel` | integer | Default zoom 0–19 (map `zoom`). Clear caches after changing. |
| `description` | text | Optional. |

## How a map is exposed to Leaflet

`LeafletMapboxHooks::leafletMapInfo()` (`#[Hook('leaflet_map_info')]`) converts each stored map
into a Leaflet map definition. The map **id** given to Leaflet is:

- `leaflet-mapbox` for the map keyed `default` (the migrated 1.x map — keeps the legacy id),
- `leaflet-mapbox-{key}` for every other map.

The tile layer `urlTemplate` is built client-side with the token appended:

- **API 4:** `//api.mapbox.com/styles/v1/{username}/{styleid}/tiles/{z}/{x}/{y}?access_token={token}`
  (`username`/`styleid` parsed from `style_url`; `tileSize: 512`, `zoomOffset: -1`).
- **API 3:** `//{s}.tiles.mapbox.com/v4/{code}/{z}/{x}/{y}.png?access_token={token}`.

Fixed Leaflet map settings include `maxZoom: 19`, `minZoom: 0`, `zoomControl`, `scrollWheelZoom`,
`worldCopyJump` (all true), `layerControl: false`, and `zoom` from `zoomlevel`.

To use a map: enable/configure a Leaflet map (Leaflet Views style, or a geofield Leaflet
formatter) and pick the map by its label / id above.

## Drush

Read: `drush cget leaflet_mapbox.settings`. Write a map via config import, e.g.

```yaml
# leaflet_mapbox.settings.yml
maps:
  default:
    label: 'My Mapbox'
    api_version: '4'
    code: ''
    style_url: 'mapbox://styles/johndoe/erl4zrwto008ob3f2ijepsbszg'
    token: 'pk.eyJ1Ijoi...'
    zoomlevel: 2
    description: ''
```

`drush cim --partial --source=…`, then `drush cr` (the map info is cache-dependent).

## Migration from 1.x

`leaflet_mapbox_update_10201()` moves the old flat single-map keys into
`maps.default`. Until update.php runs, `leafletMapInfo()` reads the legacy flat keys directly and
exposes them as the `leaflet-mapbox` map, so existing views keep working.
