<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Access By Taxonomy (access_by_taxonomy) — agent index

Restricts **node view access by the taxonomy terms attached to a node**, enforced through Drupal's
core **node access grant** system (`hook_node_grants` / `hook_node_access_records`). Package
`Access control`. Core `^10 || ^11`. Deps: core **taxonomy**, **field_ui**, **user**. Version 1.2.3.
Governs only the **view** operation — update/delete stay with core node permissions.

- **Install, fields, grant model, hooks, realms, rebuild** → [api/access-control.md](api/access-control.md)
- **Dynamic permissions & the Views status-filter takeover** → [api/permissions-and-views.md](api/permissions-and-views.md)

## What it actually is

- Two entity-reference fields added to **every taxonomy vocabulary**: `field_allowed_roles`
  (→ `user_role`) and `field_allowed_users` (→ `user`), both cardinality -1, `persist_with_no_fields`.
  Added on install and on `hook_entity_bundle_create` for new vocabularies
  (`AccessByTaxonomyService::addFieldToVocabulary`). Config: `config/install/field.storage.*`.
- One DB table `access_by_taxonomy_role_gid` (`access_by_taxonomy.install`, `hook_schema`) mapping a
  role id (`rid`) to a serial grant id (`gid`), since node grant gids are integers but role ids are
  strings.
- Two services (`access_by_taxonomy.services.yml`): **`access_by_taxonomy.service`**
  (`AccessByTaxonomyService`, the grant-calculation core) and **`access_by_taxonomy.node_access`**
  (`NodeAccessService`, batch grant rebuilds).
- One Views filter plugin `Plugin/views/filter/NodeStatus` that **replaces core's `node_status`
  filter** so "view any" holders see matching content in listings.
- Dynamic permissions via `AccessByTaxonomyPermissions` (`access_by_taxonomy.permissions.yml`
  callbacks): per node type `access by taxonomy view any <type> content`, per vocabulary
  `access by taxonomy administer access for terms in <vid>`. **No routes, no config form, no Drush.**

## Grant model (from `access_by_taxonomy.module` + `AccessByTaxonomyService`)

Realms (constants in `AccessByTaxonomyService`): `access_by_taxonomy_public`, `_role`, `_user`,
`_owner`, `_own_unpublished`, `access_by_taxonomy_view_any_<type>`.

- `hook_node_access_records` → `getTranslationGrants($translation)` per language.
  - **Published + has restricting terms:** writes a `_role` grant per allowed role, a `_user` grant
    per allowed user, a `view_any_<type>` grant (gid 1), and an `_owner` grant (author uid, if not 0).
    No public grant → users without the role/user/owner/view-any match are **denied** (fail-closed).
  - **Published + no restricting terms:** writes a single `_public` grant (gid 1) → visible to all.
  - **Unpublished (author uid ≠ 0):** writes only `_own_unpublished` (author) + `view_any_<type>`.
- `hook_node_grants($account,'view')` hands the account: its role gids (`_role`), its own uid
  (`_user`, `_owner`, and `_own_unpublished` iff it has `view own unpublished content`), `_public` = 1,
  and `view_any_<type>` = 1 per content type where it holds the view-any permission.
- Also: `hook_ENTITY_TYPE_access` on taxonomy_term (view) denies terms the user cannot access
  (`canUserAccessTerm`); `hook_entity_field_access` locks the two access fields to holders of the
  per-vocabulary admin permission or `administer taxonomy`; role/user insert/delete hooks keep
  `access_by_taxonomy_role_gid` and `node_access` in sync; term update/delete triggers a batch
  rebuild via `NodeAccessService::rebuildTermAccess`.

Run **`node_access_rebuild`** after enable/config changes (install/uninstall/update 8003 do this).
Node access is **additive** across modules and applies at the query level.
