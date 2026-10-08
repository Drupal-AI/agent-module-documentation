<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin Login Path (admin_login_path) — agent index

Zero-config theming helper. Flags core account routes as admin routes so login/register/
password/cancel pages render with the **administration theme**. No settings, no permissions
of its own, no Drush, no config schema, no plugins. Enable and it works; there is nothing to
call or configure.

Key facts (whole module is ~4 tiny files — this index replaces reading them):
- **Does NOT relocate/hide `/user/login`.** The name is misleading: it only changes the
  *theme* of the account pages. It is not a login-path obscuring or protection module and adds
  no access restriction.
- Mechanism: `src/Routing/RouteSubscriber.php` (service `admin_login_path.route_subscriber`,
  tagged `event_subscriber`) iterates routes in `alterRoutes()` and calls
  `$route->setOption('_admin_route', TRUE)` on: `user.login`, `user.register`, `user.pass`,
  `user.cancel_confirm`, `user.reset.login`, `user.reset`, `user.reset.form`. Core's theme
  negotiator then serves those routes with the admin theme.
- `admin_login_path_install()` grants the core permission `view the administration theme` to
  BOTH the anonymous and authenticated roles (needed so anon can see the admin theme on
  login). This permission only controls theme visibility — it does not expose admin routes or
  data. It is NOT revoked automatically on uninstall.
- `core_version_requirement: ^8.9 || ^9 || ^10 || ^11`; no module dependencies; `configure` is
  null. To change *which* routes are admin-themed you must decorate/replace the route
  subscriber — the list is hardcoded.

No solution docs: there is no API, config, plugin, or command surface to document.
