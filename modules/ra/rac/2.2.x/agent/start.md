<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Role Access Control (rac) — agent index

Turns "which roles may act on this entity" into **node/entity access grants** on top of **ADVA**
(Advanced Access). A role entity-reference field (target type `user_role`) on a bundle names the
roles allowed on each entity; RAC maps "the user has one of those roles" to a grant. RAC supplies
only the role→grant mapping (three ADVA `@AccessProvider` plugins) plus the per-role permissions —
the actual query-level enforcement is ADVA's.

Depends on core `user` and `adva:adva`. Core `^9 || ^10 || ^11 || ^12`.
`configure:` = **`adva.settings`** (`/admin/config/people/adva`) — RAC has no settings page of its
own; you enable role access per entity type/field there. Ships submodule **`rac_relations`** (adds
an update-by-related-role model with its own form at `/admin/config/people/rac/relations`).

- **Enable role access on a field/entity type, the `rac.settings` config, `rac_relations` settings** →
  [configure/settings.md](configure/settings.md)
- **The runtime-generated per-role permissions** → [permissions/permissions.md](permissions/permissions.md)
- **The ADVA access-provider plugins it supplies (`rac`, `rac_typed`, `rac_relations`)** →
  [plugins/access-providers.md](plugins/access-providers.md)
- **The form-alter and role-lifecycle hooks it implements** → [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Config object `rac.settings`, single key `update_unpublished` (bool, default `1`). No
  `config/schema` file ships.
- Permissions are generated at runtime by `\Drupal\rac\AccessPermissions::permissions()`
  (`permission_callbacks` in `rac.permissions.yml`): `RAC_view_<role_id>` and `RAC_update_<role_id>`
  per role. The submodule adds `RAC update <role_id>` (with spaces) plus static `administer rac_relations`.
- Field opt-in: a field-storage third-party setting, namespace `rac`, key `enabled` (surfaced as the
  `rac_enabled` checkbox on `field_storage_config_edit_form`).
- ADVA plugin ids: `rac` (`RoleAccessProvider`), `rac_typed` (`EntityTypeRoleAccessProvider`),
  `rac_relations` (`RoleAccessControlRelationsProvider`). Each declares ops `view`, `update`, `delete`.
- Grants are OR-combined across modules; node access must be rebuilt after config changes on an
  existing site.
