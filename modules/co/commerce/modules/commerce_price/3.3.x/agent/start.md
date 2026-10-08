# commerce_price — agent start

Commerce submodule: money handling. Provides the **Price** value object (amount + currency,
BC Math), the `commerce_price` field type/widget/formatter, the `commerce_currency` config
entity, and locale-aware formatting via `commerceguys/intl`. Requires `commerce`. Admin:
**/admin/commerce/config/currencies** (`entity.commerce_currency.collection`).

- Currencies, price field, formatter services → [configure/currency.md](configure/currency.md)
