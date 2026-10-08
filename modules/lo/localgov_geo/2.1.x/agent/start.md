<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Geo (localgov_geo) — agent index

LocalGov Drupal wrapper around the contrib **Geo Entity** module (`geo_entity:geo_entity`, the sole
dependency). It does NOT define the `geo_entity` entity type — since 2.x that lives in geo_entity.
This module adds: a UK **Ordnance Survey Places** geocoder-provider plugin, install-time permission
defaults, LocalGov role defaults, and editorial relabelling ("Geo"/"Geos" → "Location(s)"). Two
content bundles (address, area) ship as submodules.

No `configure` route of its own. No permissions, routing, services, blocks, or Drush of its own.
Ships ONE config-schema file (for the geocoder plugin config) and implements hooks only.

Submodules (own doc dirs):
- `localgov_geo_address` — point + structured postal-address bundle.
- `localgov_geo_area` — polygon/area bundle.
- `localgov_geo_update` — hidden bridge migrating pre-2.x installs onto geo_entity.

What you'd do:
- **Configure UK address geocoding (OS Places API + API key)** → [configure/os-places-geocoder.md](configure/os-places-geocoder.md)
- **Understand the hooks it implements (roles, relabels, install-time grants)** → [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Geocoder provider plugin id **`localgov_os_places`** — class `LocalgovOsPlacesGeocoder`
  (`@GeocoderProvider`, extends geocoder's `ConfigurableProviderUsingHandlerWithAdapterBase`). The
  actual lookup handler is the external `\LocalgovDrupal\OsPlacesGeocoder\Provider\OsPlacesGeocoder`
  from the suggested `localgovdrupal/localgov_os_places_geocoder_provider` package (not bundled).
  Default endpoints `https://api.os.uk/search/places/v1/find` and `.../v1/postcode`.
- Config-schema key `geocoder_provider.configuration.localgov_os_places`
  (`apiKey`, `genericAddressQueryUrl`, `postcodeQueryUrl`, `throttle.period`, `throttle.limit`, `userAgent`).
- The project ships pre-configured for OpenStreetMap tiles + geocoding (per README) so it works
  before any API key exists; OS Places is the opt-in UK upgrade.
- `hook_install($is_syncing)` grants `view geo` to the anonymous AND authenticated roles (skipped
  during config sync); it first calls `\Drupal::service('router.builder')->rebuild()` to work around
  a filter-module route-cache ordering issue when both modules enable in one `ModuleInstaller` call.
- `localgov_geo_update_last_removed()` returns `8810`; `localgov_geo_update_10001()` grants
  `create geo` + `access geo_entity_library entity browser pages` to `localgov_editor`,
  `localgov_author`, `localgov_contributor`.
- `hook_localgov_roles_default()` maps geo permissions onto the LocalGov Editor/Author/Contributor roles.
- Presentational hooks: `hook_menu_local_actions_alter`, `hook_menu_local_tasks_alter`,
  `hook_preprocess_breadcrumb`, `hook_preprocess_html`, `hook_preprocess_page_title`.
- Permission strings used (all DEFINED by geo_entity, not here): `view geo`, `access geo overview`,
  `create geo`, `edit any geo`, `delete any geo`, `access geo_entity_library entity browser pages`.
- Known geocoder-module quirk (README): a new provider plugin may not appear in the *Geocoder
  provider* dropdown at `/admin/config/system/geocoder/geocoder-provider` until PHP is restarted.
