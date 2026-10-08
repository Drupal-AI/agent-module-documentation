<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Custom Admin URL confines Drupal's administration surface to a designated back-office host: it adds an access check to every `admin/*` and `user/*` route that returns 403 unless the request host matches a configured back-office URL.

---

The module ships a route subscriber (`RouteSubscriber::alterRoutes`) that walks every route in the collection and, for any route whose **second path segment** is `admin` or `user` (i.e. paths like `/admin/…` and `/user/…`), attaches an extra requirement `_custom_access: '\Drupal\custom_admin_url\Controller\AccessController::access'`. Because Drupal combines access requirements with AND by default, this is an **additional** gate layered on top of each route's existing permission/access checks — it can only restrict, never widen, access. At request time `AccessController::access()` reads the configured back-office host from the config object `custom_admin_url.settings` (`bo_url`) and compares it to `Request::getHost()`. If `bo_url` is set and the current host does not match exactly, the check returns `AccessResult::forbidden()` (a 403). If the host matches (or no `bo_url` is configured yet), the `user.login` route is explicitly allowed and every other matched route additionally requires the core **`access administration pages`** permission. The back-office host is entered on a single settings form (`CustomAdminUrlForm`, route `custom_admin_url.settings`, permission `administer site configuration`) at **`/admin/config/system/custom-admin-url`**; the value is validated as a URL and saved to `custom_admin_url.settings:bo_url`. The module declares no dependencies beyond Drupal core, provides no permissions, no Drush commands, no entities and no plugin types. It is best understood as **security-by-separation / defense-in-depth**: it hardens where admin is reachable from, but does not replace role and permission checks, and its guarantee is only as strong as the site's host resolution, so `trusted_host_patterns` must be configured so the keyed host cannot be spoofed through the `Host` header.

---

- Confine the Drupal administration UI to a dedicated back-office host (e.g. `back.example.com`).
- Return a 403 for `/admin/*` and `/user/*` requests that arrive on the public front-office host.
- Add a second, host-based access layer on top of Drupal's role/permission checks for admin routes.
- Serve the public site and the administration surface on two different hostnames of the same Drupal install.
- Keep the admin login reachable only from the back-office host while the front host serves anonymous content.
- Reduce exposure of the admin and user areas to automated scanners hitting the public hostname.
- Enforce that editors and administrators must use the internal back-office URL to reach management screens.
- Layer host separation behind an existing reverse proxy / CDN split between front and back hosts.
- Set or change the back-office host through a simple settings form without editing code.
- Apply the restriction to all admin routes automatically, without listing individual paths.
- Cover the `user` path space (login, profile, account routes) with the same host gate as `admin`.
- Keep the module inert until a back-office URL is entered, so enabling it does not immediately lock a host out by host mismatch.
- Combine with core `access administration pages` so only privileged accounts pass even on the correct host.
- Use as a lightweight alternative to a full separate admin domain configuration for small sites.
- Document and standardise which hostname staff use for administration.
- Pair with `trusted_host_patterns` so the host the gate keys on cannot be forged via the `Host` header.
- Provide an extra hurdle for credential-stuffing bots that only know the public hostname.
- Segregate administration traffic so it can be firewalled or IP-restricted at the back-office host.
