<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Operations & manager internals

The UI is `Form\AmendOrderForm` (a plain `FormBase`, id `commerce_order_amend_form`); all mutation
logic lives in `Service\OrderAmendManager`. The form picks an operation via a `radios` element
(`operation`) with an AJAX callback (`updateOperationFields`) that swaps the `fields` fieldset, then
dispatches to per-operation build/validate/submit methods with `match($operation)`.

## The five operations

| radio value | Manager method | Fields (built by `AmendOrderForm`) |
|---|---|---|
| `swap` | `swapItem()` | `order_item_id` (select of order's items), `cross_product` (checkbox → autocomplete of any `commerce_product_variation`, else select of sibling variations of the same product, excluding current + unpublished), `override_unit_price` + `unit_price` (`commerce_price`, currency locked to order) |
| `add` | `addItem()` | `variation_id` (entity autocomplete, CONTAINS), `quantity` (number, min 1), `override_unit_price` + `unit_price` |
| `remove` | `removeItem()` | `remove_item_id` (select; warns if it is the only item) |
| `add_coupon` | `addCoupon()` | `coupon_code` (textfield) + a read-only list of currently-applied coupons |
| `remove_coupon` | `removeCoupon()` | `coupon_id` (select of the order's coupons) |

A free-text `reason` field (maxlength 255) is shown for `swap`/`add`/`remove` only. Submit button is
"Apply". After submit the form redirects to the order canonical page and pushes status/warning
messages (operation result, balance change, refresh side effects, payment guidance).

## Validation (`validateForm` → per-op)

- **swap**: order item exists AND belongs to the routed order (`getOrderId() === order->id()`);
  variation exists; not identical to current variation; stock check.
- **add**: variation exists AND `isPublished()`; stock check.
- **remove**: order item exists AND belongs to the routed order.
- **add_coupon**: code non-empty; a `commerce_promotion_coupon` with that code exists and
  `isEnabled()`; not already on the order. (Does not pre-check promotion usage limits / date window /
  conditions — the refresh's promotion processor decides whether a discount adjustment is actually
  applied.)
- **remove_coupon**: coupon id loads.
- **stock** (`validateStock`): only when `validate_stock` config is on AND `commerce_stock`'s
  `StockServiceManager` is available; skips variations flagged `commerce_stock_always_in_stock`;
  otherwise blocks if `getStockLevel($variation) < quantity`.

## Price override (`getPriceOverride`)

Returns a `commerce_price\Price` only if `override_unit_price` is checked and a number was entered,
built from the form's `unit_price` number + currency (the currency selector is constrained to the
order's currency via `#available_currencies`). Otherwise `NULL`, meaning "keep the current/default
price".

## Manager mechanics (`OrderAmendManager`)

Each public op follows the same shape: snapshot `getTotalPrice()`, mutate the order/item, call
`refreshAndSave()`, compute the balance delta, dispatch `OrderAmendEvent`, write a `commerce_log`
entry, and append the type to `amendment_types`. Each returns
`['balance_change' => string, 'refresh_changes' => string[]]` (add also returns `order_item`).

- **swapItem** — sets `purchased_entity` + title on the item; applies the override price, or re-sets
  the item's existing unit price with the overridden flag (`setUnitPrice($price, TRUE)`) so refresh
  won't re-resolve it; saves the item, then `refreshAndSave`.
- **addItem** — `createFromPurchasableEntity($variation, ['quantity' => n])` (which seeds the default
  price), applies override or locks the seeded price, `$order->addItem()`, then `refreshAndSave`.
- **removeItem** — `$order->removeItem()` + `$order_item->delete()`, then `refreshAndSave`.
- **addCoupon** — `$order->get('coupons')->appendItem($coupon)`, then `refreshAndSave`.
- **removeCoupon** — finds the matching delta in the `coupons` field and `removeItem($delta)`, then
  `refreshAndSave`.

### `refreshAndSave()` — the core

1. Locks every item's price (`setUnitPrice($item->getUnitPrice(), TRUE)` + save) unless already
   overridden. (The `$exclude_item_ids` param exists but callers never pass it — all items are locked.)
2. `captureOrderSnapshot()` — records each item's title/unit price/adjustments plus order-level
   adjustments and total.
3. `setRefreshState(OrderInterface::REFRESH_ON_SAVE)` then `$order->save()` — runs Commerce's order
   processors (promotion, tax, etc.) server-side.
4. `diffOrderSnapshot()` — returns human-readable change strings: item unit-price changes;
   order-level adjustments removed/added/changed (keyed by adjustment **type**, amounts aggregated,
   to avoid false positives from translated labels); and per-item adjustment add/remove.

### Balance & payment guidance

- `calculateBalanceChange(oldTotal, newTotal)` → `bcsub` of the two totals to 2 dp; returns e.g.
  `+130.00 EUR`, `-63.00 EUR`, or `''` when unchanged.
- The form's `addPaymentGuidance()` reads `$order->getBalance()`: `bccomp > 0` → warn outstanding
  balance + link to `…/payments`; `< 0` → warn overpaid, suggest refund. Advisory only — no charge,
  refund, or state transition is performed.

## Notes for consumers

- The amend form is reached with the `edit commerce order items` permission (the route's `accessItems`
  check) on an order whose state is in `editable_states`; the coupon operations are part of the same
  unified form. Grant the amend permissions only to trusted order administrators.
- Amendments run on orders in the configured states, which by default include `paid_order`,
  `processing`, and `ready_to_ship`; totals and balance recompute server-side, and payment collection
  or refund is completed manually on the Payments tab (as in Commerce core), so confirm it after a
  balance-changing amendment.
