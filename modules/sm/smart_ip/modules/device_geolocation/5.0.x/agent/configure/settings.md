# Configure — device_geolocation

Device Geolocation has **no standalone admin page**; its `configure` route is `smart_ip.settings`
(`/admin/config/people/smart_ip`). When enabled it adds a **"Device Geolocation settings"** fieldset
to that form via the `smart_ip.display_admin_settings` event. All values live in the
**`device_geolocation.settings`** config object.

## Activate the source

```bash
drush en device_geolocation -y
drush cset smart_ip.settings data_source device_geolocation -y   # sourceId()
```

Until `smart_ip.settings:data_source` = `device_geolocation`, this source is not used.

## `device_geolocation.settings` keys

| Key | Type | Default | Meaning |
|---|---|---|---|
| `use_ajax_check` | bool | `false` | Poll for the visitor's location via an AJAX call to `/device_geolocation/check` instead of only on page load. Useful when the site/pages are cached. |
| `frequency_check` | float (seconds) | `null` | How often to re-prompt the visitor for their location. `null` disables re-prompting. **The admin form field is in hours** and is stored ×3600 (e.g. 2 hours → `7200`). |
| `google_map_api_key` | string | `null` | Google Maps JS API key (required by the Google Maps / Geocoding calls). |
| `google_map_region` | string | `null` | Google Maps region-localization code. |
| `google_map_language` | string | `null` | Google Maps language-localization code. |

```bash
drush cget device_geolocation.settings use_ajax_check
drush cset device_geolocation.settings google_map_api_key "AIza..." -y
# frequency_check is stored in seconds:
drush php:eval '\Drupal::configFactory()->getEditable("device_geolocation.settings")->set("frequency_check", 7200)->save();'
```

## How it works (no server-side `processQuery`)

`processQuery()` is intentionally empty — the location does **not** come from the server. Instead:

1. `device_geolocation_page_attachments()` runs on allowed pages (`SmartIp::checkAllowedPage()`).
   If `use_ajax_check` is on, or a re-prompt is due (`DeviceGeolocation::isNeedUpdate()`), it
   attaches `device_geolocation/drupal.device_geolocation.core` (and `.check` for AJAX), the
   Google Maps JS API (built from the `google_map_*` settings), and the current location in
   `drupalSettings.device_geolocation`.
2. The browser's W3C Geolocation API returns coordinates; the JS reverse-geocodes them with Google
   Maps and POSTs the result to **`/device_geolocation/client_side_location`**
   (`DeviceGeolocationController::saveLocation`), which stores it on the Smart IP location
   (`smart_ip.smart_ip_location`), sets the source to `w3c`/`geocoded_smart_ip`, and dispatches
   `SmartIpEvents::DATA_ACQUIRED` so other modules can alter it.
3. **`/device_geolocation/check`** (`::check`) returns `{askGeolocate: true|false}` for the AJAX
   poller, based on `SmartIp::checkAllowedPage()` + `DeviceGeolocation::isNeedUpdate()`.

The re-prompt timer is stored in the Smart IP session key `device_geolocation_last_attempt` and is
reset on `hook_user_login()` and `hook_entity_insert()`.

## The visitor block

Block plugin **`visitor_geolocation`** (admin label "Visitor's geolocation",
`Drupal\device_geolocation\Plugin\Block\VisitorGeolocation`) renders the current visitor's location
(`smart_ip.smart_ip_location`->`getData()`) through the `device_geolocation_visitor_info` theme hook
(template `device-geolocation-visitor-info.html.twig`). Cache max-age is 0. Place it like any block
at `/admin/structure/block`.
