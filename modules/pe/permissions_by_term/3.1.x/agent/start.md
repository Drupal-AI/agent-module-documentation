<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions by Term — agent index

Access control driven by **taxonomy terms**: grants are user→term and role→term rows in two
custom tables, enforced through core **node access records**, `hook_node_access()` and
term-widget filtering.

- **Settings keys, the term/user forms, and where grants are stored** →
  [configure/settings-and-grants.md](configure/settings-and-grants.md)
- **Services to call (`AccessStorage`, `AccessCheck`, `NodeAccess`, `TermHandler`) and the
  enforcement path** → [api/services.md](api/services.md)
- **Drush commands** → [drush/commands.md](drush/commands.md)
- **The four permissions** → [permissions/permissions.md](permissions/permissions.md)
- **The access-denied event and the hooks it implements** → [hooks/events.md](hooks/events.md)

Key facts:

- Tables: `permissions_by_term_user` (`tid`, `uid`, `langcode`) and `permissions_by_term_role`
  (`tid`, `rid`, `langcode`) — composite primary keys, created by `hook_schema()`.
- Config: `permissions_by_term.settings` → `permission_mode`, `require_all_terms_granted`,
  `disable_node_access_records`, `only_parents`, `target_bundles`, `show_terms_in_user_form`,
  `hide_terms_permissions_info_in_node_form`.
- `configure` route = `permissions_by_term.settings` → `/admin/permissions-by-term/settings`
  (permission `access pbt settings`).
- Node access realm constant: `AccessStorage::NODE_ACCESS_REALM = 'permissions_by_term'`.
- Drush: `permissions-by-term:rebuild` (`pbtr`), `permissions-by-term:create-nodes-with-permissions` (`pbtcnwp`).
- **No plugin types of its own** (it ships one migrate destination plugin,
  `permissions_by_term_user`).
- Submodule: [`permissions_by_entity`](../../modules/permissions_by_entity/3.1.x/agent/start.md)
  applies the same term grants to non-node fieldable entities.
