# Commerce Currency Resolver Exchanger — agent index

Submodule of **commerce_currency_resolver**. Adds automatic conversion via **Commerce
Exchanger** and unlocks the `auto`/`combo` pricing modes. Requires `commerce_exchanger`.

- **Services, the auto/combo modes & provider selector, the order-processor replacement, and
  the fee/promotion/condition plugin overrides** → [api/exchanger.md](api/exchanger.md)

Key facts:
- `ExchangerResolverPrice` (tag `commerce_price.price_resolver`, priority 999): on `auto`/`combo`
  converts base price → resolved currency via the exchanger calculator.
- `ExchangerOrderProcessor` (tag `commerce_order.order_processor`, priority 1000) **replaces**
  the parent's `commerce_currency_resolver.order_processor` (removed by
  `CommerceCurrencyResolverExchangerServiceProvider::alter()`). Converts non-purchasable items,
  locked adjustments, VADO discounts.
- `hook_form_alter` adds the **Automatic conversion** / **Combo** radios + required
  **Exchange rate API** selector → `commerce_currency_resolver.settings:currency_exchange_rates`
  (id of an active `commerce_exchange_rates` provider). Read by `PriceExchangerCalculator::getExchangerId()`.
- Class overrides via alter hooks: fees `order_fixed_amount`/`order_item_fixed_amount`; promotion
  offers `order_fixed_amount_off`/`order_item_fixed_amount_off`; condition `order_total_price`.
- No config form/schema/permission of its own; the settings it drives live in
  `commerce_currency_resolver.settings` (see the parent module's configure doc).
