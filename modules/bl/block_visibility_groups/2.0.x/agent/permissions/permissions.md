# Permissions

## Defined by the module

Defined in `block_visibility_groups.permissions.yml`:

| Permission | Notes |
|---|---|
| `administer block visibility groups` | Declared as the `block_visibility_group` config entity's `admin_permission` (used for entity-level access). |

## What actually gates the admin UI

Every route in `block_visibility_groups.routing.yml` (list / add / edit / delete a group, and the
condition select/add/edit/delete and group-scoped block library routes) requires the **core**
permission **`administer blocks`** — not the module's own permission. So in practice a user needs
`administer blocks` to create and manage visibility groups and their conditions through the UI.

Assigning a block to a group happens on the standard block form, which is likewise gated by core's
`administer blocks`.

```
drush role:perm:add site_manager 'administer blocks'
```
