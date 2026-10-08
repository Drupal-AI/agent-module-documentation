<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `commerce_fee` entity

`Drupal\commerce_fee\Entity\Fee` (implements `FeeInterface`, extends
`CommerceContentEntityBase`) — a **content** entity, not config.

- **Type ID:** `commerce_fee` · **base_table:** `commerce_fee` · **data_table:** `commerce_fee_field_data`
- **Translatable:** yes (`FeeTranslationHandler`, `content_translation`)
- **Admin permission:** `administer commerce_fee`
- **Access handler:** `Drupal\entity\EntityAccessControlHandler`
- **Permission provider:** `Drupal\entity\EntityPermissionProvider`
- **Route provider:** `Drupal\entity\Routing\AdminHtmlRouteProvider` (+ `DeleteMultipleRouteProvider`)
- **Canonical URL is the edit form** (`Fee::toUrl()` maps `canonical` → `edit-form`).

## Base fields (`Fee::baseFieldDefinitions()`)
| Field | Type | Notes |
| --- | --- | --- |
| `name` | string (255) | Admin-facing name, required, translatable |
| `display_name` | string (255) | Customer-facing label shown on the order; falls back to "Fee" |
| `description` | string_long | Optional customer info |
| `order_types` | entity_reference → `commerce_order_type` | **required**, unlimited, `commerce_entity_select` widget |
| `stores` | entity_reference → `commerce_store` | **required**, unlimited |
| `plugin` | `commerce_plugin_item:commerce_fee` | the single fee-offer plugin, required; `commerce_plugin_select` widget |
| `conditions` | `commerce_plugin_item:commerce_condition` | unlimited order-level conditions (`entity_types: [commerce_order]`) |
| `condition_operator` | list_string | `AND` (default) or `OR` |
| `start_date` | datetime | required, defaults to now, `commerce_store_datetime` widget |
| `end_date` | datetime | optional |
| `status` | boolean | enabled/disabled, default enabled |

## Lifecycle methods
- **`available(OrderInterface $order): bool`** — enabled + order bundle in `order_types` + store in
  `stores` + calculation date within `[start_date, end_date)`. Uses the store timezone from the
  order's calculation date.
- **`applies(OrderInterface $order): bool`** — builds a `ConditionGroup($conditions, $operator)` and
  evaluates it. **A fee with no conditions always applies.**
- **`apply(OrderInterface $order): void`** — resolves the offer plugin. If it is an
  `OrderItemFeeInterface`, evaluates the plugin's inner conditions (`ConditionGroup(..., 'OR')`) per
  order item and applies to matching items; otherwise applies once to the whole order.

`FeeStorage::loadAvailable($order)` performs the same availability filtering as an entity query (for
performance) before the processor calls `available()`/`applies()`. See
[../plugins/fee-offers.md](../plugins/fee-offers.md) for how each plugin adds the adjustment.

## Routes (derived, no `.routing.yml`)
| Route | Path |
| --- | --- |
| `entity.commerce_fee.collection` | `/admin/commerce/fees` |
| `entity.commerce_fee.add_form` | `/fee/add` |
| `entity.commerce_fee.edit_form` | `/fee/{commerce_fee}/edit` |
| `entity.commerce_fee.duplicate_form` | `/fee/{commerce_fee}/duplicate` |
| `entity.commerce_fee.delete_form` | `/fee/{commerce_fee}/delete` |
| `entity.commerce_fee.delete_multiple_form` | `/admin/commerce/fees/delete` |
| content-translation routes | `/fee/{commerce_fee}/translations…` |

## Permissions (derived via `EntityPermissionProvider`)
`administer commerce_fee`, `access commerce_fee overview`, `create commerce_fee`,
`update commerce_fee`, `delete commerce_fee`, `duplicate commerce_fee`, `view commerce_fee`.
All fee management is behind these permissions — the entity is not customer-editable.

## Events
`FeeEvents` fires `FeeEvent` on load/create/presave/insert/update/predelete/delete and translation
insert/delete (`commerce_fee.commerce_fee.*`). The `event` handler is
`Drupal\commerce_fee\Event\FeeEvent`.
