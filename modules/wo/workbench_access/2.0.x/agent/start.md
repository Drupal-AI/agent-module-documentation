<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# workbench_access — agent start

Editorial access control by **section**. A site defines one or more **access schemes**
(the `access_scheme` config entity); each scheme's `scheme` key names an
**AccessControlHierarchy** plugin that turns a hierarchy into sections. Two plugins ship:
`taxonomy` (vocabulary terms) and `menu` (menu tree). Editors are assigned to sections
per-user or per-role and may only edit content filed under a section they belong to (or an
ancestor). Access is additive — it only *denies* untrusted users. Admin UI:
`/admin/config/workflow/workbench_access` (route `workbench_access.admin`); entity admin
permission `administer workbench access`.

- The `access_scheme` config entity: keys, config prefix, how to create/read/delete via drush → [configure/access-scheme.md](configure/access-scheme.md)
- The AccessControlHierarchy plugin type (`taxonomy` / `menu`), and writing your own → [plugins/access-control-hierarchy.md](plugins/access-control-hierarchy.md)
- Services & programmatic API (scheme plugin manager, user/role section storage, section associations) → [api/api.md](api/api.md)
- Permissions the module defines and what each gates → [permissions/permissions.md](permissions/permissions.md)
- Drush: `workbench_access:installTest` (demo taxonomy scheme scaffolding), `workbench_access:flush` (see api doc).
