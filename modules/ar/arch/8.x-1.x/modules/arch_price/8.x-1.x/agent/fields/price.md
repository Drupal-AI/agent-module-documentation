<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `price` field (type, widget, formatter)

## Field type — `PriceItem`

`Plugin/Field/FieldType/PriceItem` (list class `PriceFieldItemList`). A product's `price` field is
typically multi-value: one item per price type. Stored columns (`schema()`):

| Column | Type | Meaning |
|---|---|---|
| `price_type` | varchar_ascii(32) | references a `price_type` config entity |
| `base` | varchar_ascii(5) | `net` or `gross` — which amount was entered |
| `currency` | varchar_ascii(5) | currency code (Currency module) |
| `net` | numeric(14,3) | net amount |
| `gross` | numeric(14,3) | gross amount |
| `vat_category` | varchar_ascii(32) | references a `vat_category` entity |
| `vat_rate` | numeric(8,4) | resolved VAT rate |
| `vat_value` | numeric(14,3) | computed VAT amount |
| `date_from` / `date_to` | varchar(20) | ISO-8601 availability window |

Computed properties add `price_type_entity`, `currency_entity`, `vat_category_entity`, and
`available_from`/`available_to` (`DateTimeComputed`).

Key methods: `getNetPrice()`, `getGrossPrice()`, `getVatRate()`, `getVatValue()`,
`getVatRatePercentage()`, `getCalculationBase()`, `isAvailable()` / `isAvailableAt($time)` (date
window), `getPriceType()` / `getVatCategory()`, and `toPrice()` → a `Price` value object. Whichever of
net/gross was **not** entered (per `base`) is derived from the VAT category rate — server-side.

## Widget — `PriceDefaultWidget`

`Plugin/Field/FieldWidget/PriceDefaultWidget` renders an editable **price table** (one row per price
type; net/gross, currency, VAT category, availability). Template `price-form-table.html.twig`, asset
`assets/js/price.widget.js` + `assets/css/price-table-form.css`. Editing prices requires the relevant
`administer prices` / per-price-type permission.

## Formatter — `PriceDefaultFormatter`

`Plugin/Field/FieldFormatter/PriceDefaultFormatter` renders the negotiated price(s) through the
`price_formatter` service and the Currency Intl amount formatter; template `price.html.twig`. Display
is filtered to prices the viewer may see (via the negotiation/access path), so restricted price types
do not leak through the formatter.
