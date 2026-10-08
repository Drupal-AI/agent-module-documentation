Device Geolocation is a Smart IP data source that gets the visitor's location from their own device (the browser's W3C/HTML5 Geolocation API) and reverse-geocodes the coordinates with Google Maps, instead of from their IP address. It also ships a "Visitor's geolocation" block that renders the current visitor's detected location.

---

This Smart IP submodule registers the data source `device_geolocation`. Enable it and set `smart_ip.settings:data_source` to `device_geolocation` to use client-side geolocation. Unlike the IP-based sources it has no `processQuery()` server lookup; instead `hook_page_attachments()` attaches JavaScript (`device_geolocation/drupal.device_geolocation.core`, optionally `.check`) plus the Google Maps JS API, prompts the browser for its location, and POSTs the coordinates to the controller route `/device_geolocation/client_side_location`, which stores them on the Smart IP location (source `w3c` / `geocoded_smart_ip`) and dispatches `SmartIpEvents::DATA_ACQUIRED`. Its config object `device_geolocation.settings` has: `use_ajax_check` (bool, default false — poll for location via AJAX, useful when pages are cached), `frequency_check` (float seconds, default null = disabled — how often to re-prompt; the admin form takes hours and multiplies by 3600), `google_map_api_key`, `google_map_region`, and `google_map_language` (Google Maps localization). A second route `/device_geolocation/check` answers whether a re-prompt is due. Settings are edited inside Smart IP's own admin form at `/admin/config/people/smart_ip` (this submodule injects a "Device Geolocation settings" fieldset via the `smart_ip.display_admin_settings` event; `configure` = `smart_ip.settings`). Because the data comes from the device, accuracy can be far higher than IP geolocation (real GPS on mobile), at the cost of a browser permission prompt and a Google Maps API key.

---

- Get a visitor's precise location from their device's GPS/browser instead of their IP address.
- Use the browser's W3C/HTML5 Geolocation API as the Smart IP data source (`data_source: device_geolocation`).
- Reverse-geocode device coordinates to country/region/city via the Google Maps Geocoding service.
- Display the current visitor's detected location with the "Visitor's geolocation" block (`visitor_geolocation`).
- Prompt visitors to share their location and store the result in the Smart IP session.
- Re-prompt for an updated location on a schedule via `frequency_check` (hours in the UI, stored as seconds).
- Enable AJAX-based location checking (`use_ajax_check`) so it still works when pages are cached.
- Configure a Google Maps API key (`google_map_api_key`) required by the Google Maps JS/Geocoding calls.
- Localize the Google Maps service by region (`google_map_region`) and language (`google_map_language`).
- Feed device-derived coordinates into `SmartIp::query()` / the `smart_ip.smart_ip_location` service.
- Let other modules alter the client-side location by subscribing to `smart_ip.data_acquired`.
- Show map-accurate visitor coordinates (latitude/longitude) for store locators or "near me" features.
- Combine device geolocation with Smart IP's allowed-pages control so the prompt only fires on chosen paths.
- Provide higher-accuracy geolocation on mobile devices than any IP database can offer.
- Reset the re-prompt timer automatically when a visitor logs in or content is created (built-in hooks).
- Use as a privacy-forward alternative where the visitor explicitly consents to sharing their location.
- Personalize content (currency, language, nearest branch) from the device's real position.
