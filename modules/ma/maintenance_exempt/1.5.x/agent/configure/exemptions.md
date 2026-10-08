<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure maintenance exemptions

There is **no dedicated settings page**. `configure` points at core's Maintenance-mode form
(`admin/config/development/maintenance`); `hook_form_system_site_maintenance_mode_alter` adds three
fieldsets there, and a submit handler saves them to `maintenance_exempt.settings`.

## Config object `maintenance_exempt.settings`

| Key | Type | Form field | Meaning |
|---|---|---|---|
| `exempt_ips` | string (newline-separated) | "Exempt IPs" | IPs and/or CIDR ranges allowed through maintenance. |
| `exempt_urls` | string (newline-separated) | "Exempt URLs" | Path patterns allowed through (matched with `PathMatcher`). |
| `query_key` | string | "Exempt query string" | A secret token; a request with `?<query_key>` (any value) is exempted. |

Set from Drush / settings.php:

```bash
ddev drush config:set maintenance_exempt.settings query_key launch2026 -y
```
```php
// settings.php — per-environment override
$config['maintenance_exempt.settings']['exempt_ips'] = "203.0.113.5\n198.51.100.0/24";
```

## Bypass logic — `MaintenanceModeExempt::exempt()`

The module replaces the core `maintenance_mode` service (`services.yml`) with
`Drupal\maintenance_exempt\MaintenanceModeExempt extends MaintenanceMode`. Core invokes `exempt()`
on every request during maintenance. It returns **TRUE** (let the request through) on the first match:

1. `$account->hasPermission('access site in maintenance mode')` — core behavior, unchanged.
2. Client IP (`Request::getClientIp()`) is exactly listed in `exempt_ips`.
3. Client IP falls in a CIDR from `exempt_ips` (`maintenance_exempt_by_cidr_notation()` →
   `maintenance_exempt_ip_cidr_check()`, an `ip2long` bitmask compare — IPv4 only).
4. Current request path **or** the system path of an aliased path matches `exempt_urls`
   (`PathMatcher::matchPath`).
5. A prior session exemption is stored: `$_SESSION['maintenance_exempt'] == query_key`.
6. `query_key` is set **and** present in `$_GET` → stores it in `$_SESSION` and returns TRUE.

Helpers in `maintenance_exempt.module`: `maintenance_exempt_get_ips()`,
`maintenance_exempt_get_urls()`, `maintenance_exempt_by_cidr_notation()`,
`maintenance_exempt_ip_cidr_check()`.

## Behavior & caveats

- **Off by default.** With empty config, `exempt()` matches only core's permission — identical to
  stock Drupal. Each mechanism activates only once its config is filled in.
- **Query key = shared secret in the URL.** Any visitor (including anonymous) who knows the key can
  bypass maintenance; the exemption then sticks for the whole session. Treat the key as a password,
  rotate it, and prefer HTTPS so it isn't logged/leaked in referrers. This is the module's intended
  feature, not a defect — but scope it deliberately.
- **CIDR check is IPv4-only** (`ip2long`); IPv6 ranges won't match via CIDR (exact IPv6 strings in
  `exempt_ips` still match the `in_array` check).
- Behind a reverse proxy/CDN, ensure Drupal's trusted-proxy/`reverse_proxy` settings are correct so
  `getClientIp()` returns the real visitor IP before relying on IP exemptions.
