<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Fee-offer plugins (`commerce_fee.fee`)

The module defines one plugin type, declared in `commerce_fee.plugin_type.yml`:

- **Plugin type:** `commerce_fee.fee` (label "Commerce fee")
- **Manager:** `plugin.manager.commerce_fee` → `Drupal\commerce_fee\FeeManager`
- **Namespace:** `Plugin/Commerce/Fee`
- **Discovery:** `#[CommerceFee(...)]` attribute (`src/Attribute/CommerceFee.php`); legacy
  `@CommerceFee` annotation also supported (`src/Annotation/CommerceFee.php`)
- **Interface:** `Drupal\commerce_fee\Plugin\Commerce\Fee\FeeInterface`
- **Base class:** `FeeBase` (injects `commerce_price.rounder`)
- **Alter hook:** `hook_commerce_fee_info_alter()`

A plugin definition requires `id`, `label`, and `entity_type` (`commerce_order` or
`commerce_order_item`) — `FeeManager::processDefinition()` throws if any is missing or the entity
type is invalid.

## Two families
- **`OrderFeeBase`** (`entity_type: commerce_order`) — applies to the whole order, then splits the
  computed amount across order items using `commerce_order.price_splitter` so VAT and partial
  refunds work correctly.
- **`OrderItemFeeBase`** (`entity_type: commerce_order_item`) — applies per order item. Carries its
  own **inner** `conditions` (a `commerce_conditions` element scoped to `commerce_order_item`,
  operator always `OR`, via `plugin.manager.commerce_condition`). `Fee::apply()` only passes an
  order item to the plugin if these inner conditions evaluate true for that item.

Both add an `Adjustment` with `type => 'fee'`, `label` = the fee's display name (or "Fee"),
`source_id` = the fee entity id, and — for percentage plugins — a `percentage` value.

## Shipped plugins
| Plugin ID | Class | Target | Config | Effect |
| --- | --- | --- | --- | --- |
| `order_fixed_amount` | `OrderFixedAmount` | `commerce_order` | `amount` (`commerce_price`) | Adds a fixed price to the order total, split across items (skips if currency mismatch) |
| `order_percentage` | `OrderPercentage` | `commerce_order` | `percentage` | Adds a % of the order **subtotal**, rounded, split across items |
| `order_item_fixed_amount` | `OrderItemFixedAmount` | `commerce_order_item` | `amount` (`commerce_price`) | Adds `amount × quantity` to each matching item (skips on currency mismatch) |
| `order_item_percentage` | `OrderItemPercentage` | `commerce_order_item` | `percentage` | Adds a % of each matching item's total price |

Config traits: `FixedAmountTrait` (a required `commerce_price` "Amount" element) and
`PercentageTrait` (a required `commerce_number` "Percentage %" element, stored as a decimal
fraction; validated non-empty/positive).

## Adding a custom fee plugin
1. Create a class in `Plugin/Commerce/Fee/` extending `OrderFeeBase` or `OrderItemFeeBase`.
2. Annotate with `#[CommerceFee(id: '…', label: new TranslatableMarkup('…'), entity_type: '…')]`.
3. Implement `apply(EntityInterface $entity, FeeInterface $fee)` — call `$this->assertEntity()`,
   compute the price, and `$entity->addAdjustment(new Adjustment(['type' => 'fee', …]))`.
4. Add configuration by overriding `defaultConfiguration()` /
   `buildConfigurationForm()` / `submitConfigurationForm()` (or reuse the traits).

## Related integration
- `ReferenceablePluginTypesSubscriber` registers `commerce_fee` as a referenceable plugin type
  (Commerce `REFERENCEABLE_PLUGIN_TYPES` event) so fees appear in the fee-type select.
- `FilterConditionsEventSubscriber` removes the redundant `order_store` and `order_type` conditions
  from the fee condition UI (those are handled by the entity's own base fields).
- `commerce_fee_commerce_condition_info_alter()` forces all `commerce_order_item` conditions into a
  single "Products" category so they group correctly in the fee UI.
