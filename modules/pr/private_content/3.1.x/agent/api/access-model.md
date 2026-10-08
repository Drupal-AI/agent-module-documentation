<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Access model: how Private Content decides who sees a private node

All hook logic lives on the service class `Drupal\private_content\Hook\PrivateContentHooks`
(`#[Hook]` attributes; `private_content.services.yml`, `autowire: true`). `private_content.module`
holds only `#[LegacyHook]` wrappers that delegate to it. The module combines two mechanisms on
purpose (see the "STRATEGY" comment in `private_content.module`), because neither alone covers
every case:

1. **`hook_node_access()`** — called for a single node (canonical page, edit, delete). It can
   *remove* access with `AccessResult::forbidden()`, which is what a "make it private" feature
   needs. But it is **not** called for node *listings* (Views, front page, search).
2. **Node Access Grants API** (`hook_node_grants()` + `hook_node_access_records()`) — covers the
   bulk listing queries that `hook_node_access` misses.

The module **only ever removes access; it never adds any**, and the author of a node is never
restricted by the private flag. Constants below are class constants on `PrivateContentInterface`.

## hook_node_access (single node)

`PrivateContentHooks::nodeAccess($node, $op, $account)`:
- If the account is **not** the owner and `$node->private->isPrivate()`:
  - `update` / `delete` → `AccessResult::forbidden()` (cache-per-permissions, per-user, node
    dependency) unless the account has **"edit private content"**.
- Otherwise `AccessResult::neutral()` (fall back to core). The **view** restriction for non-owners
  is handled by the grant records below (so the page and listings stay consistent), not here.

`PrivateContentHooks::entityFieldAccess()` also forbids editing the `private` field itself when the
field is *locked* (content-type mode Disabled or Always-private).

## Node grants (listings)

`PrivateContentHooks::nodeGrants($account, $op)` — for `view`:
- Any authenticated (non-anonymous) user gets realm `private_author` with gid = their own uid
  (so they see their own private nodes).
- Accounts with **"access private content"** get realm `private_view` with gid
  `PrivateContentInterface::GRANT_ALL` (1).

`PrivateContentHooks::nodeAccessRecords($node)` — only for **published** nodes where
`$node->private->isPrivate()`:
- Grant `private_view` / gid 1 → `grant_view = 1` (users with the permission).
- Grant `private_author` / gid = author uid → `grant_view = 1` (the author), **unless the author is
  anonymous** (then that record is skipped).
- No `grant_update` / `grant_delete` here (update/delete handled in `hook_node_access`).
- Non-private (or unpublished) nodes get **no** records, so core/other modules decide them.

Net effect: a published private node is viewable only by (a) users with "access private content"
and (b) its author; everyone else is denied, in both the page and every listing. The design is
fail-closed — the hooks only ever return `forbidden`/`neutral` or a `grant_view` for the two named
realms; no path returns `AccessResult::allowed()`.

## The computed value: isPrivate / getDefault / isLocked

On the field list (`PrivateItemList`):
- `isPrivate()` → stored value if the field has a value, else `getDefault()`.
- `getDefault()` → TRUE when the content-type mode is `PrivateContentInterface::ALWAYS` (3) or
  `PrivateContentInterface::AUTOMATIC` (2).
- `isLocked()` → TRUE when mode is `ALWAYS` (3) or `DISABLED` (0) (field not writable).

`PrivateComputed::getValue()` returns `getDefault()` when the stored value is NULL or the field is
locked, otherwise the stored value.

## Enabling & rebuilding (important)

Enabling this (or any node-grants) module makes Drupal start enforcing grants. After enabling, or
after changing any content type's privacy mode, rebuild access:

```bash
drush php:eval 'node_access_rebuild();'
# or the admin: /admin/reports/status "Rebuild permissions" link
```

Changing a content type's privacy mode flags the rebuild automatically: the node-type entity
builder calls `\Drupal::service(NodeAccessRebuild::class)->setNeedsRebuild(TRUE)` (the D11.4 service
API, replacing the older `node_access_needs_rebuild()` function). Saving an individual node
re-acquires its own grant records, so per-node changes are applied immediately.

Caveats (from README): expect a small performance cost from the extra checks, and subtle changes
to unpublished-node access (see the `unpublished_access` project). Uninstalling the module and
rebuilding removes the grants again.
