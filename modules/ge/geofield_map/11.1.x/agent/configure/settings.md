# Configure Geofield Map

## Global settings form

- Route: `geofield_map.settings` → path `/admin/config/system/geofield_map_settings`
  (Config → System). Permission: `configure geofield_map`.
- Config object: `geofield_map.settings` (has schema; deployable via config sync).

Keys (defaults from `config/install/geofield_map.settings.yml`):

| Key | Default | Purpose |
|---|---|---|
| `gmap_api_key` | `''` | Google Maps API key, used for **both** map rendering and geocoding (client-side JS). Required for Google maps/geocoding to work. |
| `gmap_api_localization` | `default` | `default` = normal international load; `china` = load tuned for China. |
| `theming.markers_location.security` | `public://` | Stream wrapper for custom marker-icon storage (`private://` only offered if a private path is configured). |
| `theming.markers_location.rel_path` | `geofieldmap_icons` | Relative dir under the wrapper where marker icons live (no leading/trailing slash). |
| `theming.additional_markers_location` | `''` | Extra (e.g. versioned, in-codebase) location also searched for marker icons. |
| `theming.markers_extensions` | `gif png jpg jpeg` | Allowed marker image extensions. |
| `theming.markers_filesize` | `250 KB` | Max marker file size (e.g. `512`, `80 KB`, `50 MB`). |
| `geocoder.caching.clientside` | `session_storage` | Client-side cache of (reverse-)geocoding results: `_none_`, `session_storage`, or `local_storage`. |

Set the API key with drush:
`drush cset geofield_map.settings gmap_api_key 'YOUR_KEY'`

### API key via the Key module (recommended)

If the `key` module is enabled, the API-key field becomes a `key_select`: create a Key
entity holding the value and select it here, so the secret is not stored in plain config.
Without `key`, the raw key string is stored in `geofield_map.settings:gmap_api_key`.

## Enable the widget / formatter / Views style

These are field-UI / Views plugins, not routes — configure them per display:

- **Widget** (`geofield_map`): Manage form display of a bundle with a `geofield` field →
  choose "Geofield Map". Settings include `map_library` (google/leaflet), zoom levels,
  `map_type_selector`, `click_to_place_marker` / `click_to_find_marker` /
  `click_to_remove_marker`, `map_google_places` (address geocoding), and `geoaddress_field`
  (write the geocoded address into another field). Widget settings schema:
  `field.widget.settings.geofield_map` (extends `field.widget.settings.geofield_latlon`).
- **Formatter** (`geofield_google_map`): Manage display → choose "Geofield Google Map".
  Settings groups: `map_dimensions`, `map_center`, `map_zoom_and_pan`, `map_controls`,
  `map_marker_and_infowindow` (icon, infowindow field/view_mode, tooltip), `map_oms`
  (overlapping-marker spiderfier), `custom_style_map`, `map_markercluster`, `map_geocoder`,
  `map_additional_libraries`, `map_lazy_load`. Schema: `field.formatter.settings.geofield_google_map`.
- **Views style** (`geofield_google_map`): in a View display choose the "Geofield Google Map"
  format and add a `geofield` field to the Fields list. Style options mirror the formatter
  and add MapThemer marker theming (see plugins/plugins.md).

## Permissions

Defined in `geofield_map.permissions.yml`:

- `configure geofield_map` — access the Geofield Map settings form.
