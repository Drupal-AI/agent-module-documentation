<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Fee (commerce_fee) — agent index

UI for defining **fees**: surcharges Drupal Commerce adds to an order under configurable
conditions. Architecturally the mirror of **Commerce Promotion** — a content entity pairing an
**offer plugin** with **conditions** — but it emits a *positive* `fee`-type `Adjustment` instead of
a negative discount.

- **Version:** 1.1.0 · **Core:** `^10.2 || ^11` · **PHP:** `>=8.1.0`
- **Requires:** `commerce`, `commerce_order`, `inline_entity_form`, core `options`
- **Admin UI:** `/admin/commerce/fees` (menu under Commerce admin) · **Admin permission:** `administer commerce_fee`
- **No** config schema, `.routing.yml`, `.permissions.yml`, `.install`, or Drush commands — routes
  and permissions are derived from the entity definition.

## Mechanism in one pass
1. A `commerce_fee` content entity stores one **fee-offer plugin** (`plugin` field), zero or more
   **conditions** (`conditions` + `condition_operator` AND/OR), required `order_types` and `stores`,
   a `start_date`/`end_date` window, and a `status` flag.
2. `FeeOrderProcessor` (service `commerce_fee.fee_order_processor`, tagged
   `commerce_order.order_processor` **priority 120**, `adjustment_type: fee`) runs on every order
   refresh.
3. `FeeStorage::loadAvailable($order)` pre-filters enabled fees by store, order type, and date
   window via entity query; `Fee::available()` re-checks; `Fee::applies()` evaluates the
   `ConditionGroup`; `Fee::apply()` invokes the offer plugin.
4. The offer plugin appends an `Adjustment` of `type => 'fee'` (label = `display_name` or "Fee",
   `source_id` = fee id) to the order or to matching order items.

## Key files
| Concern | File |
| --- | --- |
| Fee entity (fields, available/applies/apply) | `src/Entity/Fee.php`, `src/Entity/FeeInterface.php` |
| Order processor (entry point) | `src/FeeOrderProcessor.php` |
| Availability query | `src/FeeStorage.php` |
| Offer plugin base + type | `src/Plugin/Commerce/Fee/FeeBase.php`, `FeeInterface.php`, `OrderFeeBase.php`, `OrderItemFeeBase.php` |
| Shipped offer plugins | `OrderFixedAmount`, `OrderPercentage`, `OrderItemFixedAmount`, `OrderItemPercentage` |
| Plugin discovery | `src/FeeManager.php`, `src/Attribute/CommerceFee.php`, `src/Annotation/CommerceFee.php`, `commerce_fee.plugin_type.yml` |
| Add/edit form | `src/Form/FeeForm.php` |
| Services / subscribers | `commerce_fee.services.yml`, `src/EventSubscriber/*` |

## Deeper docs
- [entities/fee.md](entities/fee.md) — the `commerce_fee` entity, its base fields, lifecycle
  methods, routes, and permissions.
- [plugins/fee-offers.md](plugins/fee-offers.md) — the `commerce_fee.fee` plugin type, the four
  shipped offer plugins, and how to add a custom one.

## Gotchas
- **Fees require a store first.** `FeeForm` short-circuits with a warning if no `commerce_store`
  exists.
- **Order-level fees are split across items** via `commerce_order.price_splitter` (for correct VAT
  and partial-refund behaviour); order-item fees adjust each matching item directly.
- **Order-item fees carry their own inner conditions** (targeting `commerce_order_item`, operator
  always OR) — separate from the fee entity's order-level conditions.
- **`order_store` / `order_type` conditions are removed** from the fee condition UI
  (`FilterConditionsEventSubscriber`) because the entity already has `stores`/`order_types` fields.
- Fee entities are **translatable content**, not config — nothing is exported to sync.
- The README notes an (optional, upstream) tweak to Commerce's `PluginItemDeriver` to expose the
  `commerce_fee` plugin in some UIs; current Commerce releases handle this without patching.
