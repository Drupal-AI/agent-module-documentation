# Disable Login Page — agent index

Blocks anonymous access to `/user/login` unless the request carries a secret
`?<querystring>=<secret>`. Implemented as a route access check on `user.login` /
`user.login.http` (a `RouteSubscriber` + tagged `access_check` service). Driven by config
object **`disable_login.settings`** (keys `disable_login`, `querystring`, `secret`). Config UI:
route `disable_login.settings_form` → `/admin/config/security/disable-login`
(permission: core *administer site configuration*). **No default config ships**, so protection
is OFF until saved. No own permissions, no Drush, no plugins.

- **Enable protection, the three config keys, the access URL, the lockout escape hatch** →
  [configure/settings.md](configure/settings.md)
- **Rotate/override the secret programmatically** → [hooks/key-alter.md](hooks/key-alter.md)

Key fact: with `querystring=key` and `secret=abc`, `/user/login` → Access Denied,
`/user/login?key=abc` → the login form. The checker only forbids when
`disable_login.settings:disable_login` is truthy.
