<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CiviMember Roles Sync (civicrm_member_roles) — agent index

Grants/revokes Drupal user roles from a contact's CiviCRM membership state. You define
**Association Rules** (config entities) that map a CiviCRM *membership type* + a set of *statuses*
to a *Drupal role*; the module then adds the role when a matching membership is in an "add" status
and removes it when in a "removal" status (or when the membership is gone). Sync runs on user
login/logout, on cron, on CiviCRM membership update, from a manual-sync form, and from Drush.

- Requires the **`civicrm`** module. No PHP libraries. Single top-level module (no submodules).
- Configure UI: `configure` in info.yml points at **`entity.civicrm_member_role_rule.collection`**
  (`/admin/config/civicrm/civicrm-member-roles`). Rule add/edit/delete + a settings form + a
  manual-sync form all live under that path.
- Defines **1 permission**, **config schema**, a **legacy `.drush.inc` command**, and a
  **config entity type** (`civicrm_member_role_rule`). No plugin types.

Solution docs:
- **Choose when/how sync happens (login/cron/update, cron batch size)** → [configure/settings.md](configure/settings.md)
- **Create/edit the membership→role mapping rules** → [configure/rules.md](configure/rules.md)
- **Who may administer rules and run syncs** → [permissions/permissions.md](permissions/permissions.md)
- **Sync from the CLI / after a bulk import** → [drush/commands.md](drush/commands.md)
- **Call the sync service or reuse it in code** → [api/services.md](api/services.md)
- **Which hooks trigger a sync** → [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Settings config: **`civicrm_member_roles.settings`** — keys `sync_method` (sequence of
  `login` / `cron` / `update`) and `cron_limit` (int, default `150`). Install default:
  `sync_method: [login]`.
- Rule config entities: **`civicrm_member_roles.civicrm_member_role_rule.<id>`** — keys
  `id`, `label`, `role`, `type` (membership type id), `current` (add-status ids),
  `expired` (removal-status ids).
- Services: **`civicrm_member_roles`** (`CivicrmMemberRoles`, deps `@civicrm @config.factory
  @entity_type.manager @database`) and **`civicrm_member_roles.batch.sync`** (`Batch\Sync`).
- Permission: **`access civicrm member role setting`** (also the entity `admin_permission`).
- Drush: **`civicrm-member-role-sync`** (alias `cmrs`), options `--uid`, `--contact_id`.
- Routes: `entity.civicrm_member_role_rule.collection` / `.add_form` / `.edit_form` /
  `.delete_form` / `.canonical`; plus
  `civicrm_member_roles.admin_config_civicrm.civicrm_member_roles_configure` and
  `...civicrm_member_roles_manual_sync`.

Operational notes:
- The sync is **authoritative** for rule-managed roles: a role granted by a rule is also revoked
  when the membership no longer matches (or is absent). Do not hand-assign a role a rule manages.
- After creating a rule while `sync_method` is `login` only, run a **Manual Synchronize** once so
  existing users/contacts get the rule applied (login only touches the user logging in/out).
- CiviCRM must be bootstrappable from Drupal; all membership/status lookups go through
  `civicrm_api3` / Api4 in-process (no external HTTP).
