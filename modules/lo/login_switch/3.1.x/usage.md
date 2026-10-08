<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Login Switch changes the paths of Drupal core's `user.login`, `user.register` and `user.pass` routes — moving each to a custom path or disabling it entirely — and can add a `noindex` header to those pages.

---

Login Switch is a small hardening/obscurity module that alters three core user routes at route-build time. From one settings form (`/admin/config/people/login-switch`) each of the **login**, **register** and **reset-password** routes can be independently: (a) left alone, (b) moved to a new path you type in (e.g. `secret-login`), or (c) fully disabled (access denied) when the "disable" box is ticked but the replacement path is left empty. It works via a `RouteSubscriber` that either calls `setPath()` or sets `_access: 'false'` on each core route. A `ResponseEvent` subscriber adds an `X-Robots-Tag: noindex` header on any of the three pages whose `*_noindex` flag is on, keeping the login/register/reset pages out of search engines. An exception subscriber additionally turns the `user.page` route into a 404 (instead of a redirect to login) when login is disabled and the visitor lacks the `access 403 page` permission. Changing the settings triggers a router rebuild; a cache clear (`drush cr`) may still be needed for the new paths to resolve. The module has no plugins, no Drush commands and defines no permissions of its own (the settings form is gated by core's `administer site configuration`).

---

- Move the login form from `/user/login` to an obscure path like `/secret-login` to cut brute-force noise.
- Relocate `/user/register` to a custom path known only to invited users.
- Move `/user/password` (reset) to a non-obvious path.
- Fully disable the default `/user/login` route so it returns access-denied.
- Disable public self-registration by turning off the `/user/register` route.
- Disable the password-reset route on a site that uses only external/SSO authentication.
- Add `X-Robots-Tag: noindex` to the login page so it never appears in search results.
- Keep the registration page out of search-engine indexes with the register `noindex` flag.
- Keep the password-reset page out of search indexes.
- Return a 404 (not a login redirect) for `/user` to anonymous visitors when login is disabled.
- Harden a public site by hiding the standard authentication endpoints from bots and scanners.
- Deploy the login/register/password paths per-environment via `settings.php` config overrides.
- Standardise a custom login URL across a multisite by exporting `login_switch.settings`.
- Combine a custom login path with a themed login page presented at that path.
- Reduce automated credential-stuffing hits that target the well-known `/user/login` URL.
- Present a branded "request access" URL instead of the generic Drupal registration path.
- Temporarily lock down registration during a launch window by disabling the register route.
- Route password resets through a support workflow by disabling the default reset page.
- Turn login route obscurity on/off per environment (open on dev, hidden on prod) via config override.
- Keep authentication pages unindexed for privacy/compliance without editing robots.txt.
- Avoid writing a custom route subscriber just to rename the login path.
- Signal search engines not to index auth pages while still leaving them reachable by users.
- Apply all three route changes (login, register, password) from a single admin form.
- Quickly revert to Drupal defaults by unticking the "disable" checkboxes and clearing cache.
