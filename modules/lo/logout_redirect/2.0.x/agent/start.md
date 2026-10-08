<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# logout_redirect — agent start

Client-side guard: after logout, pressing the browser **Back** button redirects the visitor to the login
page (or a configured path) instead of showing a cached authenticated page.

Mechanics:
- `hook_page_attachments()` attaches library `logout_redirect/logout_redirect` on all pages and passes the
  configured path to `drupalSettings.logout_redirect_url`.
- `js/logout_redirect.js` tracks login state in `localStorage` and on `popstate` (Back) after logout sets
  `window.location.href` to the target (default `/user/login`).
- Config: `/admin/config/logout/redirect/settings` (`LogoutBackConfigForm`, perm
  `access administration pages`). Config object name is the misspelled but internally-consistent
  `logut_redirect_config.settings`; stored key `logout_redirect`.

Security: redirect target is **admin-configured**, not request-derived → not an open redirect. Redirect
is client-side only. No dependencies, no own permissions. Note: JS-only; not a substitute for proper
`Cache-Control: no-store` on authenticated responses.
