<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Group permissions (group_permissions) — agent index

Extends [Group](https://www.drupal.org/project/group). The stock Group module shares one set
of role permissions across every group of a given group type. This module lets each *individual
group* override those permissions: which permissions its Outsider / Insider / Member (and any
custom non-admin) roles have. The override set is stored as a revisionable `group_permission`
content entity (one per group) and edited through a per-group permissions form.

- Depends on `group:group` (composer `drupal/group:^2.0 || ^3.0`). Core `^10 || ^11`.
- No module settings page (`configure` route: none). Overriding is switched on **per group type**
  via a checkbox on the group type form, then edited **per group** at `/group/{group}/permissions`.
- Defines permissions (site + one in-group permission). No Drush. Provides config schema
  (a group-type third-party setting). Registers two `flexible_permissions` calculators plus
  a decorator of `group_permission.checker`.

## What you'd do

- **Turn per-group overrides on for a group type / edit a group's overrides** → [configure/overrides.md](configure/overrides.md)
- **Grant/revoke a single permission, or read a group's overrides in PHP; understand how overrides are applied at runtime** → [api/manager.md](api/manager.md)
- **Grant users the right to override, or manage the override entities** → [permissions/permissions.md](permissions/permissions.md)

## Key facts

- Content entity: `group_permission` — base table `group_permission`, revision table
  `group_permission_revision`; keys `gid` (entity_reference → group, unique), `permissions`
  (`map`: `[group_role_id => [permission strings]]`), `status` (published), `uid` (owner).
  Class `Drupal\group_permissions\Entity\GroupPermission` (extends `EditorialContentEntityBase`).
- Editing route: `entity.group_permission.canonical` → `/group/{group}/permissions`
  (`_form: GroupPermissionsForm`). Also `add-form`, `edit-form`, `delete-form`,
  `version-history` (`/…/revisions`), `revision`, `revision-revert`, `revision-delete`.
- Service `group_permissions.group_permissions_manager` (class `GroupPermissionsManager`) —
  the entry point for reading/loading a group's overrides.
- Decorator `group_permissions.checker` decorates core-group's `group_permission.checker`.
- Calculators (tag `flexible_permission_calculator`): `group_permissions.individual_calculator`
  (priority -250), `group_permissions.synchronized_calculator` (priority -150).
- Route access checks: `_group_permissions_enabled` (`GroupPermissionEnabledAccessCheck`),
  `_group_permission_entity_access` (`GroupPermissionEntityAccessCheck`).
- Group-type third-party setting: `group.type.*.third_party.group_permissions.enabled` (boolean).
- Site permissions: `add group permission entities`, `edit group permission entities`,
  `delete group permission entities`. In-group permission: `override group permissions`.
- Cache tags: `group_permissions`, `custom_group_permissions:{gid}`, `group_permission_list`.
- Query access (Views + entity queries) reflected through `src/QueryAccess/*` and
  `hook_query_entity_query_alter` / `hook_query_views_entity_query_alter`.
