<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Order Item UI — routes, link templates, handlers

Everything is wired in `commerce_order_item_ui_entity_type_alter()` (the `.module`), which
mutates the existing `commerce_order_item` entity type definition. The module defines **no
routing.yml of its own** — the routes come from the entity type's link templates plus the
custom route provider.

## Link templates (all scoped to an order)

| Template | Path |
|---|---|
| `collection` | `/admin/commerce/orders/{commerce_order}/order-items` |
| `add-page` | `/admin/commerce/orders/{commerce_order}/order-items/add` |
| `add-form` | `/admin/commerce/orders/{commerce_order}/order-items/add/{commerce_order_item_type}` |
| `edit-form` | `/admin/commerce/orders/{commerce_order}/order-items/{commerce_order_item}/edit` |
| `duplicate-form` | `/admin/commerce/orders/{commerce_order}/order-items/{commerce_order_item}/duplicate` |
| `delete-form` | `/admin/commerce/orders/{commerce_order}/order-items/{commerce_order_item}/delete` |

Generated route names follow Drupal's convention, e.g. `entity.commerce_order_item.collection`,
`entity.commerce_order_item.add_page`, `entity.commerce_order_item.add_form`,
`entity.commerce_order_item.edit_form`, etc.

## Handlers set on the entity type

- `route_provider['default']` = `OrderItemRouteProvider` (extends `entity`'s
  `AdminHtmlRouteProvider`). It overrides `getAddPageRoute`, `getAddFormRoute` and
  `getCollectionRoute` to make them order-scoped and apply the custom access checks below.
- `list_builder` = `OrderItemListBuilder` (renders the per-order collection list).
- Form classes: `add`/`edit`/`duplicate` → `OrderItemForm`; `delete` → `OrderItemDeleteForm`.

## Menu integration

- `commerce_order_item_ui.links.task.yml` adds an **Order Items** local task tab on the order
  canonical route (`entity.commerce_order.canonical`, weight 12).
- `commerce_order_item_ui.links.action.yml` adds an **Add order item** action link on the
  collection route.
- `hook_entity_operation()` adds an **Order Items** operation (weight 50) to each row of the
  order list, linking to `entity.commerce_order_item.collection` — only when the current user
  passes the collection access check for that order.

## Add-page behavior (`OrderItemController::addPage`)

- If exactly one `commerce_order_item_type` exists, it redirects straight to the add form for
  that type (skips the bundle chooser).
- Otherwise it renders an `entity_add_list` of the order-item types the user may create.

## Add-form field restriction

`hook_entity_bundle_field_info_alter()` narrows the `purchased_entity` reference on each
order-item type: `handler_settings['target_bundles']` is set to the product variation types
whose `getOrderItemTypeId()` equals that bundle, so the autocomplete only offers valid
variations.
