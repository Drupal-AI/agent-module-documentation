<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Telephone International Widget adds an "International telephone" form widget to core's Telephone field: an intl-tel-input country dropdown that formats and validates numbers client-side and normalizes them to international (E.164-style) form on blur.

---

Core's Telephone field stores a plain string and validates almost nothing, which is defensible — phone formats are genuinely diverse — but unhelpful in practice: people enter `07700 900123` where the site needs `+44 7700 900123`, double the country code, or use a national prefix that means nothing to a caller abroad. This module registers one field widget (`@FieldWidget` id `telephone_international`) that subclasses core's `TelephoneDefaultWidget` and, in `formElement()`, renders the input as a plain textfield tagged with the class `telephone_international_widget` and attaches the `telephone_international_widget/intl-tel-input-widget` library. The behavior in `js/telephone_international_widget.js` initializes `window.intlTelInput(input)` with **default options** — a flag/country dropdown, as-you-type country detection from the dial code, and no geolocation or third-party IP lookup (no options object is passed). On `blur`, valid numbers are rewritten to the library's international form via `iti.getNumber()` and a "Valid" message shows; invalid ones get an `error` class and a message from a fixed five-entry error map (`getValidationError()`). The library itself must be installed under `/libraries/intl-tel-input/` (Composer `jackocnr/intl-tel-input`, type `drupal-library`); the module loads the bundled `intlTelInputWithUtils.js` build, so validation utils are included with no separate `utilsScript` fetch. There is **no submodule, no route, no permission, no formatter, and no custom settings form** — the only widget setting is `placeholder`, inherited unchanged from the core default telephone widget. Two things matter in practice. First, **all validation and formatting here is client-side JavaScript**: it improves what most users submit but is trivially bypassed, so anything that depends on a stored number's shape must revalidate server-side (pair with `telephone_validation`). Second, the widget adds a country list and JS to every form that contains the field — cheap, but worth being deliberate about on high-traffic public forms. Version installed: **2.0.0-rc2** (a release candidate) on core `^10.1 || ^11`; the project is not covered by Drupal's security advisory policy.

---

- Collect international phone numbers on a content form.
- Add a country-flag dropdown to a core Telephone field.
- Validate a phone number's format as the user leaves the field.
- Normalize entered numbers to a consistent international form.
- Prepare stored numbers for an SMS gateway.
- Improve a user registration or profile form's phone input.
- Reduce badly formatted phone data at the point of entry.
- Guide users to include the correct country code.
- Support a global or multi-country customer base.
- Format a number automatically once it passes validation.
- Improve click-to-call (`tel:`) reliability downstream.
- Improve CRM/export data quality.
- Collect contact phone details on a Webform telephone field.
- Show an inline "Valid" / error hint next to the input.
- Replace the plain core telephone textfield with a richer UI.
- Reduce failed SMS or call deliveries from malformed numbers.
- Swap the widget in per field on Manage form display.
- Keep the core Telephone field type (no new field type to migrate to).
- Combine client-side UX here with server-side checks from telephone_validation.
- Standardize phone entry across many content types at once.
