<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Product (arch_product) — agent index

The central Arch entity: a node-like **`product`** content entity with **`product_type`** bundles and
a full node-style **grant access** system. Package *Arch*. Depends on **`entity`**, **`arch`**,
**`arch_price`**. Ships submodules **`arch_downloadable_product`** and **`arch_product_group`**. Core
`^9.4 || ^10 || ^11`. License GPL-2.0-or-later.

- **The `product` / `product_type` entities, fields, revisions, actions, views** →
  [entities/product.md](entities/product.md)
- **The grant-based access system (how view/edit/delete is decided)** →
  [access/product-access.md](access/product-access.md)

## What it provides (from source)

- **Entities** — `product` (`Entity/Product`, base table `arch_product`, revision/data tables,
  translatable, `entity_keys`: id `pid`, revision `vid`, bundle `type`, label `title`, sku `sku`,
  status `status`) and config bundle `product_type` (`Entity/ProductType`). Storage
  `ProductStorage` + `ProductStorageSchema`; view builder `ProductViewBuilder`; route provider
  `ProductRouteProvider`.
- **Routes** (`arch_product.routing.yml`) — admin list `/admin/store/products`
  (`administer products`), add `/product/add` + `/product/add/{product_type}`
  (`_product_add_access`), preview `/product/preview/{product_preview}/{view_mode_id}`
  (`_product_preview_access`), revisions under `/product/{product}/revisions/…`
  (`_access_product_revision`), product-type admin under `/admin/store/product-types`
  (`administer product types`), and grant rebuild `/admin/reports/status/rebuild-store-permissions`
  (`administer store`). Canonical `/product/{product}` comes from the entity access handler.
- **Access** — handler `ProductAccessControlHandler` → grant storage `ProductGrantDatabaseStorage`
  (table `arch_product_access`), cache context `ProductAccessGrantsCacheContext`, checks
  `ProductAddAccessCheck` / `ProductPreviewAccessCheck` / `ProductRevisionAccessCheck`, dynamic
  per-bundle permissions from `Access/ProductPermissions`. See
  [access/product-access.md](access/product-access.md).
- **Permissions** — `access product`, `bypass product access` (restricted),
  `administer products` / `administer product types` (restricted), `access product overview`,
  `view own unpublished product`, revision permissions, plus per-bundle
  `create|edit any|edit own|delete any|delete own <type> product`.
- **Forms** — `ProductForm`, `ProductDeleteForm`, `DeleteMultiple`, `ProductPreviewForm`,
  revision revert/delete forms, `ProductTypeForm`, `RebuildPermissionsForm`.
- **Actions** — `PromoteProduct` / `DemoteProduct` / `StickyProduct` / `UnstickyProduct` /
  `AssignOwnerProduct` (+ install config `system.action.product_*`).
- **Plugins** — Views (argument/field/filter/row/wizard/area), `Condition/ProductType`,
  `EntityReferenceSelection/ProductSelection`, `ProductAvailability` datatype + field
  type/widget/formatter, and a `StoreDashboardPanel/ProductCount` panel.
- **Other** — tokens (`arch_product.tokens.inc`), `PageCache/DenyProductPreview`,
  `ParamConverter/ProductPreviewConverter`, `arch_product.api.php` (grant/access hooks).

## Access model (summary)

`ProductAccessControlHandler::checkAccess()` allows an author to view their own unpublished product
(`view own unpublished product`), otherwise defers to `ProductGrantDatabaseStorage::access()` — the
same realm/grant design as core node access. All product listing SQL uses parameterized queries.
