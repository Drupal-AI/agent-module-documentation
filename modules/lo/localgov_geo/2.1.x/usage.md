<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocalGov Geo gives a LocalGov Drupal site reusable geographic records — a shared location entity (points with structured addresses, or polygon areas) built on the contrib Geo Entity module, pre-wired to OpenStreetMap tiles and geocoding, with an optional Ordnance Survey Places geocoder for accurate UK address and postcode lookup.

---

Since version 2 the location entity itself lives in the contrib **Geo Entity** module (`geo_entity`, the single dependency); LocalGov Geo is the LocalGov-flavoured wrapper. It supplies the UK **Ordnance Survey Places** geocoder-provider plugin (`localgov_os_places`, class `LocalgovOsPlacesGeocoder`), install-time and role defaults, and editorial polish. The two content bundles ship as submodules — `localgov_geo_address` (a point plus a structured postal address) and `localgov_geo_area` (polygons) — while a hidden `localgov_geo_update` submodule bridges pre-2.x installs onto Geo Entity. The polish is mostly presentational: `hook_menu_local_actions_alter()` / `hook_menu_local_tasks_alter()` and the breadcrumb, html and page-title preprocess hooks rename "Geo"/"Geos" to "Location(s)". The OS Places plugin wraps the external `localgovdrupal/localgov_os_places_geocoder_provider` package (a composer suggest) and needs an API key that is free for UK local authorities; its defaults already point at the live OS endpoints, so only the key must be set. Out of the box the project defaults to OpenStreetMap for both tiles and geocoding, so it works before any key is obtained. One install-time behaviour is worth knowing: `hook_install()` grants `view geo` to both anonymous and authenticated roles, with a source comment explaining that location data is intended to be public and that Search API indexes what anonymous users can see. `hook_localgov_roles_default()` and `localgov_geo_update_10001()` map the create/edit/overview geo permissions onto the LocalGov Editor, Author and Contributor roles.

---

- Store an address once and reference it from many content items.
- Attach a geocoded location to a directory venue.
- Draw a ward or catchment boundary as a polygon.
- Geocode UK addresses and postcodes accurately with Ordnance Survey Places.
- Fall back to OpenStreetMap geocoding without an API key.
- Show locations on OpenStreetMap tiles by default.
- Reuse one location record across events, venues and services.
- Support proximity search by supplying coordinates to Search API.
- Keep location data in a dedicated entity rather than duplicated fields.
- Let editors search for an address rather than typing coordinates.
- Swap the geocoder provider without changing content.
- Publish location data so it appears in anonymous search results.
- Model both point locations and areas in one system.
- Migrate legacy LocalGov Geo data onto Geo Entity.
- Give locations their own pages with tidy breadcrumbs and titles.
- Share a location between two services that operate from one building.
- Provide coordinates for map rendering.
- Support address autocomplete in editorial forms.
- Keep UK postcode lookups accurate for council services.
- Give LocalGov editor/author/contributor roles sensible geo permissions by default.
- Configure OS Places request throttling (period and request limit).
- Point the geocoder at a custom OS-compatible endpoint via config.
