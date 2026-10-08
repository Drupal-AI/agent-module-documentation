<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
TEVIS integrates the external VOIS|TEVIS appointment-reservation service so a Drupal site can read and display availability from configured TEVIS servers.

---

TEVIS servers are modelled as config entities (`tevis_server`) with an API endpoint, API key, and connect/request timeouts, managed at `/admin/config/services/tevis` under the `administer tevis` permission. A `TevisClientFactory` builds a `ReservationClient` from the `Tevis\ReservationApi` library using Drupal's core `ClientFactory` (standard Guzzle, TLS verification left at core defaults) and the per-server credentials. An `AvailabilityConfigurationProvider` and `TevisAvailabilityService` fetch and cache availability data (`@cache.default`) so slot lookups aren't re-requested on every page. Servers can be enabled/disabled via CSRF-protected operation links.

Setup: add a TEVIS server with its endpoint and API key, then use the availability service (or provided display integration) to surface bookable slots. All configuration and enable/disable operations are gated by `administer tevis` and CSRF tokens; the module reads availability rather than exposing a public mutation endpoint.
---
- Connect Drupal to a VOIS|TEVIS reservation backend
- Register multiple TEVIS servers as config entities
- Store per-server API endpoint and API key
- Configure connect and request timeouts per server
- Fetch appointment availability from TEVIS
- Cache availability lookups to reduce API calls
- Enable or disable a TEVIS server via a CSRF-protected link
- Display bookable slots sourced from TEVIS
- Manage servers from an admin collection list
- Delete a server configuration
- Use the ReservationApi client library through a factory
- Restrict all TEVIS admin actions to `administer tevis`
- Provide availability data to other modules/blocks
- Support multiple environments (e.g. test/prod TEVIS endpoints)
- Refresh cached availability when configuration changes
