<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, permissions & the control-route access check

Install/enable: `drush en opcachectl`. No config to import (no `config/install`, no schema). The PHP
**Zend OPcache** extension must be loaded for any of this to do anything; `hook_requirements`
reports its state on the status report.

## Permissions (`opcachectl.permissions.yml`)

- `access opcache statistics` — view the two report pages.
- `reset opcache` — use the admin reset confirm form.

Neither is marked `restrict access: true` in the module. The JSON control route does **not** use
either permission — it uses the custom `_opcachectl_access` check (below).

## Routes (`opcachectl.routing.yml`)

| Route | Path | Method | Gate | Controller/form |
|---|---|---|---|---|
| `opcachectl.report.stats` | `/admin/reports/opcache` | GET | `_permission: access opcache statistics` | `OpcacheReportController::viewStatistics` |
| `opcachectl.report.config` | `/admin/reports/opcache/config` | GET | `_permission: access opcache statistics` | `OpcacheReportController::viewConfig` |
| `opcachectl.reset.form` | `/admin/config/system/opcache/reset` | GET/POST | `_permission: reset opcache` | `ConfirmResetOpcacheForm` |
| `opcachectl.control.get` | `/system/opcachectl` | GET | `_opcachectl_access` | `OpcacheCtlController::controlGet` |
| `opcachectl.control.purge` | `/system/opcachectl` | PURGE | `_opcachectl_access` | `OpcacheCtlController::controlPurge` |
| `opcachectl.control.post` | `/system/opcachectl/reset` | POST | `_opcachectl_access` | `OpcacheCtlController::controlPurge` |

All routes set `no_cache: 'TRUE'`; the JSON control routes require `_format: json`. The reset form
redirects to `opcachectl.report.stats` after submit. Menu/local-task/action links live in
`opcachectl.links.menu.yml` (note: its `opcachectl.settings` parent route does not exist),
`opcachectl.links.task.yml` (Statistics / Configuration tabs), and `opcachectl.links.action.yml`
(the "Reset PHP OPcache" action on the stats page).

## The control-route access check (`src/Access/OpcacheCtlAccess.php`)

Registered as service `opcachectl.access_check` with tag
`{ name: access_check, applies_to: _opcachectl_access }`. The constructor reads two
`settings.php` values:

- `$settings['opcachectl_reset_token']` → `$requestToken` (trimmed).
- `$settings['opcachectl_reset_remote_addresses']` → `$authorizedAddresses` (array or scalar).

`access(Request $request)` returns `AccessResult::allowed()` when any of these hold, else
`AccessResult::forbidden()`:

1. **Same machine** — the client IP equals `$_SERVER['SERVER_ADDR']`, or the IP is `127.0.0.1` /
   `::1`, or `$_SERVER['HTTP_HOST']` is `localhost`.
2. **IP allowlist** — the client IP is in `$authorizedAddresses`.
3. **Token** — `$requestToken` is non-empty and the request query `?token=` equals it (compared
   with `==`).

Client IP comes from `$request->getClientIp()` (honors reverse-proxy trusted-proxy settings only if
you configure Drupal's `reverse_proxy`/`reverse_proxy_addresses` in `settings.php`). Out of the box
both settings are unset, so remote reset is effectively "same machine only".

### Configure remote reset (`settings.php`)

```php
// Allow named deploy hosts to reset without a token:
$settings['opcachectl_reset_remote_addresses'] = ['10.0.0.5', '10.0.0.6'];

// Or a shared token usable from any address (generate a long random value):
$settings['opcachectl_reset_token'] = 'a-long-random-32+char-value';
```

Best practice for exposing this route at all: keep the site's `trusted_host_patterns` configured,
lock the path down at the web-server/edge to your deploy network, and treat the token as a secret.

### Operate from CI/CD

```bash
# Status (JSON):
curl -s https://example.com/system/opcachectl?token=$TOKEN

# Reset via POST:
curl -s -X POST https://example.com/system/opcachectl/reset?token=$TOKEN

# Reset via PURGE (same handler as POST):
curl -s -X PURGE "https://example.com/system/opcachectl?token=$TOKEN"
```

`controlPurge()` logs a `debug` line (method + path + hostname) to the `opcachectl` channel and
returns the post-reset `opcache_get_status(FALSE)` as JSON, or HTTP 500 with `{"error": ...}` if
OPcache is unavailable or `opcache_reset()` fails. Reset from a browser session instead uses the
admin confirm form at `/admin/config/system/opcache/reset` (permission `reset opcache`, standard
form CSRF token).
