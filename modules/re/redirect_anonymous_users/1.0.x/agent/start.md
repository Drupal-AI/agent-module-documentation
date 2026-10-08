<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Redirect anonymous users (redirect_anonymous_users) — agent index

**Redirects all anonymous requests to `user.login` except an admin-configured allow-list of route names.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10 || ^11
- **Configure:** `/admin/people/redirect_anonymous_users/settings` (route `redirect_anonymous_users.settings`)
- **Permission:** `administer redirect_anonymous_users configuration` (restrict access: true)
- **Service:** `redirect_anonymous_users.main.event_subscriber` — subscribes to KernelEvents::REQUEST (`checkAuthStatus`).
- **Config:** `redirect_anonymous_users.settings` → `routes_to_exclude` (raw text) + `routes_to_exclude_split` (array of route names). `user.login` is always exempt.

**Security:** Admin-config-gated; the redirect target is hard-coded to the login route (no open-redirect). No mutating or anonymous endpoints. Main operational risk is a too-narrow allow-list blocking security-relevant routes (password reset, registration, API); nothing attacker-controllable.

See [configure/settings.md](configure/settings.md)
