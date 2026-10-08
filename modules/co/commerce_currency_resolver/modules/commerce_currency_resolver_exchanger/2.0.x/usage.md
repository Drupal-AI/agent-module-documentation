Submodule of Commerce Currency Resolver that adds automatic price conversion through Commerce Exchanger, enabling the `auto` and `combo` pricing modes and converting orders, fees and promotions into the resolved currency.

---

This submodule wires Commerce Exchanger into the resolver. It adds a price resolver (`ExchangerResolverPrice`, tagged `commerce_price.price_resolver` priority 999) that, when `currency_source` is `auto` or `combo`, converts a product's base price to the resolved currency via the exchanger calculator (in `combo` it returns the untouched field price when the resolved currency already matches). It replaces the parent module's order processor with `ExchangerOrderProcessor` (priority 1000) — a `ServiceProviderBase::alter()` removes `commerce_currency_resolver.order_processor` — which converts every non-purchasable order item, locked custom adjustments, and Commerce VADO discount data into the resolved currency on refresh. A `hook_form_alter` on the settings form exposes the **Automatic conversion** and **Combo** radios plus a required **Exchange rate API** (`currency_exchange_rates`) provider selector (populated from active `commerce_exchange_rates` entities); the provider chosen is used by `PriceExchangerCalculator::getExchangerId()`. It also swaps core's fixed-amount **fee** plugins (`order_fixed_amount`, `order_item_fixed_amount`), fixed-amount-off **promotion offer** plugins (`order_fixed_amount_off`, `order_item_fixed_amount_off`) and the **order total price condition** for currency-aware subclasses. Requires `commerce_exchanger:commerce_exchanger`.

---

- Auto-convert all product prices from the base currency using live exchange rates.
- Enable the `auto` currency_source mode (no per-currency price fields needed).
- Enable the `combo` mode: use a per-currency field if present, otherwise auto-convert.
- Pick which Commerce Exchanger provider supplies rates (`currency_exchange_rates` setting).
- Convert locked custom order adjustments into the shopper's currency.
- Convert order items that have no purchasable entity (custom line items).
- Keep Commerce VADO discount amounts correct after a currency switch.
- Convert fixed-amount fees into the resolved currency (fee plugin overrides).
- Convert fixed-amount-off promotions into the resolved currency (promotion offer overrides).
- Make the "order total price" condition currency-aware for promotions.
- Read back the configured exchange-rate provider (introspection).
- Switch the pricing strategy to `auto` for a fully automatic multi-currency store.
- Avoid maintaining dozens of per-currency price fields on large catalogues.
- Combine with cookie/geoip/language resolvers so any selected currency gets converted prices.
- Recalculate the order total in the new currency during order refresh.
- Configure exchange rates once (in Commerce Exchanger) and reuse across the store.
- Replace the default order processor with the conversion-aware one automatically.
- Support promotions/fees defined in one currency across a multi-currency catalogue.
