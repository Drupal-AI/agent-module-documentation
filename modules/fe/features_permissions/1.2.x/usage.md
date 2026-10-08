<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Features Permissions mirrors each role permission into its own exportable `user_permission` config entity, so a Feature can package the permissions it needs without exporting whole roles — and re-applies those grants to roles when the config is imported or reverted.

---

Drupal stores permissions **on the role**, so packaging permissions with the Features module means exporting the **entire role**, which on import overwrites every other permission that role holds — Features therefore strips permissions out of exported roles by default, and there is no built-in way to carry a subset back. This module closes that gap by defining a config entity type `user_permission` (stored as `features_permissions.permission.<machine_name>`, one entity per permission), where each entity records the permission key and the **list of roles that hold it**. Role changes drive the entities: `hook_entity_insert/update/delete` on a role call `PermissionManager::syncRoleToPermissions()`, which diffs the role's old and new permission sets and creates, appends-to, prunes, or deletes the matching permission entities (an entity is deleted once no role references it). The reverse flow runs on deployment: an `EventSubscriber` listens for the `config_update` module's **import** and **revert** events, and when a `user_permission` entity arrives it calls `syncPermissionToRoles()`, which reads that entity's `roles` list and **grants the permission to every listed role and revokes it from every role not listed**. Two behaviours matter for operators. First, `hook_requirements` hard-errors unless every Features bundle has the **"Strip out user permissions"** alter setting enabled — otherwise roles and permission entities would double-manage the same grants. Second, the subscriber deliberately takes **no action on config deletion**: removing a permission entity from a Feature stops managing that permission, it does not revoke it from roles. Version **1.2.0**, core `^10.0 || ^11.0`, requires `features` (which supplies `config_update`); Development package, no UI and no settings.

---

- Package permissions with a Feature instead of exporting whole roles.
- Avoid overwriting a role's other permissions on import.
- Bundle a content type together with the permissions that make it usable.
- Let two Features that both touch the editor role coexist.
- Deploy an individual permission grant independently of the role.
- Compose the permission set of one role from several Features.
- Move a specific permission change between environments.
- Re-apply role grants automatically when a Feature is reverted.
- Keep permission changes visible as reviewable config diffs.
- Export a distribution's required permissions as portable config.
- Seed permission entities from existing roles at install time.
- Grant a permission to multiple roles from one exported entity.
- Revoke a permission from roles by removing them from the entity's list.
- Track, per permission, exactly which roles hold it.
- Audit permission-to-role assignments in version control.
- Support an incremental, Features-based deployment workflow.
- Carry a role's access rules alongside its functional config.
- Sync permission config back to live roles on `drush config:import`.
- Detect misconfigured Features bundles via the status report requirement.
- Stop managing a permission by dropping its entity from the Feature.
