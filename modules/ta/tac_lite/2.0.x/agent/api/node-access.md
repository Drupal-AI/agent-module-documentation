<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How the node-access mechanism works

tac_lite is a **node grants** module (no new DB tables). It implements the core node-access
hooks and a taxonomy query alter.

## `hook_node_access_records($node)` — writes grants per node

For a node tagged with terms from a `tac_lite_categories` vocabulary, for each scheme
`1..tac_lite_schemes` it emits one grant row per term:

- `realm` = the scheme's realm, `tac_lite_scheme_<n>`
- `gid` = the term id (tid)
- `grant_view` / `grant_update` / `grant_delete` = 1 for each op in the scheme's `perms`
- Applied to published nodes always, and to unpublished nodes only if the scheme's
  `unpublished` flag is set.

A node with no tac_lite terms gets no rows (so it is governed by other modules / the default
`all` realm).

## `hook_node_grants($account, $op)` — what a user may access

For each scheme whose `perms` include `grant_<op>`, returns
`[realm => [term ids the user may access]]`. The term ids come from
`_tac_lite_user_tids()`: the union of the user's **per-user** grants (user.data
`tac_lite_scheme_<n>`) and their **role-default** grants
(`tac_lite_grants_scheme_<n>[role]`), plus grant id `0` (untagged fallthrough). When
`tac_lite_storage_type` is `uuid`, stored uuids are resolved to tids in bulk.

Net effect: a user can view/update/delete a node iff they hold a grant for at least one of the
node's tac_lite terms in a scheme that grants that op.

## `hook_query_taxonomy_term_access_alter()` — term visibility

For schemes with `term_visibility` set, joins `taxonomy_term_field_data` and restricts term
queries to terms the user may see (or terms in vocabularies tac_lite doesn't control). Users
with `administer tac_lite` are exempt. Bubbles up `user.tac_lite_grants:<scheme>` cache
contexts.

## Rebuild is required

Grants are written on node save. After changing scheme config you must
`node_access_rebuild(TRUE)` (or use the UI "Rebuild permissions") so existing nodes get correct
rows. The scheme form offers a "Rebuild content permissions now" checkbox; leaving it unchecked
shows a reminder warning.

## Cache context

`user.tac_lite_grants` (service `cache_context.user.tac_lite_grants`) varies caches by a user's
grant set; `hook_entity_type_alter` adds it to `taxonomy_term` list cache contexts.
