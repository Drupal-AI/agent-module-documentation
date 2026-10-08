<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Access control model, fields & grant lifecycle

How Access By Taxonomy computes and stores node view grants. Source: `access_by_taxonomy.module`,
`src/AccessByTaxonomyService.php`, `src/NodeAccessService.php`, `access_by_taxonomy.install`.

## Install / enable

`ddev drush en access_by_taxonomy -y`. On `hook_install` (`access_by_taxonomy.install`):
1. `AccessByTaxonomyService::populateRoleGrants()` fills `access_by_taxonomy_role_gid` with one row
   (`rid` → serial `gid`) per existing role.
2. `addFieldToVocabulary()` adds `field_allowed_users` (widget `entity_reference_autocomplete`) and
   `field_allowed_roles` (widget `options_buttons`) to every vocabulary.
3. `node_access_rebuild(TRUE)` writes grant records for all nodes.

`hook_entity_bundle_create` adds the two fields to any vocabulary created later (skipped during
config sync). `hook_uninstall` removes the role rows, both field instances and their storage, then
rebuilds node access. `hook_schema` defines `access_by_taxonomy_role_gid` (`rid` varchar 255, `gid`
serial PK). Updates: `8001` makes fields non-translatable, `8002` sets `persist_with_no_fields`,
`8003` flags a node-access rebuild.

## The two fields

Config `config/install/field.storage.taxonomy_term.field_allowed_{roles,users}.yml`: entity_reference,
cardinality `-1`, `persist_with_no_fields: true`, non-translatable. `field_allowed_roles` targets
`user_role`; `field_allowed_users` targets `user`. Empty on a term = **no restriction** from that
term. Field-edit access is gated by `hook_entity_field_access` (see permissions doc).

## Grant calculation — `AccessByTaxonomyService::getTranslationGrants(NodeInterface $node)`

Called per translation from `hook_node_access_records` (`array_reduce(..., 'array_merge')` merges all
languages). Realm constants: `ROLE_REALM` `access_by_taxonomy_role`, `USER_REALM` `_user`,
`OWNER_REALM` `_owner`, `OWN_UNPUBLISHED_REALM` `_own_unpublished`, `VIEW_ANY_REALM`
`access_by_taxonomy_view_any_` (+ type id), `PUBLIC_REALM` `_public`. Every grant is view-only
(`DEFAULT_GRANT_VIEW=1`, update/delete `0`).

Branches:
- **Unpublished, author uid ≠ 0** → returns `_own_unpublished` (gid = author) + `view_any_<type>`
  (gid 1) only. Author (with `view own unpublished content`) and per-type "view any" holders see it.
- **Published** → loads role gid map (`getRoleGrant()`), finds the node type's taxonomy fields
  (`getNodeTypeTaxonomyTermFieldDefinitions` = every entity_reference field targeting taxonomy_term),
  loads each referenced term, and for each term reads `field_allowed_roles` → `_role` grant (gid =
  the role's mapped gid; missing rid is logged and skipped) and `field_allowed_users` → `_user`
  grant (gid = uid), de-duplicating with `$written_grant_roles` / `$written_grant_users`.
  - If ≥1 restricted grant was written → also add `view_any_<type>` (gid 1).
  - Else (no restricting terms) → add a single `_public` grant (gid 1).
- After either published outcome, add an `_owner` grant (gid = author) **only if author uid ≠ 0**
  (per issue #3590340).

`hook_alter('access_by_taxonomy_node_grants', $grants, $node)` lets other modules adjust the grants.

## Grant issuance — `hook_node_grants($account, $operation)` (module file)

Only for `view`. Returns: `ROLE_REALM` → `getRoleGrant($account->getRoles())` gids; `USER_REALM`,
`OWNER_REALM` → `[$account->id()]`; `PUBLIC_REALM` → `[1]`; `OWN_UNPUBLISHED_REALM` → `[$account->id()]`
iff `view own unpublished content`; `view_any_<type>` → `[1]` per type the account may "view any".
A node is viewable when any record realm/gid intersects the account's grants — additive with core and
other node-access modules, enforced at the query level.

## Rebuild lifecycle — `NodeAccessService` (`access_by_taxonomy.node_access`)

- `hook_taxonomy_term_update` compares old vs new allowed roles/users; if changed, logs and calls
  `rebuildTermAccess($tid)` (guarded by state flag `access_by_taxonomy_pause_access_rebuild`).
  `hook_taxonomy_term_delete` always rebuilds for that term.
- `rebuildTermAccess($termId)`: `getNidsUsingTerm()` (entity query over all node types' taxonomy
  fields, `accessCheck(FALSE)`), chunks by `BATCH_CHUNK_SIZE=50`, `batch_set` runs
  `processNodeAccessBatch` → `rebuildNodeAccess($nid)` (deletes the node's `node_access` rows,
  reloads, `acquireGrants` + `grantStorage->write`, invalidates the node's cache tags).
  `rebuildComplete` invalidates `node_list`.
- `hook_user_role_delete` → `cleanUpNodeAccessTableForRoleId` (deletes `_role` rows for that gid) +
  `deleteRoleGrant`. `hook_user_delete` → `cleanUserAccess` (deletes `_user`/`_owner`/`_own_unpublished`
  rows for that uid). `hook_user_role_insert` → `insertRoleGrant`.

## Term view access & entity-query tag

- `hook_ENTITY_TYPE_access` (taxonomy_term, view) → `AccessResult::forbidden()` when
  `canUserAccessTerm($tid, $account)` is FALSE; neutral otherwise. `canUserAccessTerm`: TRUE for
  `bypass node access`; TRUE if the user has any allowed role or is an allowed user; TRUE if neither
  field exists or both are empty; otherwise **FALSE** (fail-closed).
- `hook_query_access_by_taxonomy_alter`: tag an entity query `access_by_taxonomy` to restrict
  results to `taxonomy_term` ids the current user may access (terms with no allowed users/roles, or
  where the user matches).
