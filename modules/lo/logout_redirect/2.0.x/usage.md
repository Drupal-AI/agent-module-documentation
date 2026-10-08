<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Logout Redirect addresses the common concern that after logging out of a Drupal site, pressing the browser
Back button can display cached pages from the previous authenticated session. The module attaches a small
JavaScript that, on a `popstate` (Back) event fired after logout, redirects the visitor to the Drupal
login page or an administrator-configured path.

---

Implementation is entirely client-side. `hook_page_attachments()` attaches the `logout_redirect/logout_redirect`
library on every page and, if a redirect path is configured, passes it to `drupalSettings.logout_redirect_url`.
The JS (`js/logout_redirect.js`) records login state in `localStorage` (`logout_userStatus`) based on the
`user-logged-in` body class; when a Back navigation is detected and the user is no longer logged in, it
sets `window.location.href` to the configured URL (defaulting to `/user/login`). The admin form
(`LogoutBackConfigForm`, route `/admin/config/logout/redirect/settings`, permission
`access administration pages`) stores a single value `logout_redirect` in config
(note: the config object name is the misspelled `logut_redirect_config.settings`, used consistently for
read and write). The submit handler trims the value and truncates it at the first comma. There are no
dependencies and no permissions defined by the module.

**Security note (verified):** the redirect target is **administrator-configured**, not taken from a
request parameter, so this is not a classic open redirect; the redirect is also purely client-side. The
config route is gated by `access administration pages`.

---

- Send logged-out users to the login page if they hit Back into a cached authenticated page.
- Reduce exposure of stale authenticated content on shared/public computers.
- Redirect Back-button navigation to a custom login path (e.g. `/login` for SSO).
- Default to `/user/login` when no custom path is configured.
- Configure the target once via the admin settings form.
- Improve perceived logout security on kiosk or library terminals.
- Pair with proper cache-control headers as a defence-in-depth measure.
- Avoid showing a previous user's dashboard after a shared-device logout.
- Provide a lightweight, dependency-free UX safeguard.
- Route Back navigation to a branded login page.
- Keep the redirect behaviour scoped to post-logout Back events only.
- Use `localStorage` to distinguish logged-in vs logged-out navigation state.
- Deploy site-wide via a single attached library.
- Set the path per environment (staging vs production login URLs).
- Truncate accidental comma-separated input to a single path on save.
- Complement session-invalidation with a client-side Back-button guard.
