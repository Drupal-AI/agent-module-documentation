# Permissions

Node view permissions adds two permissions **per content type**. They are declared
dynamically by a permission callback, so the list grows/shrinks automatically as content
types are added or removed — there is no static `node_view_permissions.permissions.yml`
entry per type.

`node_view_permissions.permissions.yml`:
```yaml
permission_callbacks:
  - \Drupal\node_view_permissions\NodeViewPermissionsPermissions::nodeTypePermissions
```
`NodeViewPermissionsPermissions` extends core `Drupal\node\NodePermissions` and overrides
`buildPermissions()` to emit, for each `NodeType`:

| Permission (machine name) | Label | Gates |
|---|---|---|
| `view any {type_id} content` | *{Type}*: View any content | Viewing **any** node of that content type (gid 1 — applies to all holders). |
| `view own {type_id} content` | *{Type}*: View own content | Viewing only nodes of that type **owned by the current user** (grant scoped to the node's owner id). Requires an authenticated account. |

Manage them on **People → Permissions** (`/admin/people/permissions`). There is no
settings form and no `configure` route.

## Why this module exists

Drupal core provides per-content-type `create`, `edit own/any`, and `delete own/any`
permissions, but for **viewing** it only ships the single broad `access content`
permission — there is no core per-type "view own/any" control. This module fills exactly
that gap.

## How enforcement works (node access grant system)

The module does **not** use `hook_node_access`; it uses core's grant system, so access is
applied uniformly to node pages, Views, listings, and search queries.

- **`hook_node_access_records($node)`** — writes grant records for each node. Realms are
  named after the content type:
  - Published: `view_any_{type}_content` (gid 1) and `view_own_{type}_content` (gid = node owner id).
  - Unpublished: `view_any_unpublished_{type}_content` / `view_own_unpublished_{type}_content`.
  - Translations get per-language realms, e.g. `view_any_{type}_{langcode}_content`, chosen by
    the translation's own publish status.
  - All records set `grant_view = 1`, `grant_update = 0`, `grant_delete = 0` — view only.

- **`hook_node_grants($account, $op)`** — for `$op == 'view'`, returns the realms the account
  qualifies for, based on the permissions it holds:
  - `view any {type} content` → grant in `view_any_{type}_content` (and per-language realms) with gid `[1]`.
  - `view own {type} content` (authenticated only) → grant in `view_own_{type}_content` with gid `[account id]`, so the user matches only nodes they own.
  - Unpublished realms are added **only if** the account also has the core permission
    `view any unpublished content` / `view own unpublished content` **and** the corresponding
    published permission. So unpublished view access is gated by both this module's per-type
    permission and core's unpublished permission.
  - Results are statically cached per `account:op`.

## Install-time behavior

`hook_install()` calls `node_access_needs_rebuild(TRUE)` and grants `view any {type} content`
to the **anonymous** and **authenticated** roles for every existing content type, preserving
core's default "everyone can view published content" behavior. `hook_uninstall()` and
`hook_update_8001()` also flag a node access rebuild. After changing which roles hold these
permissions you may need to rebuild node access grants (`drush php:eval 'node_access_rebuild();'`
or via the reports page).

## Notes

- "Own" grants require an authenticated user; anonymous users can never match a `view_own_*` realm.
- Because grants set only `grant_view`, this module governs **viewing** only — edit/delete
  remain governed by core's node permissions.
- Granting a role `view any {type} content` supersedes `view own {type} content` for that type.
