<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Url Restriction by Role — agent index

Restricts specific URLs (path/alias, with `*` wildcards) to chosen roles via a kernel REQUEST event
subscriber; unauthorised users get a 403 or a custom message. One admin form, one permission, no
dependencies beyond core, no config schema, no Drush.

- **Define restricted URLs: the form, config structure, matching & error-message behaviour** →
  [configure/settings.md](configure/settings.md)
- **The single admin permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config route `url_restriction_by_role.config.form` → `/admin/config/search/path/url-restriction-by-role`
  (permission `admin url restriction by role settings`, `restrict access: true`).
- Config object `url_restriction_by_role.settings`: `urls` (map keyed by URL → `{enabled, role[]}`),
  `error_message` (string), `use_custom_error_message` (bool).
- Subscriber `src/EventSubscriber/UrlRestrictionByRole.php` on `KernelEvents::REQUEST` (default
  priority); matches `current_path` and its alias with `path.matcher` (`matchPath`, supports `*`).
- Deny rule (multi-value roles): user with **none** of the allowed roles → 403.
- **Allow-list model**: unlisted paths are unrestricted (no default-deny).
- Operational limits (including the anonymous Internal Page Cache interaction) are summarised in the
  configure doc.
