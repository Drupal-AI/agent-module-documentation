# API — exchanger integration

## Services (`commerce_currency_resolver_exchanger.services.yml`)

| Service | Class | Tag / priority | Role |
|---|---|---|---|
| `commerce_currency_resolver_exchanger.calculator` | `PriceExchangerCalculator` (extends `AbstractExchangerCalculator`) | — | `priceConversion($price, $code)` using the selected provider; `getExchangerId()` reads `currency_exchange_rates`. |
| `commerce_currency_resolver_exchanger.order_processor` | `ExchangerOrderProcessor` | `commerce_order.order_processor` / 1000 | Converts order items w/o purchasable entity, locked custom adjustments, VADO discount data; recalculates total. |
| `commerce_currency_resolver_exchanger.price_resolver` | `Resolver\ExchangerResolverPrice` | `commerce_price.price_resolver` / 999 | On `auto`/`combo`, converts base price → resolved currency. |

## Order-processor replacement

`CommerceCurrencyResolverExchangerServiceProvider::alter()` calls
`$container->removeDefinition('commerce_currency_resolver.order_processor')` — so when this
submodule is on, the exchanger's order processor is the one that runs (only draft, unlocked,
owned orders with a currency mismatch are processed, same gate as the parent
`shouldCurrencyRefresh()`).

## Modes & provider selector

`commerce_currency_resolver_exchanger.module`:
- `hook_form_FORM_ID_alter` for `commerce_currency_resolver_settings` sets `currency_source`
  options to **`auto`** (Automatic conversion) and **`combo`** (price-per-field + automatic), and
  adds a **required** `currency_exchange_rates` select of active `commerce_exchange_rates`
  providers. If none exist, the field shows a hint and the submit button is disabled.
- Its extra submit handler saves `currency_source`, `currency_field_prefix` and
  `currency_exchange_rates` into `commerce_currency_resolver.settings`.

```bash
# choose the exchange-rate provider + auto mode
drush cset -y commerce_currency_resolver.settings currency_source auto
drush cset -y commerce_currency_resolver.settings currency_exchange_rates <provider_id>
```

## Plugin class overrides (via *_info_alter hooks)

- **Fee:** `order_fixed_amount` → `Fee\OrderFixedAmount`, `order_item_fixed_amount` →
  `Fee\OrderItemFixedAmount`.
- **Promotion offer:** `order_fixed_amount_off` → `PromotionOffer\OrderFixedAmountOff`,
  `order_item_fixed_amount_off` → `PromotionOffer\OrderItemFixedAmountOff`.
- **Condition:** `order_total_price` → `Condition\OrderTotalPrice`.

These make fixed-amount fees/promotions and the order-total condition auto-convert to the
resolved currency (shared logic in `ExchangerConditionTrait` / `ExchangerOrder*FixedAmountTrait`).
