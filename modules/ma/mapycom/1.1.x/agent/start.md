<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mapy.com — agent index

**Module providing support for Mapy.com** (map field/widget/formatter + Views style).
Depends on core `field`, `inline_form_errors`. Composer also pulls `drupal/color_field:^3`
(used by the routeplanner submodule). Version **1.1.4** (branch 1.1.x). Core `^10 || ^11 || ^12`.

Stores a location (`lat`, `lng`, plus matched `originalname`/`originallocation`) in a
`mapycom` field; renders interactive Mapy.com (Mapy.cz) maps via MapLibre GL. Field
formatters: `mapycom_map` (map) and `mapycom_address`. Views style `mapycom_map` plots
many rows on one map. Address search uses the Mapy.com suggest/geocode REST API.

Config at `/admin/config/services/mapycom` (`administer site configuration`): a single
**API key** (`mapycom.settings:api_key`, plain config). Saving the form validates the key
against the Mapy.com Geocoding API and caches its supported language list
(`supported_languages`) for geocoding language selection. The key is attached to
`drupalSettings.mapycom.api_key` so the browser-side MapLibre/geocode calls can use it —
inherent for a client-rendered map. When no key is set, widgets/formatters render a
"service unavailable" stamp instead of a broken map.

Ships submodules (separately enabled): `mapycom_webform` (Webform element/preview),
`routeplanner` + `routeplanner_reference` + their `_webform` variants (route drawing;
depend on `color_field`, `webform`). Media/geospatial; no access-control role, no custom
permissions. Third-party map assets load in the visitor's browser (privacy/consent).

See `../../1.0.x/` for the previous branch. A "Diff 1.0.x → 1.1.x" summary is in `usage.md`.
