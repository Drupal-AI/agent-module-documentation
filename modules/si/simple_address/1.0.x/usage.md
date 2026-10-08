<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple Address provides core address functionality without validation, with the same address-field view for all countries.

---

Simple Address provides a simplified address field — offering address entry without the per-country
validation and format switching of the full Address module, presenting the same address field layout for
all countries. It is useful where a lightweight, uniform address field is preferred over strict
country-specific formatting/validation. It depends on core Field.

Use it where a simple, consistent address field suffices and per-country validation isn't needed. It is a
fields/content feature; address data is user input rendered normally (escape on output as usual), and it
has no access-control role. Note the trade-off: without validation, entered addresses aren't checked for
correctness, so it suits informal address collection rather than shipping/billing where validation
matters. Configure the field.

---

- Provide a simple address field.
- Use a uniform layout for all countries.
- Skip per-country validation.
- Depend on core Field.
- Offer a lightweight address field.
- Avoid country format switching.
- Collect addresses informally.
- Have no access-control role.
- Escape address input on output.
- Not validate correctness.
- Use where validation isn't needed.
- Configure the address field.
- Provide consistent address entry.
- Simplify address collection.
- Handle addresses uniformly.
- Trade validation for simplicity.
- Add a basic address field.
- Present the same fields everywhere.
- Collect simple addresses.
- Configure simple address.
