<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Microwave (microwave) — agent index

**Warms page caches after a deploy by queueing node / term / custom / commerce-product URLs and GET-ing each.**

- **Version:** 1.0.x
- **Core:** ^10.3 || ^11 (PHP ^8.0)
- **Config route:** `microwave.settings` → `/admin/config/system/microwave` (perm `configure microwave`, restricted)
- **Drush:** `mpcu` (custom), `mpnu` (nodes), `mptu` (terms), `mpcpu` (commerce, submodule)
- **Queue workers:** `microwave_custom_cron`, `microwave_node_cron`, `microwave_term_cron`, `microwave_commerce_product_cron`
- **Services:** `microwave.warmer_requests` (GET warmer), `microwave.batch_service`
- **Submodule:** `microwave_commerce`

**Security:** single admin config route, permission-gated (restricted). No anonymous or mutating web endpoints. `WarmerRequests::warmUrlByGet()` validates each URL — scheme must be http/https and host must equal the current site host, else it is refused and logged — which prevents SSRF to arbitrary hosts. Queue clears use fixed literal `DELETE FROM queue WHERE name='…'` (no injection). No security findings.

See [drush/commands.md](drush/commands.md)
