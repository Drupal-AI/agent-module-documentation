<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Login Switch — agent index

Alters core's `user.login`, `user.register`, `user.pass` routes: move each to a custom path,
or disable it, and optionally mark the page `noindex`. Single settings form, one config object,
no plugins, no Drush, no own permissions.

- **Change/disable a route, or set noindex — settings keys & config** →
  [configure/settings.md](configure/settings.md)
- **How it works (route subscriber, exception subscriber, noindex header, theme hook)** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- Config object: `login_switch.settings`. Configure route: `login_switch.settings`
  (`/admin/config/people/login-switch`), gated by core `administer site configuration`.
- Per route `<key>` in {`login`, `register`, `password`}: `<key>_disabled` (bool),
  `<key>_route` (new path, no leading slash), `<key>_noindex` (bool).
- `<key>_disabled` + non-empty `<key>_route` → route path is changed; `<key>_disabled` +
  empty `<key>_route` → route becomes `_access: 'false'` (access denied).
- After changing settings, run `drush cr` for new paths to resolve.
