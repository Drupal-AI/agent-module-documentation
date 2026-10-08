<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Require Login — agent index

Forces authentication: anonymous visitors are redirected to the login page. **Default =
require login on every page.** An event subscriber evaluates condition plugins per request
and redirects to `login_path` with a `destination`. No Drush, no plugin types of its own.

- **All config keys, the settings form, narrowing to specific pages, 403/404** →
  [configure/settings.md](configure/settings.md)
- **Override the decision in code (`hook_require_login_evaluation_alter`) + the service/event** →
  [hooks/evaluation.md](hooks/evaluation.md)
- **Permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts: config object `require_login.settings`; settings UI at
`/admin/config/people/login-requirements` (route `require_login.settings`, permission
`administer require login`). Login/register/password-reset and asset routes are always
reachable (`PROTECTED_ROUTES`). Service: `require_login.requirements_manager`.
