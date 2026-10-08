<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Control Admin Access is an HTTP middleware and config form that blocks configured URL patterns with a 401 unless the client IP is in an allowlist.

---

Control Admin Access adds a **defense-in-depth IP gate in front of chosen URL patterns** (typically `/admin`). It registers one HTTP kernel middleware (`CaaMiddleware`, priority 250, ahead of page caching) that, on every request, matches the request URI against a configured list of blocked URL glob patterns; when a request matches a blocked pattern and an IP allowlist has been configured, any client whose IP is not in the allowlist gets a bare **HTTP 401** and the request never reaches routing. Configuration is a single admin form at `/admin/config/system/control-admin-access` (permission **`administration access vpn`**) with two textareas — the IP/CIDR whitelist and the blocked URL patterns — stored in the config object `control_admin_access.adminsettings`. It requires no modules outside Drupal core.

Treat it as an **additive hardening layer, not a replacement for authentication or Drupal's permission system**: the middleware only *adds* a 401 in front of matching paths; it never grants access. Two operational cautions matter. (1) The gate keys on Symfony's `Request::getClientIp()`, which returns the real connecting IP by default and only honors `X-Forwarded-For` when trusted reverse proxies are configured — so behind a proxy/CDN you must configure Drupal's trusted-proxy / reverse-proxy settings for the allowlist to see the true client IP. (2) A misconfigured allowlist can **lock you and all admins out** of the blocked paths (recover via `drush cset`/`drush cdel` on `control_admin_access.adminsettings`, or by editing config in the DB); test the rules before relying on them and keep a recovery path.

---

- Restrict `/admin` and other admin paths to a known office/VPN IP allowlist.
- Add an IP-based defense-in-depth gate in front of Drupal's own access control.
- Return a hard 401 to non-allowlisted clients before pages are cached or routed.
- Allow a set of trusted IPs full access while blocking everyone else from listed URLs.
- Lock down a staging or pre-launch site's admin area to internal IPs.
- Whitelist single IPs (`192.168.1.10`) and CIDR ranges (`10.0.0.0/24`), one per line.
- Block URL glob patterns such as `/admin`, `/admin/*`, `/*/admin`, `/user/1/edit`.
- Gate sensitive non-admin paths (e.g. a specific edit URL) by IP.
- Layer IP restriction on top of, not instead of, login/2FA.
- Keep the block ahead of the page cache so cached pages are not served to blocked clients.
- Configure the allowlist and blocked-URL list from one admin form, no code.
- Enforce access from a corporate VPN egress IP range only.
- Provide a lightweight alternative to editing `.htaccess`/nginx allow/deny rules.
- Reduce the attack surface of the admin login form by hiding it from the public.
- Combine with trusted-proxy settings so the gate sees real client IPs behind a CDN.
- Test rules on a throwaway path before applying them to `/admin` to avoid lockout.
- Recover from a bad allowlist by deleting `control_admin_access.adminsettings` via drush.
- Grant the `administration access vpn` permission only to trusted admins.
- Document the intended allowlist so a changed office IP does not silently lock admins out.
- Use it as one control in a broader hardening checklist, not as a standalone security boundary.
