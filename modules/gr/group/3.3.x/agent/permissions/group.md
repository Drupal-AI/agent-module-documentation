# Permissions

Group has **two layers** of permissions: sitewide Drupal permissions (who can administer the
Group system) and per-group permissions (what a member/outsider may do *inside* a group,
granted through `group_role` entities).

## Sitewide permissions — `group.permissions.yml`

| Permission | Gates |
|---|---|
| `administer group` | Full control over all group configuration (group types, roles, enabled content plugins, settings). `restrict access: TRUE`. |
| `access group overview` | The Group overview/admin listing page. |

Additional sitewide permissions are generated per group type via the
`GroupPermissions::groupTypePermissions` callback (e.g. create-group permissions per type).

## Per-group permissions — `group.group.permissions.yml` + relation plugins

These are checked with `$group->hasPermission($perm, $account)` and granted by `group_role`
entities, not by the sitewide role system. Base group permissions include:

| Permission | Gates |
|---|---|
| `view group` | View a published group |
| `view any unpublished group` / `view own unpublished group` | View unpublished groups |
| `view latest group version` | View the latest (possibly unpublished) revision |
| `edit group` / `delete group` | Edit / delete the group entity |
| `view all group revisions` / `view group revisions` | See group revision history |
| `revert group revisions` / `delete group revisions` | Revert / delete revisions |
| `access content overview` | View all entity relations for the group (technical; power users) |
| `join group` / `leave group` | Used by the join/leave routes (`entity.group.join` / `.leave`) |

**Relation plugins add their own per-group permissions** through their PermissionProvider
handler — e.g. `group_membership` adds `administer members`; each installed relation exposes
create/view/update/delete permissions for its target entity (and, with the
`group_support_revisions` submodule, revision permissions).

## Access checks (route requirements)

Group registers custom access checks you can use in routing:
`_group_permission`, `_group_member`, `_group_installed_content`, `_group_owns_content`,
`_group_relationship_create_access` / `_create_any_access` / `_create_entity_access` /
`_create_any_entity_access`, and `_group_latest_revision`.
