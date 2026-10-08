<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Aemet (aemet) — agent index

**Fetches Spanish AEMET OpenData weather forecasts through a cached client service and renders them in a block.**

- **Version:** 2.0.x · **Core:** ^10.3 || ^11 · **Configure:** `aemet.settings`
- **Route:** `aemet.settings` → `/admin/config/services/aemet` (perm: *administer site configuration*).
- **Service:** `aemet.client` (`Client`) — `predictionsSpecific()`, `getApiKey()`, `ping()`. Base URL `https://opendata.aemet.es/opendata`.
- **Block:** `PredictionHourlyBlock` (specific hourly forecast for a locality).
- **Caching:** responses cached in `cache.default` for `requests_max_age`; cid = `aemet.request.<md5(path+model)>`.
- **Security:** admin config route permission-gated; no anonymous or mutating endpoints. HTTP via shared Guzzle `http_client` at default TLS (verification on). API key stored in `aemet.settings` config (textarea). The `datos` follow-up fetch uses a URL from AEMET's trusted response, not user input (no SSRF surface).

See [api/client.md](api/client.md)
