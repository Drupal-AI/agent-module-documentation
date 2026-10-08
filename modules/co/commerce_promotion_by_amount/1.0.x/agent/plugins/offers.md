# Offer plugins

The module provides two `@CommercePromotionOffer` plugins (instances of Commerce's existing
promotion-offer plugin type — it does **not** define a new plugin type). Both target
`commerce_order_item` and discount only ONE item in the order.

| Plugin id | Label | Amount source |
|---|---|---|
| `order_item_fixed_amount_off_by_amount` | Fixed amount off for cheapest or most expensive matching product | `FixedAmountOffTrait` (a price amount) |
| `order_item_percentage_off_by_amount` | Percentage off for cheapest or most expensive matching product | `PercentageOffTrait` (a 0–1 percentage) |

Classes: `OrderItemFixedAmountOffByAmount` / `OrderItemPercentageOffByAmount`, both extending
`Drupal\commerce_promotion\Plugin\Commerce\PromotionOffer\OrderItemPromotionOfferBase` and
mixing in the shared `OrderItemOffByAmountTrait`.

## Configuration keys

Beyond the inherited `amount` (fixed) or `percentage` (percentage) value, the shared trait
adds three keys (all stored in the offer's `configuration`):

| Key | Values | Default | Meaning |
|---|---|---|---|
| `type` | `cheapest` \| `most_expensive` | `cheapest` | Which single item to discount. |
| `compare` | `product` \| `order_item` | `product` | Rank items by **unit price** (`product`) or by **order-item total price** (`order_item`) when deciding cheapest/most expensive. |
| `scope` | `order_item` \| `product` | `order_item` | Apply to **all** units of the chosen item (`order_item` = "All the products") or **one** unit (`product` = "Only one product"). |

`display_inclusive` is forced to `FALSE` (its widget is hidden by this offer).

## How it applies (`OrderItemOffByAmountTrait`)

1. `apply()` is called per order item. It computes `getItemToApply()` once: it sorts every
   order item via `sortItems()` (ascending by `getUnitPrice()` when `compare = product`, else
   by `getTotalPrice()`; reversed when `type = most_expensive`), then returns the id of the
   first item that passes the promotion's offer `ConditionGroup`. Items with a null unit price
   or zero quantity are skipped.
2. Only when the current item's id equals that chosen id does `doApply()` add an adjustment.
3. **Fixed** (`doApply`): `multiplier = quantity` when `scope = order_item`, else `1`; the
   amount is rounded and clamped to the item's adjusted total (`getAdjustedTotalPrice(['promotion'])`)
   so it never exceeds it; a `promotion` adjustment of `-amount` is added.
4. **Percentage** (`doApply`): discount = `unitPrice * percentage` when `scope = product`,
   else `totalPrice * percentage`; clamped to the adjusted total; a `promotion` adjustment of
   `-amount` (carrying the `percentage`) is added.
5. Zero adjustments are skipped. Currency mismatch (fixed offer) aborts silently.

So the discount always lands on exactly one line item — the cheapest or most expensive that
also satisfies the promotion's conditions.
