# ECA Commerce actions

Two core `#[Action]` plugins (also `#[EcaAction]`), both typed `commerce_order_item`, selectable as
ECA actions on an order-item context. Both extend ECA's `ConfigurableActionBase`, so string fields
marked `#eca_token_replacement` run token replacement at execute time.

## `eca_commerce_change_price_in_cart` — "Change Price in Cart"

Source: `src/Plugin/Action/ChangePriceInCartAction.php`.
Sets an order item's unit price.

- Config: `final_price` (string). "This should either be a number or a token that outputs a number or
  price field. This only supports USD."
- `access()` allows only when the object is an `OrderItemInterface`.
- `execute()`: `final_price` is token-replaced, `$` stripped, wrapped as `new Price($value, 'USD')`,
  set via `$entity->setUnitPrice($price, TRUE)` (the `TRUE` overrides/locks the price) and saved.
- Currency is hard-wired to **USD** — not configurable.

## `eca_commerce_add_adjustment` — "Order Item: Add Price Adjustment"

Source: `src/Plugin/Action/CreateAdjustmentAction.php` (+ `CurrencyActionTrait.php`).
Adds a `commerce_order\Adjustment` (source_id `custom`) to the order item.

Config (schema `action.configuration.eca_commerce_add_adjustment`, defaults from
`defaultConfiguration()`):

| Key | Default | Meaning |
|---|---|---|
| `method` | `set:clear` | `set:clear` = clear existing adjustments first then add; `append:drop_first` = append. |
| `type` | `_none` | Adjustment type id; select is limited to types whose definition has `has_ui` (validated by `getValidAdjustmentTypes()`). Required. |
| `label` | `''` | Adjustment label (token-replaced). Required. |
| `amount` | `''` | Amount (number/token, token-replaced). Required. |
| `currency` | `''` | Currency code; select validated by `getValidCurrencies()` (loaded `commerce_currency` entities). `_eca_token` picks the token value; empty ⇒ fallback currency. |
| `percentage` | `''` | Optional percentage (token-replaced) → stored as `percentage` or NULL. |
| `included` | FALSE | Whether the adjustment is included in the base price. |
| `locked` | TRUE | Lock the adjustment so it survives order refresh (needed for UI-added adjustments). |
| `save_entity` | FALSE | Save the order item after adding the adjustment. |

- `access()` allows only when the object is an `EntityAdjustableInterface`.
- **Fallback currency** (`CurrencyActionTrait::getFallbackCurrency`): the entity's total-price currency
  → the entity's/order's store default currency → the default-store resolver → `'USD'`.
- Note: the `method` switch intentionally falls through — `set:clear` clears then also adds (no
  `break` after `setAdjustments([])`).

Both actions only run inside ECA models, which are trusted site configuration; amounts/labels come
from that admin-authored config (or its token references), not from end-user request input.
