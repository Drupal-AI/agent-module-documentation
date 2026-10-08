<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Crowdriff API (crowdriff_api) — agent index

**Client + admin config for the CrowdRiff v2 visual/UGC media API (folders, albums, assets, search).**

- **Version:** 1.0.x
- **Core:** ^9 || ^10
- **Dependencies:** key:key
- **Config route:** `crowdriff_api.config_form` → `/admin/config/services/crowdriff` (`_permission: 'administer crowdriff'`, restrict access).
- **Service:** `crowdriff_api.crowdriff_service` (`CrowdriffService`) — Bearer auth via `key.repository`, base default `https://api.crowdriff.com/v2`.
- **Cache:** dedicated `crowdriff` cache bin, TTL from settings, stale-cache fallback on error.
- **Hook:** `hook_crowdriff_api_alter_assets`.

**Security:** single admin config route gated by `administer crowdriff` (restrict access); no anonymous or mutating endpoints. API token stored as a Key entity (not plaintext config) and read at request time; outbound calls use Guzzle's default TLS verification with 15s timeouts. Clean posture.

See [api/service.md](api/service.md).
