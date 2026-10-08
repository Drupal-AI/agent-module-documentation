<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Loki (loki) — agent index

**Development chaos module: randomly returns configurable 5xx errors to selected roles to test CDN/proxy stale-if-error handling. NOT the Grafana Loki log shipper.**

- **Version:** 2.0.x
- **Core:** ^10 || ^11
- **Config route:** `loki.settings` → `/admin/config/development/loki`, permission **`administer loki`** (`restrict access: true`).
- **Service:** `loki.response_subscriber` → `LokiSubscriber` (subscribes `KernelEvents::RESPONSE`).
- **Settings:** `enable` (default false), `randomness` %, `time_min`/`time_max`, `roles` (default anonymous), `responses` (500/502/503/504).
- **Security:** all configuration is admin-gated behind a `restrict access` permission; chaos is off by default and the settings route is always exempt from failures. No TLS/log-shipping config and no secrets exist in this module (the task's "Grafana Loki logging" premise does not apply). `mt_rand` is used only for the chaos-probability roll, not for any security token.