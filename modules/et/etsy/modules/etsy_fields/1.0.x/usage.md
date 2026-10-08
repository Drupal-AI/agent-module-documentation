<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Etsy Fields adds an "Etsy price" field type (amount + divisor + currency code) with a matching widget and formatter for Etsy Listing data.

---

Etsy Fields is a small submodule of the Etsy API project that provides Drupal field plugins for Etsy-specific data. Its one field type, `etsy_price`, stores a price the way the Etsy API returns it: an unsigned integer `amount`, an unsigned integer `divisor` (default 100) and a short `currency_code`. The default widget offers three inputs (amount, divisor, currency select), and the default formatter renders the value as `amount / divisor` formatted to two decimals with the currency symbol and code, using the base module's `etsy_supported_currencies()` map. The formatter renders through the `etsy_price` theme hook (defined by the Etsy Shop submodule), so full display normally assumes Etsy Shop is also enabled. It depends on the `etsy` base module.

---

- Store an Etsy-style price (amount, divisor, currency_code) on an entity.
- Add an "Etsy price" field to the Etsy Listing content type or any entity.
- Capture prices as integer amount + divisor, matching the Etsy API payload.
- Select a currency from Etsy's supported currency list in the widget.
- Display a price as amount/divisor formatted to two decimals.
- Show the currency symbol and code alongside the amount.
- Reuse the base module's supported-currency map for symbols/labels.
- Provide the default widget for editing an Etsy price field.
- Provide the default formatter for displaying an Etsy price field.
- Back custom Etsy integrations that need a price field type.
- Complement the Etsy Shop listing display with a price field.
- Keep price storage compact (two integers + a 5-char code).
- Depend on the etsy base module for currency data and theming.
- Offer a currency select spanning ~30 Etsy currencies.
- Format money consistently across Etsy listing displays.
