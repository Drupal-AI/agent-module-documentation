<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Phone Number provides a validated international phone-number field type for Drupal, backed by the `giggsey/libphonenumber-for-php` library, with a country-aware widget and several display formatters.

---

The module defines a `phone_number` field type that stores four columns — the E.164 `value`,
the `country` (ISO code), the `local_number`, and an optional `extension`. Input goes through a
custom `phone_number` form element and the `phone_number_default` widget (settings:
`default_country`, `country_selection` flag/dropdown, `placeholder`, `phone_size`), while a
`PhoneNumber` validation constraint (using libphonenumber) rejects invalid numbers and can
restrict by allowed countries and number types. Field settings include `allowed_countries`,
`allowed_types`, and an `extension_field` toggle; storage settings include a `unique` option.
Three formatters render the stored number: `phone_number_international` (E.164 international,
optionally a `tel:` link), `phone_number_local`, and `phone_number_country` (country display).
All the parsing/formatting helpers live in the `phone_number.util` service
(`PhoneNumberUtilInterface`) — e.g. `testPhoneNumber()`, `getCallableNumber()`,
`getCountryOptions()`. The module also ships a Feeds target and a Webform element for the field,
and a submodule **`sms_phone_number`** that adds SMS verification and TFA on top. It has no admin
settings page of its own (`configure` is null); you configure it per field via the usual Manage
fields / form display / display screens.

---

- Add a validated international phone-number field to a content type, user, or any entity.
- Store phone numbers in canonical E.164 form plus country and local parts.
- Reject invalid phone numbers on entity forms using libphonenumber validation.
- Restrict a field to specific allowed countries (`allowed_countries`).
- Restrict a field to specific number types (mobile, fixed line…) via `allowed_types`.
- Let editors pick the country with a flag selector or a dropdown (`country_selection`).
- Set a default country for the widget (`default_country`, e.g. `US`).
- Capture an optional phone extension alongside the number (`extension_field`).
- Enforce uniqueness of a phone number across entities (storage `unique`).
- Display a number as a clickable `tel:` link with the international formatter.
- Show a number in local national format with the local formatter.
- Show the number's country (name/code) with the country formatter.
- Provide a friendly placeholder in the phone input (`placeholder`).
- Control the width of the phone input (`phone_size`).
- Collect phone numbers via a Webform using the provided Webform element.
- Import phone numbers through Feeds using the provided Feeds target.
- Programmatically parse/validate a number with the `phone_number.util` service.
- Get a callable E.164 number or RFC3966 `tel:` URI from a stored value.
- List supported countries/dialing codes for a custom form (`getCountryOptions()`).
- Normalise user-entered numbers to a consistent stored format.
- Build a "call us" link that works on mobile from a stored phone field.
- Validate a phone number in custom code before saving.
- Add SMS verification / two-factor on top by enabling the sms_phone_number submodule.
- Standardise phone data across an existing site by switching fields to this type.
