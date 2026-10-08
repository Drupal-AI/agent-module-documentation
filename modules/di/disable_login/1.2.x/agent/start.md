<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Disable Login Page (disable_login) — agent index

Blocks anonymous access to `/user/login` **and** the `user.login.http` REST route unless the
request carries a secret `?<querystring>=<secret>`. Implemented as a route access check attached
to both routes by `DisableLoginRouteSubscriber` (sets the `disable_login_access_check`
requirement) plus the tagged `access_check` service `DisableLoginAccessCheck`. Driven by config
object **`disable_login.settings`** (keys `disable_login`, `allow_secret`, `querystring`,
`secret`). Config UI: route `disable_login.settings_form` → `/admin/config/security/disable-login`
(permission: core *administer site configuration*). **No default config ships**, so protection is
OFF until saved. No own permissions, no Drush, no plugins. Core requirement `^10 || ^11`.

- **Enable protection, the four config keys, `hash_equals` check, IP flood control, escape hatch** →
  [configure/settings.md](configure/settings.md)
- **Rotate/override the secret programmatically** → [hooks/key-alter.md](hooks/key-alter.md)

Key facts:
- With `disable_login=1`, `allow_secret=1`, `querystring=key`, `secret=abc`:
  `/user/login` → Access Denied, `/user/login?key=abc` → the login form.
- With `disable_login=1` and `allow_secret=0`: the login page is forbidden outright (no URL bypass).
- The secret compare is constant-time (`hash_equals`), and failed attempts are rate limited per IP
  via the core flood service (`user.flood` `ip_limit`/`ip_window`, event `disable_login.failed_key_ip`).
