<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# maintenance_ip_whitelist — agent start

Lets listed IPs (incl. anonymous) browse a site in **maintenance mode**. Configured on the core
maintenance form at `/admin/config/development/maintenance` (a textarea injected via `hook_form_alter` →
`FormOperations`, saved to `state('maintenance_ip_whitelist')`).

Mechanism: decorates core `maintenance_mode` service (priority 1) with `MaintenanceModeDecorator`; its
`exempt()` returns TRUE when the visitor IP is in the whitelist, else delegates to core. No own routes or
permissions (inherits `administer site configuration` from the maintenance form).

## Security — reviewed, sound (no header-spoof bypass)
The client IP is read from **`$_SERVER['REMOTE_ADDR']`** (the TCP peer) — **not** from
`X-Forwarded-For`/client headers — so the allowlist is **not spoofable** via request headers. This is the
safe implementation. Operator caveat (not a vuln): behind a reverse proxy, `REMOTE_ADDR` is the proxy IP,
so admins must whitelist the IP the app actually sees.
