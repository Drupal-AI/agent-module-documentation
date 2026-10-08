# Fields — base fields and order-item mapping

## Base fields on `commerce_purchasable_entity`

Defined in `PurchasableEntity::baseFieldDefinitions()` (`src/Entity/PurchasableEntity.php:203`).
The definition also pulls in `ownerBaseFieldDefinitions()` (`uid`) and
`publishedBaseFieldDefinitions()` (`status`).

| Field | Type | Constraints / settings | Form widget | View formatter |
|---|---|---|---|---|
| `sku` | `string` | **required**, `UniqueField` constraint, `display_description` | `string_textfield` (weight -4) | (configurable) |
| `title` | `string` | **required**, translatable, `max_length` 255; entity `label` key | `string_textfield` (weight -5) | `string`, label hidden (weight -5) |
| `price` | `commerce_price` | **required** | `commerce_price_default` (weight 0) | `commerce_price_default`, label above (weight 0) |
| `stores` | `entity_reference` → `commerce_store` | **required**, `CARDINALITY_UNLIMITED`, handler `default` | `commerce_entity_select` (weight -10) | (configurable) |
| `uid` | entity_reference → `user` (owner) | relabelled "Author" | `entity_reference_autocomplete` (weight 5) | (configurable) |
| `status` | boolean (published) | relabelled "Published" | `boolean_checkbox` (weight 90) | — |
| `created` | `created` | translatable | `datetime_timestamp` (weight 20) | `timestamp`, label above (weight 20) |
| `changed` | `changed` | translatable | — | — |

Entity keys: `id`, `uuid`, `langcode`, `bundle` = `type`, `label` = `title`, `sku` = `sku`,
`owner` = `uid`, `published` = `status`.

Because Field UI is enabled (`field_ui_base_route =
entity.commerce_purchasable_entity_type.edit_form`), site builders can add configurable fields per
bundle at `/admin/commerce/config/purchasable-entities/types/manage/{type}/fields`. The base fields
above are marked `setDisplayConfigurable('form'|'view', TRUE)` so their placement can be adjusted in
the form/view display UIs.

## Config bundle entity `commerce_purchasable_entity_type`

Config entity `Drupal\commerce_purchasable_entity\Entity\PurchasableEntityType`
(`ConfigEntityBundleBase`). Config schema
`config/schema/commerce_purchasable_entity.entity_type.schema.yml`. `config_export`: `id`, `label`,
`uuid`, `orderItemType`. The only functional setting beyond identity is `orderItemType`
(`getOrderItemTypeId()` / `setOrderItemTypeId()`), the order item type used when purchasing.

## Order-item-type field mapping (shipped optional config)

`config/optional/commerce_order.commerce_order_item_type.purchasable_entity.yml` defines the order
item type `purchasable_entity` with `purchasableEntityType: commerce_purchasable_entity` and
`orderType: default`. Its **form display**
(`core.entity_form_display.commerce_order_item.purchasable_entity.default`) shows:

- `purchased_entity` — `entity_reference_autocomplete` (weight 0).
- `quantity` — `commerce_quantity` (weight 1, step 1).
- `unit_price` — `commerce_unit_price` with `require_confirmation: true` (weight 2). This is an
  admin-facing order-item edit control; when the price is not explicitly confirmed/overridden, the
  order item takes the price resolved from the purchasable entity.

Its **view display** (`…entity_view_display.commerce_order_item.purchasable_entity.default`) renders
`purchased_entity` (`entity_reference_entity_view`), `quantity` (`number_decimal`), `unit_price` and
`total_price` (both `commerce_price_default`), with `adjustments` hidden.
