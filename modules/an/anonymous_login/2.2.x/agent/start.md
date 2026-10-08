<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Anonymous Login — agent index

Forces anonymous visitors to log in on configured page paths, then redirects them back
(`?destination=`). One config object, one event subscriber, one permission. No plugins,
no Drush.

- **Configure which paths force login (include/exclude, wildcards), the login path, the
  message — UI + config keys + scriptable** → [configure/paths.md](configure/paths.md)
- **How the redirect works (event subscriber, matching, always-excluded paths) and the
  alter hook** → [api/redirect.md](api/redirect.md)

Key facts:
- Config: `anonymous_login.settings` → `paths` (sequence; plain = include, `~`-prefixed =
  exclude, `*` wildcards), `login_path` (default `/user/login`), `message` (optional).
- Configure route `anonymous_login.settings` at
  `/admin/config/user-interface/anonymous-login`; permission `administer anonymous login settings`.
- Redirect done by service `anonymous_login.redirect` (EventSubscriber on
  `KernelEvents::REQUEST`, priority 100). Always excludes `user/reset/*`, `cron/*`,
  `sites/default/files/*`. Alter hook: `hook_anonymous_login_paths_alter(&$paths)`
  (`$paths['include']` / `$paths['exclude']`).
