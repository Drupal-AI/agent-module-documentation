<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Multisite Status Report (multisite_status_report) — agent index
**Exposes site status/update/security data as HMAC-signed JSON endpoints for centralized multisite monitoring.**

- **Version:** 1.0.x  **Core:** ^10.3 || ^11 || ^12  **Depends:** drupal:update
- **Config route:** `multisite_status_report.settings` (`/admin/config/development/multisite-status-report`) — perm `administer multisite status report`.
- **Endpoints (perm `access multisite status report` + `_auth: multisite_status_report_hmac`, `no_cache`):** `/multisite-status-report/status-report`, `/modules-updates`, `/summary`.
- **Services:** `HmacValidator` (sign/verify), `StatusReportService`, `HmacAuthProvider`.
- **Security:** all endpoints are permission-gated AND HMAC-authenticated (SHA256, `hash_equals`, timestamp window, one-time nonce replay store, per-IP flood cap on failures); both permissions are `restrict access: true`. No anonymous or mutating endpoints. Sound.

See [api/endpoints.md](api/endpoints.md)
