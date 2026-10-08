# Permissions

## Defined by the module

**None.** There is no `block_visibility_groups_admin.permissions.yml`; the submodule declares no
permissions of its own.

## What gates the routes

Access is controlled entirely by **core** permissions on each route
(`block_visibility_groups_admin.routing.yml`):

| Route | `_permission` |
|---|---|
| `block_visibility_groups_admin.group_create` (the "Add New Visibility Group" form) | `administer blocks` |
| `block_visibility_groups_admin.active_groups` (active-group list) | `access content` |

So a user needs the core **`administer blocks`** permission to create a group through this submodule's
form — the same permission that gates the base module's group/condition management UI. The active-group
listing only needs **`access content`**.

```
drush role:perm:add site_manager 'administer blocks'
```
