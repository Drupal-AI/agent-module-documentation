<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Login Path Helper provides a single block ("Login Path Helper") that renders a login link whose target
includes the current page's path as a destination parameter. The intent is to send a visitor back to the
page they were on after they authenticate — handy for SSO/SAML setups where the login happens on an
external endpoint and you want a `destination=` appended so the IdP round-trip returns the user to the
right page.

---

The block plugin (`LoginPathHelper`, `src/Plugin/Block/LoginPathHelper.php`) builds an anchor from two
config values — `login_path_helper_linkname` (link text, default "Site Login") and
`login_path_helper_urlprefix` (default `user/login?destination=`; for SAML SSO the README suggests
`saml_login?destination=`) — concatenated with the current host (`\Drupal::request()->getHost()`) and the
current request URI (`\Drupal::request()->getRequestUri()`). The block sets `getCacheMaxAge()` to 0 so
the link is rebuilt per request. Configuration is at `/admin/config/login_path_helper`
(`LoginPathHelperSettingsForm`, permission `administer site configuration`). The module has no
dependencies and defines no permissions of its own.

---

- Add a "Site Login" link block that returns users to their current page after login.
- Append `?destination=<current path>` to a normal `user/login` link.
- Point the login link at a SAML SSO endpoint (`saml_login?destination=`) for IdP redirection.
- Preserve the originating page across an external authentication round-trip.
- Place a context-aware login link in a header, sidebar, or footer region.
- Customise the visible link text per site via the settings form.
- Change the URL prefix to match a custom login route.
- Help decoupled/SSO flows land the user back where they started.
- Provide a lightweight alternative to hand-coding destination links in templates.
- Show the login link only in regions/pages where the block is placed.
- Rebuild the destination on every request (cache max-age 0) so it always reflects the current page.
- Use with an external IdP that honours a `destination` query parameter.
- Give anonymous visitors a one-click "log in and come back here" affordance.
- Swap the prefix to route through a reverse-proxy login path.
- Support multi-site setups where the host is derived from the current request.
- Drop into any theme region via the Block layout UI.
