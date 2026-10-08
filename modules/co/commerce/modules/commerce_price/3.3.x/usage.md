Commerce Price defines the Currency config entity, a Price field type, and currency-aware price/number formatting for Drupal Commerce.

---

Money in Commerce is represented by a **Price** value object (a decimal amount plus a currency code) rather than a raw float, avoiding rounding errors via BC Math. This submodule supplies the `commerce_price` **field type** (used by products, order items, adjustments), a formatter and widget, and the `commerce_currency` **config entity** describing each enabled currency (name, symbol, fraction digits, numeric code). It imports currency definitions and locale-aware formatting rules from the `commerceguys/intl` library, so prices render correctly for the customer's locale (symbol placement, decimal/grouping separators). A price formatter service and currency formatter turn Price objects into localized strings, and a rounder applies correct rounding per currency. Number patterns and minor-units handling are included. It depends only on the base Commerce module. Manage enabled currencies at Admin → Commerce → Configuration → Currencies (`entity.commerce_currency.collection`).

---

- Store monetary amounts as currency-aware Price value objects.
- Add a price field to products, variations or custom entities.
- Enable and manage the currencies your store supports.
- Format prices per the customer's locale (symbol, separators).
- Avoid floating-point rounding errors using BC Math.
- Round prices correctly to each currency's fraction digits.
- Import currency definitions from the intl library.
- Display prices with the correct currency symbol and placement.
- Support multiple currencies across stores.
- Convert between major and minor units (e.g. dollars/cents).
- Provide a price widget for data entry in admin forms.
- Render formatted prices in Twig/templates.
- Compute totals and adjustments as Price objects.
- Add a custom currency with specific formatting rules.
- Localize price display for international customers.
- Use the price formatter service in custom code.
- Compare and add Price objects safely in the same currency.
- Show tax-inclusive or tax-exclusive prices (with commerce_tax).
- Drive per-store default currency (with commerce_store).
- Format zero/negative prices consistently.
