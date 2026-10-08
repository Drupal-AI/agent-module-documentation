<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Product access (grant system)

`arch_product` reimplements core's **node access grant** model for the `product` entity. It is a
faithful clone — the same realm/gid/grant design — not a bespoke scheme.

## Decision path

`ProductAccessControlHandler` (`src/Access/ProductAccessControlHandler.php`, the entity `access`
handler) `checkAccess($product, $operation, $account)`:

1. **Own unpublished view:** if `$operation === 'view'`, the product is unpublished, the account is
   authenticated, owns it, and has `view own unpublished product` → allowed (cached per user/perms).
2. Otherwise delegate to `$this->grantStorage->access($product, $operation, $account)`.

`createAccess()` checks `create <type> product` (bundle granularity) and `ProductAddAccessCheck`.

## Grant storage

`ProductGrantDatabaseStorage` (`src/Access/ProductGrantDatabaseStorage.php`, table
**`arch_product_access`**) mirrors core `NodeGrantDatabaseStorage`:

- `access()` — a user with `bypass product access` is allowed unconditionally; the default `all/0`
  grant is always present; otherwise a query joins the product's grant records against the account's
  grants (realm/gid) for the requested operation (view/update/delete).
- `writeGrants()` / `acquireGrants()` collect records from `hook_product_access_records()` and
  grants from `hook_product_grants()` (documented in `arch_product.api.php`).
- `count()` / `checkAll()` support the rebuild flow.

The internal query builds identifiers like `$subquery->where("$palias.$field = pa.pid")` where
`$palias`/`$field` are **module-internal** table alias/column names (not request input); the
value-bearing conditions use placeholders — no SQL injection surface.

## Cache & rebuild

- `Cache/ProductAccessGrantsCacheContext` provides the `user.product_grants` cache context so
  rendered output varies correctly per the viewer's grants.
- `Form/RebuildPermissionsForm` (route `/admin/reports/status/rebuild-store-permissions`,
  `administer store`) rebuilds `arch_product_access` from all modules' access records.

## Related checks

- `ProductPreviewAccessCheck` — preview access = `createAccess()` for a new product, else
  `access('update')`. So preview never grants more than edit rights.
- `ProductRevisionAccessCheck` — gates the revision view/revert/delete routes by
  `view/revert/delete all product revisions` combined with entity update/delete access.
- `PageCache/DenyProductPreview` + `ParamConverter/ProductPreviewConverter` keep preview responses
  out of the page cache and load the previewed (unsaved) product from tempstore.

## Permissions

`access product`, `bypass product access` (restricted), `administer products` /
`administer product types` (restricted), `access product overview`,
`view own unpublished product`, revision permissions, and dynamic per-bundle
`create|edit any|edit own|delete any|delete own <type> product` from
`Access/ProductPermissions::permissions()`.
