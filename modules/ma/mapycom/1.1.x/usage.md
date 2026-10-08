<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mapy.com provides field support for the Mapy.com mapping service.

---

Mapy.com (mapycom) **integrates the Mapy.com mapping service** (formerly Mapy.cz) — it adds
a `mapycom` field that stores a location (`lat`/`lng` plus the matched place name and
location text), a widget to pick that point on an interactive MapLibre GL map with address
autocomplete, two formatters (`mapycom_map` for a map, `mapycom_address` for a single-marker
address view), and a `mapycom_map` Views style to plot many rows on one map. It depends on
core Field and Inline Form Errors; Composer also installs `drupal/color_field` (used by the
routeplanner submodule).

Configure it at **Configuration → Web services → Mapy.com** (`/admin/config/services/mapycom`,
requires *administer site configuration*). You enter a **Mapy.com API key**, which is stored
in `mapycom.settings` configuration. Because the map, tiles, address suggest and geocoding
all run in the visitor's browser against the Mapy.com REST API, the key is passed to the page
as `drupalSettings.mapycom.api_key` — this is how a client-side map is expected to work.
Saving the settings form calls the Mapy.com Geocoding API to validate the key and records the
languages that API supports so geocoding uses the site language when possible (falling back to
English). If no key is configured, the widget and formatters show a "service unavailable"
stamp rather than a broken map, and the Status report warns admins. It embeds third-party map
assets (privacy/consent) and has no access-control role or custom permissions.

**Diff 1.0.x → 1.1.x** (relative to the 1.0.x docs / source):
- Core support widened to include Drupal 12 (`^10 || ^11 || ^12`).
- New Composer dependency `drupal/color_field:^3.0` (consumed by the routeplanner submodule).
- Webform support moved out of the base module into a separate `mapycom_webform` submodule
  (Webform element + read-only map preview controller, access-gated by
  `webform_submission.view`).
- New **routeplanner** submodule family (`routeplanner`, `routeplanner_reference`,
  `routeplanner_webform`, `routeplanner_reference_webform`) for drawing routes.
- API key is now **server-side validated** on save against the Mapy.com Geocoding API, and
  the supported-language list is cached in config (`supported_languages`, `default_language`)
  to drive geocoding language selection (`geocoding_lang` in drupalSettings).
- Added the `mapycom_address` formatter and an SVG "API key required / service unavailable"
  stamp placeholder shown when no key is set.
- Expanded widget/formatter/Views options: marker-label toggles (lat/lng/place name/
  description/node title), navigation-control settings (pitch, roll, zoom, compass, position),
  scroll-zoom disabling, auto-zoom-to-fit, and a points-of-interest toggle.

---

- Integrate Mapy.com (Mapy.cz) interactive maps into Drupal.
- Provide a `mapycom` field storing latitude, longitude and matched place text.
- Let editors pick a location on a map with address autocomplete.
- Render a location as an interactive map with the `mapycom_map` formatter.
- Render a single address marker with the `mapycom_address` formatter.
- Plot many entities on one map with the `mapycom_map` Views style.
- Support AJAX filtering and dynamic map updates.
- Offer selectable base layers (basic, outdoor, winter, aerial) and a layer switcher.
- Configure marker labels: latitude, longitude, place name, description, node title.
- Configure navigation controls: pitch, roll, zoom, compass, and control position.
- Disable scroll-wheel zoom on mobile or all devices.
- Auto-zoom and center the map to fit the markers shown.
- Toggle a points-of-interest layer on formatter output.
- Store the Mapy.com API key in module configuration.
- Validate the API key against the Geocoding API when saving settings.
- Detect and cache geocoding languages, using the site language where supported.
- Show a "service unavailable" stamp when no API key is configured.
- Warn administrators on the Status report when the key is missing or unverified.
- Add Webform location elements via the optional `mapycom_webform` submodule.
- Draw routes via the optional routeplanner submodule family.
- Serve Czech Mapy.com maps for directories, branch finders and location listings.
- Load third-party Mapy.com map assets in the browser (privacy/consent).
