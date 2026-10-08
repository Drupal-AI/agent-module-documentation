<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Iplicit API (iplicit_api) — agent index

**Authenticated HTTP client service for the Iplicit accounting API: session-token handling, mandatory Domain header, and Key-based secret storage. A library for other modules — no business logic.**

- **Version:** 1.0.x (release 1.0.0-rc3) — core `^10.3 || ^11`; depends on `key`
- **Config:** `/admin/config/services/iplicit` (`administer iplicit api`, restricted) — base URI, domain, username, key ID, timeout, enabled/debug
- **Services:** `iplicit_api.client` (IplicitClient), `.session_manager`, `.http_client_builder`, `.credential_provider`
- **Security:** API key held in a Key entity (env/file provider) — only the key ID is in config; outbound client uses core `ClientFactory` with **default TLS verification** (no `verify => false`); session token cached in `cache.default` (30-min cap, fingerprint-keyed) and never logged. No security findings. (Operational note: a DB dump within the token window contains a usable bearer token — prefer env/file Key providers.)

See [api/client.md](api/client.md) and [configure/connection.md](configure/connection.md).
