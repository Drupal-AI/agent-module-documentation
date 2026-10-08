<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `product` entity and `product_type` bundles

## `product` (`Entity/Product`)

`@ContentEntityType` id `product`, closely modelled on core `node`.

- **Tables:** base `arch_product`, data `arch_product_field_data`, revision `arch_product_revision`,
  revision data `arch_product_field_revision`. `translatable = TRUE`, `show_revision_ui = TRUE`.
- **entity_keys:** id `pid`, revision `vid`, bundle `type`, label `title`, sku `sku`, uuid `uuid`,
  status/published `status`, owner `uid`, langcode `langcode`.
- **revision_metadata_keys:** `revision_uid`, `revision_timestamp`, `revision_log`.
- **Handlers:** storage `ProductStorage` (+ `ProductStorageSchema`), view builder
  `ProductViewBuilder`, access `ProductAccessControlHandler`, views data `ProductViewsData`,
  list builder `ProductListBuilder`, translation `ProductTranslationHandler`, route provider
  `ProductRouteProvider`; forms default/add/edit `ProductForm`, delete `ProductDeleteForm`,
  delete-multiple core `DeleteMultipleForm`.
- **Links:** canonical `/product/{product}`, add-page `/product/add`, add-form
  `/product/add/{product_type}`, edit/delete under `/product/{product}/…`, version-history
  `/product/{product}/revisions`.
- `permission_granularity = "bundle"`, `common_reference_target = TRUE`.

Base fields include SKU, title, owner (`uid`), status, created/changed, revision metadata, the
`arch_price` **`price`** field, and a **product availability** value (`ProductAvailability` /
`Entity/ProductAvailability`, exposed via the `ProductAvailability` datatype, field type, widget and
formatter, and the `ProductAvailabilitySelect` form element).

## `product_type` (`Entity/ProductType`)

Config bundle entity (`bundle_entity_type = product_type`). Admin UI under
`/admin/store/product-types` (`administer product types`). Its form
(`Form/ProductTypeForm`) is where sibling submodules attach per-bundle toggles as third-party
settings — e.g. *Downloadable* (`arch_downloadable_product`), *Comparable* (`arch_compare`),
*stock_enable* (`arch_stock`). `ConfigTranslation/ProductTypeMapper` handles config translation.

## Listing, actions, views

- Admin list `/admin/store/products` (`ProductListBuilder`) with a bulk-operations form
  (`Plugin/views/field/ProductBulkForm`).
- **Actions:** `PromoteProduct`, `DemoteProduct`, `StickyProduct`, `UnstickyProduct`,
  `AssignOwnerProduct` (install config `system.action.product_*`).
- **Views plugins:** arguments (`Pid`, `Type`, `Vid`, `UidRevision`), fields (`Product`,
  `ProductBulkForm`, `RevisionLink*`), filters (`Access`, `Status`, `UidRevision`), row `ProductRow`,
  area `ListingEmpty`, wizards `Product` / `ProductRevision`, default argument `Product`.
- **Other plugins:** `Condition/ProductType`, `EntityReferenceSelection/ProductSelection`,
  `StoreDashboardPanel/ProductCount`.

## Tokens & preview

`arch_product.tokens.inc` exposes product tokens. The preview workflow uses `ProductPreviewForm`,
`ProductPreviewController`, `ParamConverter/ProductPreviewConverter` and `PageCache/DenyProductPreview`
(see [access/product-access.md](../access/product-access.md)).
