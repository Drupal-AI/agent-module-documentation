<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Address Iran extends the Address module with an Iran-specific address format and predefined administrative-area (province) and locality (city) subdivisions.

Use it on sites collecting Iranian addresses that need proper province/city fields and formatting out of the box.

- Subscribes to Address module `ADDRESS_FORMAT` and `SUBDIVISIONS` events.
- Sets an Iran (`IR`) address format with province + locality required.
- Provides a predefined province list and their cities.
- No configuration UI — it just enriches the Address module data.

---

Install and configure:

- Require via composer: `drupal/address_iran` (needs `address ^2`, PHP >= 8.1).
- Enable `drush en address_iran`.
- Add or edit an Address field and select Iran as country.
- Province and city fields appear automatically.

---

- `AddressEventsSubscriber::onAddressFormat()` sets the `IR` format string and depth 2.
- Administrative area type is set to PROVINCE; area and locality become required.
- `onSubdivisions()` returns provinces for parents `['IR']` and cities for a given province.
- Subdivisions are hardcoded in the subscriber (no external calls).
- Works wherever the Address field renders (forms, formatters).
- No routes, permissions, or admin forms are added.
- No security surface (static data provider).
- Compatible with Commerce and other Address consumers.
- Translations use `StringTranslationTrait`.
- Extend by editing the subscriber's subdivision arrays.
- Pair with commerce for Iranian checkout addresses.
- Ensure the core Address module version matches (`^2`).
- Data quality depends on the module's built-in lists.
- Purely additive; disabling it reverts to Address defaults.
- Test province/city selection on an Address field form.
