# Permissions

| Permission | Machine name | Description |
|---|---|---|
| Administer subentities | `administer subentities` | CRUD access for subentities (declared: "CRUD access for subentities."). |

## Where it is enforced

- It is the `admin_permission` on generated subentity content types and their bundle config
  entities.
- It gates the module's admin landing page route `subentity.entity_types`
  (`/admin/structure/subentities`) **together with** `administer site configuration` — the routing
  requirement `'administer subentities,administer site configuration'` uses a comma, which is
  logical AND, so both are required.
- It gates the generated collection/listing route (`entity.<name>.collection`) and the
  settings/bundle-collection routes emitted by the route providers.

## What it does NOT do

`administer subentities` gates the admin pages, but per-record view/edit/delete of an individual
subentity is **not** decided by this permission. Those routes use `_entity_access`, which routes to
`ReferencedEntityAccessControlHandler` — access is inherited from the parent entity that references
the subentity (see api/framework.md). Granting this permission does not, by itself, let a user view
or edit subentity records whose parent they cannot access.

Grant via Drush: `drush role:perm:add <role> 'administer subentities'`.
