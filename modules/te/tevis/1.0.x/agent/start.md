<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TEVIS (tevis) — agent index

**Integrates the external VOIS|TEVIS reservation service; TEVIS servers are config entities and availability is fetched/cached via a client factory.**

- **Version:** 1.0.x
- **Core:** ^10 || ^11 || ^12
- **Configure:** `/admin/config/services/tevis` (`administer tevis`)
- **Entity:** `tevis_server` (endpoint, api_key, connect/request timeouts)
- **Services:** `tevis.client_factory` (core `ClientFactory` → `ReservationClient`), `tevis.availability.configuration_provider`, `tevis.availability.service` (cached)
- **Ops:** enable/disable routes require `_entity_access` + `_csrf_token`
- **Access:** All routes gated by `administer tevis`; enable/disable are CSRF-protected. HTTP client built from core `ClientFactory`. No public mutation endpoint.
