<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Arch Grouped product — group model, API & matrix

## Install & enable

```bash
drush en arch_product_group -y
```

Depends on `arch_product`. `hook_install()` runs `UPDATE arch_product_field_data SET group_id = pid`
so every existing product becomes its own single-member group.

## The group_id model

Group membership is stored directly on the `product` entity's **`group_id`** integer field — all
products sharing a `group_id` are one group, and the product whose `id() == group_id` is the group
**parent**. Supporting hooks (`arch_product_group.module`):

- `hook_entity_base_field_info` adds a computed boolean **`is_group_parent`**
  (`Plugin\Field\FieldType\IsGroupParentItemList`).
- `hook_entity_base_field_info_alter` tweaks the `group_id` field.
- `hook_entity_presave` sets an empty `group_id` to the product's own id.
- `hook_form_alter` / display-form alters set the raw `group_id` field `#access = FALSE` and force
  its display region hidden, keeping it module-managed rather than hand-edited.

## `GroupHandler` (service `product_group.handler`)

Injected with `@database`, `@entity_type.manager`, `@module_handler`, `@language_manager`.

| Method | Purpose |
|---|---|
| `isPartOfGroup($product)` / `isGroupParent($product)` | Membership / parent tests. |
| `getGroupId($product)` | The product's group id (cast to int via `getGroupIdValue()`). |
| `getGroupParent($product)` / `getGroupProducts($product)` | Parent / all members. |
| `createGroup(array $products, $group_id = NULL)` | Make a group from products (defaults parent). |
| `addToGroup($product, $group_id)` / `removeFromGroup($product, $group_id)` | Add / remove a member. |
| `leaveGroup($product)` | Detach a product (guards against removing a parent with members). |
| `dismissGroup($group_id)` | Disband a whole group. |

All mutations go through the entity API (set `group_id`, save via storage); `findGroupMembers()`
caches lookups. `group_id` is int-cast throughout.

## Field plugins

- Widget **`ProductGroupWidget`** — assign a product to a group on the product form.
- Formatter **`product_group_default`** (`ProductGroupDefaultFormatter`) — render group members in a
  configured `view_mode` (schema: `field.formatter.settings.product_group_default`).
- Formatter **`product_matrix`** (`ProductMatrixFormatter`) — a variant matrix; settings `ajax`
  (bool) and `fields` (the matrix option fields). Uses `ProductMatrix` to build the option grid and
  `templates/item-list--product-matrix-field.html.twig`.

## AJAX matrix endpoint

Route `product_matrix.product` → `/api/product-matrix/{group_id}/{product}`
(`ProductMatrixApiController::product()`), requirement **`_entity_access: product.view`**,
`product: \d+`.

Flow: 404 unless `groupHandler->isPartOfGroup($product)` **and**
`groupHandler->getGroupId($product) === (int) $group_id`; translate the product to the current
language; render it in the **`full`** view mode; return an `AjaxResponse` carrying a
`ProductReplaceContentCommand` (new URL, title, target selectors built from the bundle, rendered
content, and `{group_id, product_id, ajax_url}`). `assets/js/product-matrix-ajax.js` swaps the
page content when a variant is picked.

Because the route enforces `product.view` on the requested product, the endpoint cannot expose a
variant the viewer is not allowed to see.
