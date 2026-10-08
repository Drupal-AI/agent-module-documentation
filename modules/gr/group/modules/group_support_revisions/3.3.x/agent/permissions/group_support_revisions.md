# Per-group revision permissions

group_support_revisions defines **no** `.permissions.yml`. It adds per-group permissions
dynamically through a decorated permission provider, so they show up on each group type's
permission form (granted via `group_role` entities) for every revisionable grouped entity type.

## What it adds

For each relation plugin whose target entity implements `RevisionableInterface` **and** which
already defines entity permissions, `SupportRevisionsPermissionProvider` exposes four
permissions (named per plugin id):

| Operation | Permission name pattern | UI title |
|---|---|---|
| view all revisions | `view all {plugin_id} entity revisions` | Revisions: View full version history |
| view revision | `view {plugin_id} entity revisions` | Revisions: View specific entity revisions |
| revert revision | `revert {plugin_id} entity revisions` | Revisions: Revert specific entity revisions |
| delete revision | `delete {plugin_id} entity revisions` | Revisions: Delete specific entity revisions |

For example, with gnode enabled you get `view all group_node:article entity revisions`, etc.

## How it decides

`SupportRevisionsPermissionProvider::init()` sets `implementsRevisionableInterface` from
`entityClassImplements(RevisionableInterface::class)`. Each `getEntity*RevisionPermission()`
returns the permission name only when both `definesEntityPermissions` and
`implementsRevisionableInterface` are true — otherwise `FALSE`, so non-revisionable entity
types get no revision permissions. `buildPermissions()` consults the full permission-provider
decorator chain (via the relation type manager) rather than just this decorator, so renames or
removals further down the chain are respected.
