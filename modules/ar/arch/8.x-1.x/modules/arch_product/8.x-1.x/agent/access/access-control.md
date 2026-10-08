<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Arch Product — permissions & product-grants access

Arch Product ports Drupal core's **node access grants** to the `product` entity. If you know
node_access, this is the same model with `product_` names.

## Permissions

Static (`arch_product.permissions.yml`):

| Permission | Notes |
|---|---|
| `access product` | View published products (required gate for any view). |
| `bypass product access` | **restricted** — view/edit/delete every product regardless of grants. |
| `administer product types` | **restricted** — manage bundles + fields. |
| `administer products` | **restricted** — cross-type promote/ownership/revisions, edit admin fields. |
| `access product overview` | The `/admin/store/products` listing. |
| `view own unpublished product` | See your own unpublished products. |
| `view / revert / delete all product revisions` | Revision operations (plus item view/edit/delete). |

Dynamic per-type (permission callback `Access\ProductPermissions::productTypePermissions`): for each
product type — `create <type> product`, `edit any <type> product`, `edit own <type> product`,
`delete any <type> product`, `delete own <type> product`, and the per-type revision permissions.

## Entity access (`Access\ProductAccessControlHandler`)

- `access()`: `bypass product access` → allowed; **missing `access product` → forbidden**; otherwise
  defer to `parent::access()` → `checkAccess()`. All results `cachePerPermissions()`.
- `checkAccess()`: if `view` on an unpublished product by its authenticated owner holding
  `view own unpublished product` → allowed (cache per user + product); **otherwise evaluate product
  grants** via `grantStorage->access($product, $operation, $account)`.
- `createAccess()`/`checkCreateAccess()`: requires `access product` then
  `create <bundle> product`.
- `checkFieldAccess()`: editing admin fields (`uid`, `status`, `created`, `promote`, `sticky`) needs
  `administer products`; `revision_timestamp`/`revision_uid` are read-only; `revision_log` editable
  by admins or when the type creates new revisions.

## Grants storage (`Access\ProductGrantDatabaseStorage`, service `product.grant_storage`)

Mirrors core `node_access` table logic (backend_overridable). Built with `@database`,
`@module_handler`, `@language_manager`; conditions are assembled with the DB **query builder**
(`Condition`, `SelectInterface`) — no string-concatenated SQL. Used both for single-entity
`access()` checks and to add access conditions to product listing queries.

## Grant hooks (`arch_product.api.php`) — how to gate the catalog

- `hook_product_grants($account, $op)` — return the realms/grant-ids a user holds for an operation.
- `hook_product_access_records($product)` — return the grant rows written for a product on save
  (realm, gid, grant_view/update/delete, langcode). `acquireGrants()` writes a default
  `{realm: all, gid: 0, grant_view: 1}` row for published products when no module supplies grants.
- `hook_product_grants_alter()` / `hook_product_access_records_alter()` — adjust the above.
- `hook_product_access($product, $op, $account)` — a per-module allow/forbid/neutral vote (like
  `hook_node_access`).
- Sale-availability hooks: `hook_product_available_for_sell()` / `_alter()`,
  `hook_arch_product_availability_options_alter()`.

`arch_price` and `arch_stock` use these hooks to restrict which products a role can see or purchase.

## Rebuilding grants

After changing access rules, rebuild the grant table from
`/admin/reports/status/rebuild-store-permissions` (`Form\RebuildPermissionsForm`, permission
`administer store`) — the equivalent of core's "rebuild node permissions". API:
`writeGrants()`, `writeDefaultGrant()`, `deleteGrants()`, `countGrants()`, `checkAllGrants()`.

## Cacheability

`cache_context.user.product_grants` (`Cache\ProductAccessGrantsCacheContext`) varies render caching
by the viewer's grants, so access-restricted catalogs cache correctly per user.
