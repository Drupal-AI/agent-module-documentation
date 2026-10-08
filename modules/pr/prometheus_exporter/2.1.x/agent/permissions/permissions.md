<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

From `prometheus_exporter.permissions.yml`:

| Permission | Gates | Notes |
|---|---|---|
| `access prometheus metrics` | GET `/metrics` (the scrape endpoint) | Not `restrict access: true`; **granted to no role by default**, so the endpoint is closed until you grant it. Grant it to the role your scraper authenticates as (basic_auth/oauth2/cookie). |
| `administer prometheus exporter settings` | `/admin/config/system/prometheus_exporter` settings form | Enables/orders collectors and edits their settings. Treat as trusted admin. |

Notes:
- Granting `access prometheus metrics` to the **anonymous** role publishes metrics to the public
  internet — do this only behind a firewall/WAF. Metrics can leak module versions, user/session/queue
  counts and PHP info.
- The `prometheus_exporter_token_access` submodule adds an alternative: a static token grants the same
  access without the permission (see that submodule's docs and its security note).
- `drush prometheus:export` ignores both permissions (CLI access only).
