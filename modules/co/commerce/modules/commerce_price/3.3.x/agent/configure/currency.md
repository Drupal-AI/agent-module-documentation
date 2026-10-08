# Currencies, price field & formatting

## Currencies
`commerce_currency` (config entity): currency code, name, symbol, numeric code, fraction
digits. Manage/import at `/admin/commerce/config/currencies`
(`entity.commerce_currency.collection`). Definitions and formatting come from
`commerceguys/intl`.

## Price field
Field type `commerce_price` stores a decimal `number` + `currency_code`. Widget
`commerce_price_default`, formatters `commerce_price_default` / `commerce_price_calculated`.
Add via Field UI to any entity. Values are handled as `Drupal\commerce_price\Price` value
objects (immutable; `add()`, `subtract()`, `multiply()`, `compareTo()` — same-currency only).

## Services
- `commerce_price.currency_formatter` — format an amount for display (locale-aware).
- `commerce_price.number_formatter` / price formatter — render Price objects to localized
  strings (symbol placement, decimal/grouping separators).
- `commerce_price.rounder` — round a Price to its currency's fraction digits.
- `commerce_price.minor_units_converter` — convert between major and minor units
  (dollars ↔ cents), useful for gateways.

## Permissions
`administer commerce_currency` (restricted). Config schema:
`config/schema/commerce_price.schema.yml`.
