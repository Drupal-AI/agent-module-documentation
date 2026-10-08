# Commerce Currency Resolver Shipping — agent index

Submodule of **commerce_currency_resolver**. Makes Commerce Shipping flat-rate costs
currency-aware. Requires `commerce_shipping` + `commerce_exchanger`.

- **The shipping-method class overrides, the rate/convert logic, and the order processor** →
  [api/shipping.md](api/shipping.md)

Key facts:
- `hook_commerce_shipping_method_info_alter` swaps classes: `flat_rate` → `FlatRateCurrency`,
  `flat_rate_per_item` → `FlatRatePerItemCurrency` (both use `CurrencyResolverShippingTrait`).
  No new plugin ids — it re-classes the existing core methods.
- Rate calc: return the method's `fields[<orderCurrency>]` amount if set, else auto-convert
  `rate_amount` via `commerce_currency_resolver_exchanger.calculator->priceConversion()`;
  `flat_rate_per_item` multiplies by shipment quantity. `selectRate()` converts the chosen rate
  to the order currency.
- Service `commerce_currency_resolver_shipping.order_processor` (`ShippingCurrencyOrderProcessor`,
  tag `commerce_order.order_processor`, **priority 999**): when the resolver set
  `currency_order_refresh` order data, sets `ShippingOrderManagerInterface::FORCE_REFRESH` so
  shipments recompute rates in the new currency.
- No config form/schema/permission/plugins of its own; behaviour is on the shipping method's
  own `rate_amount` + optional per-currency `fields`.
