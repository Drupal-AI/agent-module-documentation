<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Currencies Price adds a single Drupal Commerce field type that stores a manually-entered price for every enabled currency in one field, so you can hand-set multi-currency prices instead of relying on automatic conversion.

---

Install it alongside Drupal Commerce (`commerce` and `commerce_price`) with `composer require drupal/commerce_currencies_price` and enable the module — there is no settings page. Add a **Price currencies** (`commerce_currencies_price`) field to any bundle (for example a product variation), then on the form display choose the **Commerce currencies price** widget. The widget draws one price input per enabled `commerce_currency` grouped under a *Price per currency* section; in its form-display settings you can tick **Required prices** (force a value for every currency) and pick **Available prices** to limit which currencies get an input (leave empty for all enabled currencies). Values are saved together as one serialized map, so the field does not add a database column per currency. The bundled formatter renders nothing, and the module does **not** pick or convert a currency at checkout — reading the stored prices is up to your code via `$entity->field_name->toPrices()` (returns `\Drupal\commerce_price\Price` objects keyed by currency code) or the raw `$entity->field_name->prices` array. Because a currency with no stored price is simply absent (no fallback), confirm each market you sell in has a price set.

---

- Store several currency prices in one field.
- Add a Price currencies field to a product variation.
- Hand-set market-specific prices instead of auto-converting.
- Enter a round-number price per currency.
- Limit the editable currencies with the *Available prices* setting.
- Require a price for every currency with *Required prices*.
- Avoid creating a separate price field per currency.
- Read stored prices in code with `toPrices()`.
- Get `Price` value objects keyed by currency code.
- Access the raw price map via `$entity->field_name->prices`.
- Set per-currency prices programmatically on an entity.
- Reuse the `commerce_currencies_price` render element in a custom form.
- Build your own display of the stored prices (formatter outputs nothing).
- Keep all currency prices in a single serialized column.
- Confirm every market you sell in has a price set.
- Handle a missing-currency price explicitly (there is no fallback).
- Base enabled currencies on Commerce's currency list.
- Add the field to any fieldable entity, not just products.
- Use unlimited cardinality for multiple price sets.
- Feed stored prices into your own price-resolution logic.
- Restrict who can edit the field with core field permissions.
- Review currency prices after enabling or disabling a currency.
