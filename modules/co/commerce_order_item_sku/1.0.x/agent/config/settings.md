<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setup, settings, and sync triggers

## Install & enable

```bash
composer require drupal/commerce_order_item_sku
drush en commerce_order_item_sku -y
```

Depends on `commerce` and `commerce_order` (3.0.0+). Composer `require` also accepts
`drupal/commerce ^2.40 || ^3` (composer.json), while the module `.info.yml` pins the
`commerce`/`commerce_order` submodules at `>=3.0.0`.

## Turn storage on (per order item type)

Storage is **opt-in**. Two steps:

1. Save the settings form once (below) to establish `commerce_order_item_sku.settings`.
2. **Commerce → Configuration → Order item types**, edit a type, tick the trait
   **"Store purchased entity SKU"** (Commerce entity trait `commerce_order_item_sku`), save.

Enabling the trait adds a required `sku` bundle field (`OrderItemSkuTrait::buildFieldDefinitions()`,
`string`, weight -4). The order-item-type form has an extra validation handler
(`commerce_order_item_sku_form_commerce_order_item_type_form_validate`) that **rejects** enabling the
trait unless the type's purchasable entity has a `sku` field of type `string`.

If you set SKUs automatically, hide the `sku` field on the type's *Manage form display* so staff
don't edit it by hand.

## Settings form

Route `commerce_order_item_sku.settings_form` → `/admin/config/commerce/order-item-sku`
(permission `administer site configuration`; `SettingsForm extends ConfigFormBase`). Config object
**`commerce_order_item_sku.settings`** (schema `config/schema/commerce_order_item_sku.schema.yml`):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `setting_event` | string | `order_item_presave` | Which event stamps the SKU (radio, one of the five below). |
| `sync_on_purchased_entity_reference_update` | bool | `FALSE` | Re-sync when an order item's purchased-entity **reference** changes. |
| `sync_on_purchasable_entity_sku_update` | bool | `FALSE` | Re-sync existing order items when the product/variation's own **SKU** is edited. |

Config export example:

```yaml
# commerce_order_item_sku.settings
setting_event: order_placed
sync_on_purchased_entity_reference_update: false
sync_on_purchasable_entity_sku_update: true
```

> Note: `buildForm()` reads the second checkbox's default from `$config->get('sync')` (a legacy key)
> while `submitForm()` saves it under `sync_on_purchasable_entity_sku_update`. After the first save
> the correct key exists; the stale default only affects the pre-save form render.

## `setting_event` strategies (mutually exclusive)

Each handler returns early unless `setting_event` matches its value, so exactly one path is active:

- **`order_item_add`** — `OrderItemSkuSubscriber::onOrderItemAdd()` on
  `CartEvents::CART_ORDER_ITEM_ADD`. Sets and **saves** the SKU when the item enters the cart.
- **`order_item_presave`** — `hook_commerce_order_item_presave()`. Sets `sku` on **new** order items
  (`$order_item->isNew()`) before save; does not save again. Effective default.
- **`order_placed`** — `OrderItemSkuSubscriber::onOrderPlace()` on
  `commerce_order.place.post_transition`. Loops the order's items, sets and saves each SKU.
- **`purchased_entity_delete`** — SKUs are stamped onto related order items from the purchasable
  entity's delete (and edit) form submit; see batch below.
- **`none`** — no automatic write; populate `sku` via your own code.

All strategies read the value as `$purchased_entity->get('sku')->value` and skip when the purchased
entity is missing, has no `sku` field, or its SKU is empty.

## Follow-up sync (independent of the strategy)

- **`sync_on_purchased_entity_reference_update`** — `hook_commerce_order_item_update()`. When an order
  item's `purchased_entity` reference is swapped, updates the stored SKU — but **skips** if the stored
  SKU no longer equals the original purchased SKU (`$original_sku !== $original_purchased_entity_sku`)
  or already matches the new one, so manual edits survive.
- **`sync_on_purchasable_entity_sku_update`** — via `hook_form_alter()` handlers on purchasable-entity
  **edit** forms. `..._purchasable_entity_form_validate()` stashes the pre-edit SKU; on submit
  `..._purchasable_entity_form_submit()` batch-updates matching order items, skipping any whose SKU
  was manually changed.

## Batch back-fill (`commerce_order_item_sku_batch_update`)

Triggered from the purchasable-entity form submit handler. It queries
`commerce_order_item` entities whose `purchased_entity` is the edited/deleted entity
(`accessCheck(FALSE)` — a system maintenance query, reachable only by users who can edit/delete that
purchasable entity) and, for each, sets `sku` to the new value and saves, **unless** the item's
current SKU diverges from the original (preserving manual overrides). `_finish()` reports the count
via the messenger.

## Field formatter

`OrderItemSkuFormatter` (id `commerce_order_item_sku`, *"SKU or purchased entity SKU"*) extends core
`StringFormatter` and is selectable for the order item `sku` field on *Manage display*. If the stored
SKU is non-empty it renders through the parent string formatter (core-escaped); if empty it falls
back to the live SKU read from the current purchased entity. Applicable only to the
`commerce_order_item` `sku` field (`isApplicable()`).
