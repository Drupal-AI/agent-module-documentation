<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Price negotiation & the Price value object

## `price.negotiation` — `Negotiation/PriceNegotiation`

Constructed with `@current_user`, `@price_factory`, `@module_handler`. Selects the price a given
customer sees/pays, always from the product's **stored** `price` field — never from request input.

- `getProductPrices($product)` → all `PriceItem`s (`$product->get('price')->getPriceList()`).
- `getAvailablePrices($product, $account)` → `array_filter` via `filterAvailablePrices()`, then
  `hook_product_available_prices` alter.
- `getActivePrice($product, $account)` → `getPriceList()` (one price per type, `comparePriceItems`
  ordering), maps to `Price` objects via `toPrice()`, falls back to `getMissingPriceInstance()`, then
  `hook_product_active_price` alter. Returns a single `PriceInterface`.
- `getOriginalPrice($product, $account)` → the first available price (for strike-through), then
  `hook_product_original_price` alter.

### `filterAvailablePrices()` — the gate

A price item is kept only if **all** hold:
1. `$item->isAvailable()` — inside its date window.
2. `$item->getPriceType()` is non-empty.
3. `$priceType->access('view', $account)` is **not forbidden** — per-role price-type visibility.
4. No `hook_price_access($item, $product, $account)` implementation returns forbidden.

So price visibility and the charged amount are enforced server-side per user; a role that cannot view
a price type is never offered its price.

## `price_factory` — `Price/PriceFactory`

Builds value objects: `getInstance($values)` → `Price/Price`, plus `ModifiedPrice` (a price with an
applied modification, e.g. discount), `MissingPrice` (`getMissingPriceInstance()`), each implementing
`PriceInterface`. `Price` exposes net/gross/VAT accessors and arithmetic used by cart/order/shipping.

## `price_formatter` — `Price/PriceFormatter`

Constructed with entity type manager, the Currency `plugin.manager.currency.amount_formatter`, module
handler and renderer. Formats a `Price` into a localized currency string (see also the
`Plugin/Currency/AmountFormatter/Intl` plugin). `price.currency_locale_subscriber`
(`EventSubscriber/CurrencyLocaleSubscriber`) sets the currency locale from config on each request.

## Alter hooks (`arch_price.api.php`)

`hook_price_access`, `hook_product_available_prices`, `hook_product_active_price`,
`hook_product_original_price`, `hook_price_negotiation_prices`,
`hook_price_negotiation_empty_price_list` — the documented extension points for pricing logic
(discounts, member pricing, etc.).
