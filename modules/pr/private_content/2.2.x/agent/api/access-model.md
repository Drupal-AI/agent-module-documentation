<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Access model: how Private Content decides who sees a private node

The module combines two mechanisms on purpose (see the "STRATEGY" comment in
`private_content.module`), because neither alone covers every case:

1. **`hook_node_access()`** — called for a single node (canonical page, edit, delete). It can
   *remove* access with `AccessResult::forbidden()`, which is what a "make it private" feature
   needs. But it is **not** called for node *listings* (Views, front page, search).
2. **Node Access Grants API** (`hook_node_grants()` + `hook_node_access_records()`) — covers the
   bulk listing queries that `hook_node_access` misses.

The module **only ever removes access; it never adds any**, and the author of a node is never
restricted by the private flag.

## hook_node_access (single node)

`private_content_node_access($node, $op, $account)`:
- If the account is **not** the owner and `$node->private->isPrivate()`:
  - `update` / `delete` → `forbidden()` unless the account has **"edit private content"**.
- Otherwise `neutral()` (fall back to core). View restriction for non-owners is handled by the
  grants records below (so listings and page stay consistent).

`private_content_entity_field_access()` also forbids editing the `private` field itself when the
field is *locked* (content-type mode Disabled or Always-private).

## Node grants (listings)

`private_content_node_grants($account, $op)` — for `view`:
- Any authenticated user gets realm `private_author` with gid = their own uid (see their own).
- Accounts with **"access private content"** get realm `private_view` with gid `PRIVATE_GRANT_ALL` (1).

`private_content_node_access_records($node)` — only for **published** nodes where
`$node->private->isPrivate()`:
- Grant `private_view` / gid 1 → `grant_view = 1` (users with the permission).
- Grant `private_author` / gid = author uid → `grant_view = 1` (the author), unless the author is
  anonymous.
- No `grant_update` / `grant_delete` here (update/delete handled in `hook_node_access`).
- Non-private (or unpublished) nodes get **no** records, so core/other modules decide them.

Net effect: a published private node is viewable only by (a) users with "access private content"
and (b) its author; everyone else is denied, in both the page and every listing.

## The computed value: isPrivate / getDefault / isLocked

On the field list (`PrivateItemList`):
- `isPrivate()` → stored value if the field has a value, else `getDefault()`.
- `getDefault()` → TRUE when the content-type mode is `PRIVATE_ALWAYS` (3) or `PRIVATE_AUTOMATIC` (2).
- `isLocked()` → TRUE when mode is `PRIVATE_ALWAYS` (3) or `PRIVATE_DISABLED` (0) (field not writable).

`PrivateComputed::getValue()` returns `getDefault()` when the stored value is NULL or the field is
locked, otherwise the stored value.

## Enabling & rebuilding (important)

Enabling this (or any node-grants) module makes Drupal start enforcing grants. After enabling, or
after changing any content type's privacy mode, rebuild access:

```bash
drush php:eval 'node_access_rebuild();'
# or the admin: /admin/reports/status "Rebuild permissions" link
```

Caveats (from README): expect a small performance cost from the extra checks, and subtle changes
to unpublished-node access (see the `unpublished_access` project). Uninstalling the module and
rebuilding removes the grants again.
