<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Maintenance Mode Redirect redirects site visitors to another (configured) URL when maintenance mode is active, with allowed-path exceptions.

---

Maintenance Mode Redirect redirects visitors to a configured URL while the site is in maintenance mode —
instead of showing Drupal's default maintenance page, visitors are sent to a chosen destination (a status
page, a holding page on another host). It supports allowed paths (and path-prefix exceptions) that are not
redirected. It uses a request subscriber with `TrustedRedirectResponse`, and the redirect target and
allowed paths come from configuration (`system.site_maintenance_mode`).

Use it to point visitors elsewhere during maintenance. It is an administration/maintenance feature; the
redirect destination is **admin-configured** (not user-supplied), so it is not an open-redirect vector —
the URL is set by an administrator via config. Configure the redirect URL and any allowed paths (keep
admin/login paths allowed so you can still access the site to disable maintenance).

---

- Redirect visitors during maintenance.
- Send users to a configured URL.
- Replace the default maintenance page.
- Allow exceptions for certain paths.
- Use TrustedRedirectResponse.
- Set the redirect target in config.
- Not be an open redirect (admin-set URL).
- Keep admin/login paths allowed.
- Configure allowed path prefixes.
- Point to a status/holding page.
- Redirect on maintenance mode.
- Enforce via a request subscriber.
- Configure the redirect URL.
- Except admin routes.
- Handle maintenance redirects.
- Send to another host.
- Avoid the default page.
- Configure exceptions.
- Redirect during downtime.
- Manage maintenance UX.
