<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Solcast (solcast) — agent index

**Configures a declarative HTTP Client Manager client for the Solcast solar-forecast REST API.**

- **Version:** 2.1.x
- **Core:** ^10.3 || ^11  (PHP >= 8.1)
- **Depends:** http_client_manager
- **Package:** Solcast

**Surface:** no routes/permissions/blocks. Service `solcast.http_services_api.yml` (base_uri `https://api.solcast.com.au`) + Guzzle-services resource YAML under `src/api/resources/` (rooftop_sites forecasts, estimated_actuals; data dictionary). Logger channel `logger.channel.solcast`. Submodules: `solcast_key` (Key-based Authorization header via `AddAuthorizationSubscriber`), `solcast_eca` (ECA action `SetIntervalStart`).

**Security:** developer integration only — no anonymous or mutating endpoints. API base URI is HTTPS; the API secret is supplied out-of-band via a Key entity (solcast_key), not hardcoded.

See [api/client.md](api/client.md).
