Submodule of Commerce Currency Resolver that keeps Commerce Shipping flat-rate costs correct when the order currency changes — via per-currency rate fields or automatic Commerce Exchanger conversion.

---

The submodule makes the core flat-rate shipping methods currency-aware. A `hook_commerce_shipping_method_info_alter` swaps the class of the core `flat_rate` and `flat_rate_per_item` shipping methods to `FlatRateCurrency` / `FlatRatePerItemCurrency`, which use `CurrencyResolverShippingTrait`: when calculating a rate they return a price for the order's currency — using a configured per-currency amount in the method's `fields[<currency>]` if present, otherwise auto-converting the base `rate_amount` through the exchanger calculator; `selectRate()` likewise converts the selected rate to the order currency. It also registers `ShippingCurrencyOrderProcessor` (tagged `commerce_order.order_processor`, priority 999) that, when the resolver flags a currency refresh (`currency_order_refresh` order data), sets the Commerce Shipping `FORCE_REFRESH` flag so shipments recalculate their rates in the new currency. Requires `commerce_shipping:commerce_shipping` and `commerce_exchanger:commerce_exchanger`. Enable it when you run automatic conversion and want shipping to follow the shopper's currency; if you only use per-currency prices and the *Order currency* condition, you may not need it.

---

- Keep flat-rate shipping costs correct after a shopper switches currency.
- Auto-convert a shipping method's base rate into the order currency via Commerce Exchanger.
- Define per-currency shipping amounts on a flat-rate method and have the right one used.
- Make `flat_rate` and `flat_rate_per_item` shipping methods currency-aware automatically.
- Multiply per-item rates by quantity in the correct currency.
- Force shipments to recalculate rates when the order currency changes.
- Convert the selected shipping rate to the order currency at selection time.
- Support multi-currency checkout with automatic shipping conversion.
- Pair with the exchanger submodule for end-to-end automatic multi-currency pricing.
- Avoid creating separate shipping methods per currency.
- Serve international shoppers with location/currency-aware shipping prices.
- Keep shipping consistent with the resolver's chosen currency (cookie/geoip/language).
- Fall back to auto-conversion when a per-currency shipping amount is missing.
- Recompute shipping only when needed (guards on the shipment/refresh flags).
- Integrate flat-rate shipping with the exchanger price calculator service.
- Confirm the currency-aware shipping order processor runs at priority 999.
- Handle migrated shipping configs where per-currency amounts may be empty.
