<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Agent orientation: cmrf_leaflet_views

**What:** A Views style plugin plotting CiviMRF (CMRF) CiviCRM data on a Leaflet map.

**Key file:** `src/Plugin/views/style/CmrfLeafletMap.php` (Views style plugin).

**Deps:** `cmrf_core:cmrf_views`, `leaflet:leaflet_views`.

**Config:** Views UI only — no routes/permissions. Requires a CMRF-backed View with lat/lng fields.

**Security:** no HTTP endpoints of its own; data access governed by the CMRF connection and Views.
