<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Site Settings Type Permissions — agent index

Submodule of **site_settings**. Adds eight permissions **per settings type** and enforces them
with entity access hooks. No routes, no config, no services, no plugins, no Drush,
`configure: null`.

- **The generated permission names, the access logic, grants and gotchas** →
  [permissions/per-type.md](permissions/per-type.md)

Key facts:
- Permissions come from `permission_callbacks` →
  `\Drupal\site_settings_type_permissions\SiteSettingTypePermissions::siteSettingTypePermissionsList`.
- Per type `<id>`: `view published <id> site setting entities`,
  `view unpublished <id> site setting entities`, `create <id> site setting`,
  `edit <id> site setting`, `delete <id> site setting`,
  `view <id> site setting entity revisions`, `revert <id> site setting entity revision`,
  `delete <id> site setting entity revision`.
- Access = **global permission OR type permission**; otherwise **forbidden** (not neutral).
- `hook_views_pre_render()` drops inaccessible rows from the `site_settings` View.
- Parent module docs: `../../../../2.0.x/agent/start.md`
