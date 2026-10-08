<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CiviMRF Leaflet Views

Bridges CiviMRF (CMRF) Views and the Leaflet module so remote CiviCRM records can be plotted on an interactive Leaflet map.

- Adds a Views "style" plugin usable on Views whose data source is a CiviMRF (CMRF) connection.
- Outputs CiviCRM contacts/records that carry latitude/longitude as markers on a Leaflet map.
- Lets a decoupled Drupal site visualise CiviCRM geodata without a local copy of the CRM.
- Reuses the standard Leaflet rendering pipeline for tiles, markers and popups.

---

## Installation & configuration

- Depends on `cmrf_core:cmrf_views` and `leaflet:leaflet_views`; install all with Composer/Drush.
- Requires a working CiviMRF connection to a CiviCRM backend (configured via the CMRF core module).
- Enable with `drush en cmrf_leaflet_views`.
- Create a View using a CMRF/CiviCRM data source, then choose the Leaflet map style provided by this module.
- Map the latitude/longitude fields returned by the CiviCRM API to the Leaflet source/target fields.

---

## Usage & API

- Provides `CmrfLeafletMap`, a Views style plugin (`src/Plugin/views/style/CmrfLeafletMap.php`).
- Works only with Views backed by the CMRF Views query plugin (remote CiviCRM data).
- Each result row with valid coordinates becomes a Leaflet marker.
- Marker popups can render configured Views fields for the CiviCRM record.
- No routes, permissions or blocks are defined; all configuration is through the Views UI.
- Choose the map style in the View's "Format" section like any other Views style.
- Latitude/longitude come from the CiviCRM API response surfaced as Views fields.
- Useful for member maps, event maps or donor maps sourced live from CiviCRM.
- Because data is remote, map performance depends on the CiviMRF connection and CiviCRM API latency.
- Combine with Views exposed filters to let users narrow the mapped CiviCRM dataset.
- The Leaflet module controls tile layers, zoom and base map styling.
- No local entities are created; records are fetched per request through CMRF.
- Suitable for decoupled Drupal + CiviCRM architectures.
- Ensure the CiviCRM API/data processor returns coordinate fields for mapping.
- Test the underlying CMRF View returns rows before adding the Leaflet style.
- Caching behaviour follows the CMRF Views query and Leaflet defaults.
