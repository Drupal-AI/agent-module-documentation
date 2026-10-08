<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Grouped product (arch_product_group) — agent index

Arch submodule that links related **product variants** into a group and renders them as a switchable
option matrix, swapped via AJAX. Package *Arch product*. Depends on **`arch_product`**. Provides config
schema, no permissions of its own. Core `^9.4 || ^10 || ^11`. License GPL-2.0-or-later.

## What it provides (from source)

- **Services** (`arch_product_group.services.yml`):
  - `product_group.handler` (`GroupHandler`, injected `@database`, `@entity_type.manager`,
    `@module_handler`, `@language_manager`) — records/queries group membership
    (`isPartOfGroup()`, `getGroupId()`).
  - `product_matrix` (`ProductMatrix`) — builds the option-combination grid for a group.
- **Route** — `product_matrix.product` = `/api/product-matrix/{group_id}/{product}`
  (`ProductMatrixApiController::product`), `requirements._entity_access: 'product.view'`,
  `product: \d+`. Returns an `AjaxResponse` with a `ProductReplaceContentCommand` that replaces the
  displayed product's markup; it 404s unless the product is in the group and its group id matches
  `{group_id}`.
- **Field plugins** — widget `ProductGroupWidget`, field type `IsGroupParentItemList` (computed
  `is_group_parent`), formatters `ProductMatrixFormatter` and `ProductGroupDefaultFormatter`.
- **AJAX command** — `Ajax/ProductReplaceContentCommand` (+ `assets/js/product-matrix-ajax.js`).
- **Config schema** — `config/schema/arch_product_group.schema.yml`.
- **Template** — `item-list--product-matrix-field.html.twig`.

## Access

The variant-swap API is gated by the core `product.view` entity access check, so each rendered
variant honours arch_product's grant/publish access; the controller renders through the product view
builder (`view($product, 'full')`), i.e. normal escaped render arrays.
