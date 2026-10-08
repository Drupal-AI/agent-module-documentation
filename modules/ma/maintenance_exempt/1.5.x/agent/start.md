<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Maintenance Exempt — agent index

Whitelist visitors from Drupal maintenance mode by **IP / CIDR**, **URL path**, or a **secret
query-string key**, on top of core's `access site in maintenance mode` permission. Works by
overriding the core `maintenance_mode` service. No permissions, no Drush, no plugins.

- **Config keys, the maintenance-form fieldsets, and the `exempt()` bypass logic** →
  [configure/exemptions.md](configure/exemptions.md)

Key facts:
- Service `maintenance_mode` is replaced by `Drupal\maintenance_exempt\MaintenanceModeExempt`
  (`extends MaintenanceMode`) — see `maintenance_exempt.services.yml`.
- `exempt()` returns TRUE if: has `access site in maintenance mode`; OR client IP in `exempt_ips`;
  OR client IP in a CIDR from `exempt_ips`; OR path matches `exempt_urls`; OR `$_GET[query_key]` set
  (also stored in `$_SESSION['maintenance_exempt']`).
- Config object `maintenance_exempt.settings`: `exempt_ips`, `exempt_urls`, `query_key` (newline-separated strings).
- Edited via `hook_form_system_site_maintenance_mode_alter` on `admin/config/development/maintenance` (`configure`).
- **All exemptions are off by default** (empty config = identical to core); the query key is a
  shared secret in the URL — anyone who knows it bypasses maintenance unauthenticated (by design).
