<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Order Item SKU (commerce_order_item_sku) — agent index

Copies the **purchased entity's SKU onto the order item** and keeps it there, so order history
retains the SKU even after the product variation's SKU changes or the variation is deleted. Package
*Commerce (contrib)*. Depends on `commerce:commerce` and `commerce:commerce_order` (>=3.0.0).
Core `^10.3 || ^11`. License GPL-2.0-or-later. Version **1.0.0-beta1**.

- **Full setup, the settings form, config keys, and every sync trigger** →
  [config/settings.md](config/settings.md)

## What it provides (from source)

- A Commerce **entity trait** `commerce_order_item_sku` (label *"Store purchased entity SKU"*),
  `src/Plugin/Commerce/EntityTrait/OrderItemSkuTrait.php`, targeting `commerce_order_item`. When
  enabled on an order item type it adds a required **`sku`** bundle field (`string`, form widget
  `string_textfield`, display-configurable). Storage is opt-in per order item type.
- A **field formatter** `commerce_order_item_sku` (label *"SKU or purchased entity SKU"*),
  `src/Plugin/Field/FieldFormatter/OrderItemSkuFormatter.php`, extending core `StringFormatter`.
  Applies only to the `commerce_order_item` `sku` field. Shows the stored SKU; if that is empty it
  falls back to reading the SKU live from the current purchased entity.
- A **settings form** `SettingsForm` at route `commerce_order_item_sku.settings_form`
  (`/admin/config/commerce/order-item-sku`, permission `administer site configuration`; menu link
  under *Commerce → Configuration*). Writes config object **`commerce_order_item_sku.settings`**.
- An **event subscriber** `OrderItemSkuSubscriber` (service
  `commerce_order_item_sku.event_subscriber`) on `commerce_order.place.post_transition` and
  `CartEvents::CART_ORDER_ITEM_ADD`.
- Procedural **hooks** in `commerce_order_item_sku.module`: order-item `presave`/`update`, two
  `hook_form_alter` handlers, and a Batch API job for bulk back-fills.

No permissions of its own, no Drush commands, no routes beyond the settings form, no external
services, no libraries. Provides config schema (`config/schema/commerce_order_item_sku.schema.yml`).

## The five sync strategies (`setting_event`, mutually exclusive)

The single radio `setting_event` decides *when* the SKU is written; only one path runs:

- `order_item_add` — subscriber `onOrderItemAdd()` sets + saves the SKU when an item is added to
  the cart (`CartOrderItemAddEvent`).
- `order_item_presave` — `hook_commerce_order_item_presave()` sets the SKU on **new** order items
  only (`isNew()`), before save. This is the effective default (`?? 'order_item_presave'`).
- `order_placed` — subscriber `onOrderPlace()` sets + saves the SKU for every item on the
  order-place transition.
- `purchased_entity_delete` — the SKU is stamped onto related order items from the purchasable
  entity's **delete/edit form submit** (batch, see below).
- `none` — nothing is set automatically; you populate `sku` yourself.

Two independent **checkboxes** (any strategy) keep the stored SKU in sync afterwards:
`sync_on_purchased_entity_reference_update` (order-item's purchased-entity reference changed) and
`sync_on_purchasable_entity_sku_update` (the product/variation's own SKU was edited). Both are
guarded so they skip when the stored SKU has diverged from the original purchased SKU (manual
overrides are preserved). See [config/settings.md](config/settings.md).

## Batch back-fill

`hook_form_alter` adds validate/submit handlers to purchasable-entity **edit** and **delete** forms.
On submit, `commerce_order_item_sku_purchasable_entity_form_submit()` queries order items referencing
that entity and runs a Batch API job (`commerce_order_item_sku_batch_update` /
`_finish`) that rewrites each item's `sku`, skipping items whose SKU no longer matches the original.

## Test / example code

`modules/test/` ships `commerce_order_item_sku_test`, a test-only helper that swaps the cart
subscriber; not for production. Kernel/functional tests live under `tests/`.
