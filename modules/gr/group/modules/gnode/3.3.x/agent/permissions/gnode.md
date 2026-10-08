# Permissions

## Per-group permission — `gnode.group.permissions.yml`

| Permission | Gates |
|---|---|
| `access group_node overview` | Access the per-group overview of **all** group nodes, regardless of node type. |

This is a **per-group** permission (checked with `$group->hasPermission('access group_node overview', $account)` and granted through `group_role` entities), used by `gnode_entity_operation()` to show the group's **Nodes** operation link.

## Generated node permissions

Beyond that overview permission, the `group_node` plugin exposes the standard relation
create/view/update/delete permissions **per node type**, produced by
`GroupNodePermissionProvider` (a per-plugin PermissionProvider handler). These appear on each
group type's permission form so a `group_role` can, for example, allow members to create or
edit `group_node:article` content within their group. With the `group_support_revisions`
submodule enabled, revision permissions are added on top.

gnode defines **no** sitewide (Drupal) permissions of its own.
