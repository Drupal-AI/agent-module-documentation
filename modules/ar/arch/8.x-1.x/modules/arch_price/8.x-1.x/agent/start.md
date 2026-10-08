<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Price (arch_price) — agent index

Pricing core of the **Arch** commerce suite: price types, VAT categories, and a composite `price`
field carrying many per-customer prices, with the effective price chosen server-side by a negotiation
service. Package *Arch*. Depends on **`entity`**, **`arch`**, and the contrib **`currency`** module.
Ships submodule **`arch_price_search_api`**. Core `^9.4 || ^10 || ^11`. License GPL-2.0-or-later.

- **Price type & VAT category config entities** → [entities/price-type.md](entities/price-type.md)
- **The `price` field: type, widget, formatter, net/gross/VAT** → [fields/price.md](fields/price.md)
- **Price negotiation & the Price value object/factory** → [api/negotiation.md](api/negotiation.md)

## What it provides (from source)

- **Config entities** — `price_type` (`Entity/PriceType`) and `vat_category` (`Entity/VatCategory`),
  each with list builders, forms, delete forms and route providers. Install defaults:
  `price_type.default`, `vat_category.default`, `vat_category.custom`.
- **Field** — `price` field type (`Plugin/Field/FieldType/PriceItem`, list class `PriceFieldItemList`),
  widget `PriceDefaultWidget` (a price table), formatter `PriceDefaultFormatter`.
- **Services** (`arch_price.services.yml`):
  - `price.negotiation` (`Negotiation/PriceNegotiation`) — selects available/active/original prices.
  - `price_factory` (`Price/PriceFactory`) — builds `Price` / `ModifiedPrice` / `MissingPrice` objects.
  - `price_formatter` (`Price/PriceFormatter`) — renders amounts via the Currency Intl formatter.
  - `price_type.manager`, `vat_category.manager` — KeyValue/config-backed managers.
  - `price.currency_locale_subscriber` — sets currency locale from config.
- **Permissions** — `administer prices` (restricted), `access price type overview`,
  `access vat category overview`, plus dynamic per-`price_type` and per-`vat_category` permissions
  (`Access/PriceTypePermissions`, `Access/VatCategoryPermissions`).
- **Settings** — form `PriceSettingsForm` at `/admin/store/price` (route `arch_price.price.config`,
  `_permission: 'administer prices'`, the configure link). Config schema in
  `config/schema/arch_price.schema.yml`.
- **Currency plugin** — `Plugin/Currency/AmountFormatter/Intl` (an amount formatter for the Currency
  module).
- **Views / search** — `PriceViewsData`, `Plugin/views/argument/PriceTypeId`, and a Search API
  `Plugin/search_api/processor/Price` (the `arch_price_search_api` submodule adds a views filter).
- **API** — `arch_price.api.php` documents the alter hooks (`hook_price_access`,
  `hook_product_active_price`, `hook_product_available_prices`, `hook_price_negotiation_prices`, …).

## Price selection (server-side)

`PriceNegotiation::getActivePrice($product, $account)` reads the product's stored `price` items,
`filterAvailablePrices()` drops prices that are outside their availability window, whose `price_type`
the account cannot **view** (`$priceType->access('view', $account)`), or that a `hook_price_access`
implementation forbids, then picks one price per type (`comparePriceItems` prefers the most specific
date-limited price). Net/gross and VAT are computed on `PriceItem` from the stored amount + VAT
category — never from request input.
