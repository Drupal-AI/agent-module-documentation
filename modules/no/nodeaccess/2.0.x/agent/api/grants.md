<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Grant mechanics (realms, hooks, tables, Grants tab)

## Realms and grant IDs

`hook_node_grants($account, $op)` returns, for the current account:

- `nodeaccess_role` → the numeric grant ids of the account's roles (via `map_rid_gid`).
- `nodeaccess_user` → `[$account->id()]` (the user's own id as grant id).
- `nodeaccess_author` → `[$account->id()]`, but **only for authenticated** users.

`map_rid_gid` (in `nodeaccess.settings`) maps each role machine id to an integer grant id used
throughout.

## Writing a node's grants: `hook_node_access_records($node)`

1. If the content type default has an `author` grant, and the node's owner is authenticated, a
   `nodeaccess_author` grant is written for the owner id.
2. The module reads its own **`nodeaccess`** table for that node id. **If any rows exist, they are
   authoritative** — one grant per row/realm (per translation language), and the bundle defaults
   are skipped.
3. Otherwise it falls back to `bundles_roles_grants[<bundle>]`, writing a `nodeaccess_role` grant
   per configured role (gid from `map_rid_gid`).

`grant_view` is ANDed with the translation's published state (unpublished → view 0).

## The `nodeaccess` table (per-node overrides)

`hook_schema()` in `nodeaccess.install` defines table **`nodeaccess`** with columns
`nid, gid, realm, grant_view, grant_update, grant_delete` (primary key `nid, gid, realm`). Rows
here are the per-node grants set from the Grants tab. Deleting a node removes its rows
(`hook_node_delete`).

Note the distinction: **`nodeaccess`** (this module's table) stores the *intended* per-node
grants; core's **`node_access`** table stores the *computed* grants that access checks read after a
rebuild. The `nodeaccess.helper` service reads back from `node_access` when rendering the Grants
form.

## The per-node Grants tab

Route `entity.node.grants` → `/node/{node}/grants` (form `GrantsForm`, tab title "Grants"). Access
is custom (`GrantsForm::access`). It lets a privileged user:

- set view/edit/delete for each **selected role** (`roles_settings[...].selected`), and
- search users by name and grant them view/edit/delete (with a "Keep?" checkbox to retain them).

Only the operations enabled in `allowed_grant_operations` are shown. Saving writes rows to the
`nodeaccess` table and triggers a node access rebuild.

## Service

`nodeaccess.helper` (`Drupal\nodeaccess\NodeAccessHelper`, args `@database`,
`@entity_type.manager`, `@config.factory`) provides `loadRolesGrants()`, `loadUsersGrants()`,
`loadUserGrant()`, `selectedRoleIds()`, and the render helpers for the Grants form, plus
`addRoleRelatedSettings()/updateRoleRelatedSettings()/deleteRoleRelatedSettings()` that keep
`nodeaccess.settings` in sync with role CRUD.
