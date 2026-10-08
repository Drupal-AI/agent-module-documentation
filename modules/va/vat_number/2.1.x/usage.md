<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VAT Number adds a Drupal field type for European VAT registration numbers, with built-in format validation and an optional live check against the EU's VIES service, plus a Webform submodule.

---

Install it like any contributed module (`composer require drupal/vat_number`, then enable **VAT Number**); it has **no settings page and no configuration** of its own, so everything is set up where you use the field. Add a **VAT Number** field to any entity (content type, user, Commerce order, etc.), and on the entity's *Manage form display* choose the **VAT Number** widget: it offers two checkboxes — **Validate if the business is registered to trade cross-border within the EU** (the VIES check) and **Fail validation if the VIES search engine is unavailable**. By default both are off, meaning the field does only **offline format validation** — it checks the two-letter country prefix and the per-country pattern (`DE123456789`, `ATU99999999`, `BE0999999999`, …) and rejects typos, which is instant, free and needs no network. Turn on the first checkbox to additionally query **VIES** and confirm the number is actually registered for intra-EU trade; this requires the **`ext-soap` PHP extension** (the module raises an install-time error if it is missing) and reaches out to the European Commission over the network, a service that is periodically slow or unavailable — so decide with the second checkbox whether an outage should block the form (on) or let the number through on format alone (off). For forms built with the Webform module, enable the bundled **Webform VAT Number** submodule to get a **VAT number** element (under "Advanced elements") with the same two options. Note the module validates format only up to the two-letter prefix rules and does not verify the business name/address, and GB (UK) numbers pass the offline check but are no longer in VIES; for legally-binding VAT-fraud protection you still need to record the VIES response and, in some countries, perform an additional qualified check.

---

- Collect a customer's VAT number on an entity.
- Validate a VAT number's format offline.
- Reject VAT numbers with typos or a wrong country prefix.
- Check a number against the EU VIES service.
- Confirm a business is registered for intra-EU trade.
- Add a VAT number field to a Commerce order or profile.
- Support EU reverse-charge / B2B checkout.
- Add a VAT number element to a Webform.
- Choose whether a VIES outage blocks submission.
- Collect a supplier's tax number.
- Validate a country prefix on submission.
- Add a VAT field to a user registration form.
- Store a VAT number on a content type.
- Display a stored VAT number on the entity.
- Validate a VAT number in a custom form via the render element.
- Prevent invalid VAT numbers before applying a zero rate.
- Support cross-border invoicing data capture.
- Collect tax details for an EU marketplace vendor.
- Gate format validation without any external call.
- Record a VAT number for accounting integration.
