<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Bizzabo connector

1. `/admin/config/eventapi/baseUrl` — set `bizabooapibaseurl` (the events endpoint) and `auth_key` (bearer token). Requires `administer site configuration`.
2. `/admin/config/test_connection` — validates the connection and echoes masked response params.
3. Point visitors at `/bizabo/fetch/events` to see the rendered listing (`getDisplayEvents`).

Routes and access:
- `bizzabo_connector.get_results` `/bizabo/fetch/events` → `_access: "TRUE"` (anonymous, read-only listing).
- `bizzabo_connector.api_results` `/admin/config/api/param` → `_access: "TRUE"` (anonymous; controller `testConnection` is a stub that prints and exits).
- `bizzabo_connector.get_keys` `/admin/bizabo/fetch/events/params` → `administer site configuration`.

API calls: `fetchApiResults()` uses a Guzzle `Client` with header `Authorization: bearer <auth_key>` (default TLS verification).
