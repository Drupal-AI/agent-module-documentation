<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Features Permissions (features_permissions) — agent index

Mirrors each role permission into its own **exportable config entity** so the **Features** module can
package permissions without exporting whole roles, then re-applies those grants to roles on config
import/revert. Requires `features` (which brings in `config_update`). Package `Development`.
Version **1.2.0**, core `^10.0 || ^11.0`. No UI, no routes, no settings.

## What it actually does
- Defines a config entity type **`user_permission`**, stored as `features_permissions.permission.<machine_name>`
  (one entity per permission). Fields: `id` (sanitized machine name), `label` (the real permission key,
  e.g. `access checkout`, used as Drupal's permission key), and `roles` (array of role IDs holding it).
- **Role → entities** (`PermissionManager::syncRoleToPermissions`, driven by `hook_entity_insert/update/delete`
  on roles in `features_permissions.module`): on insert every permission is treated as added; on update it
  diffs `$role->original` vs current and adds/prunes; on delete it strips the role from all its entities.
  An entity is **deleted once no role references it**.
- **Entities → roles** (`PermissionManager::syncPermissionToRoles`, driven by
  `EventSubscriber/ConfigEventsSubscriber` on `config_update` **IMPORT** and **REVERT** events): when a
  `user_permission` config arrives, it reads the entity's `roles` list and **grants the permission to every
  listed role, revokes it from every role not listed**.
- `hook_install` seeds entities from existing roles.
- `hook_requirements` hard-**errors** on the status report unless every Features bundle enables the
  **"Strip out user permissions"** alter assignment setting (route `features.assignment_alter`) — otherwise
  roles and permission entities would double-manage the same grants.

## Operator notes (read before deploying)
- **Config deletion does nothing.** The subscriber ignores config *delete*: removing a permission entity from
  a Feature stops managing that permission — it does **not** revoke it from roles. To revoke, edit the
  entity's `roles` list (or the role) so the change syncs, don't just drop the file.
- **Import is a privilege change disguised as a deployment.** An imported/reverted `user_permission` entity
  that lists a role **will grant that permission to the role**, and config import does not prompt. Review
  these diffs with the attention a role change gets, and control who may commit them.
- **Enable order.** Enable `features` (and `features_ui`) first; enabling `features_permissions` against a
  bare `features` fails with *Route "features.assignment_alter" does not exist*.

## Solution docs
- [api/sync-model.md](api/sync-model.md) — the `user_permission` config entity, `PermissionManager`
  (`syncRoleToPermissions` / `syncPermissionToRoles` and the key↔machine-name helpers), the
  `ConfigEventsSubscriber` import/revert flow, and how the pieces fit Features export.

## Files
- `data.json` — metadata. `usage.md` — 3-block overview + use cases.
