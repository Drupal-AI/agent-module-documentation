# Device Geolocation (device_geolocation) — agent index

A **Smart IP data source** that reads the visitor's location from their **device/browser** (W3C
Geolocation API) and reverse-geocodes it with **Google Maps**, rather than from their IP. Depends
on `smart_ip`. No admin page of its own — injects a "Device Geolocation settings" fieldset into
Smart IP's form (`/admin/config/people/smart_ip`).

**To activate:** `drush en device_geolocation -y`, then set
`smart_ip.settings:data_source` = **`device_geolocation`** (this source's `sourceId()`).

- **Config keys, the client-side routes, the visitor block, and how it works** →
  [configure/settings.md](configure/settings.md)

Key facts:
- `sourceId()` = `device_geolocation`; `configName()` = `device_geolocation.settings`.
- Config `device_geolocation.settings`:
  - `use_ajax_check` — bool, default **false**. Poll for location via AJAX (use when pages cached).
  - `frequency_check` — float **seconds**, default **null** (disabled). How often to re-prompt.
    The admin form field is in **hours** and is stored ×3600.
  - `google_map_api_key` / `google_map_region` / `google_map_language` — Google Maps setup.
- Unlike IP sources, `processQuery()` is a **no-op**; location arrives from the browser. JS is
  attached in `hook_page_attachments()` and POSTs coordinates to the controller.
- Routes: `/device_geolocation/client_side_location` (`saveLocation`, stores coords + dispatches
  `smart_ip.data_acquired`), `/device_geolocation/check` (`check`, is a re-prompt due) — both
  `_permission: 'access content'`.
- Block plugin `visitor_geolocation` ("Visitor's geolocation") renders the current
  `smart_ip.smart_ip_location` data via the `device_geolocation_visitor_info` theme hook.
- Location source constants set: `SmartIpLocationInterface::W3C` (`w3c`) /
  `GEOCODED_SMART_IP` (`geocoded_smart_ip`).
- Query API, location keys, events, the data-source model: see
  modules/sm/smart_ip/5.0.x/agent/ (`api/location.md`, `extend/data-source.md`).
