<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
PhoneNumber adds a dedicated `phone` field type for international phone numbers, parsed and stored with Google's libphonenumber, and entered through a country-aware widget with flags, a dropdown, live formatting and per-country example placeholders.

---

Rather than keeping phone numbers as free text, the module stores each number in structured parts — the international number, the national/local number, the dial code, the ISO alpha-2 country, and an optional extension — so numbers are consistent and comparable. Data entry uses an intl-tel-input–style JS widget (`phone_default`) with a searchable country dropdown, flags, input masking, "format as you type", and optional IP-geolocation to preselect the visitor's country. Three formatters display the value as an international number, a national number, or the country (name, dial code, or ISO), each able to render a `tel:` link. A server-side `Phone` constraint enforces required/allowed-country/uniqueness rules, and the field integrates with Feeds (a `phone` target) and Webform (a `phone` composite element). The base module needs only core `field` plus `giggsey/libphonenumber-for-php`; two submodules extend it — `phonenumber_validation` adds libphonenumber format/type/country validation, and `phonenumber_verification` adds an SMS ownership-verification flow and TFA integration (its own docs cover those). There is no global settings page; everything is configured per field. The latest release is 1.0.0-beta1.

---

- Store international phone numbers in a dedicated, structured field.
- Add a phone field to a content type, user, or any entity.
- Let editors pick a country from a flag dropdown while typing.
- Preselect the visitor's country automatically via IP geolocation.
- Restrict a field to only certain countries (include list).
- Exclude specific countries from the selector.
- Enforce that a phone number is unique across entities.
- Collect a phone extension alongside the main number.
- Display a number in international format (`+1 …`).
- Display a number in national format for local familiarity.
- Show just the caller's country name, dial code, or ISO code.
- Render a phone number as a clickable `tel:` link.
- Mask input so only digits matching the country pattern are accepted.
- Show per-country example numbers as placeholders.
- Pin preferred countries to the top of the dropdown.
- Import phone numbers through Feeds into a phone field.
- Add a phone element to a Webform.
- Reuse the `#type => phone` form element in a custom form.
- Normalise numbers to a consistent stored format for deduplication.
- Add a custom IP-geolocation lookup service via a hook.
- Support sites still running Drupal 8.8 through 11.
- Provide a country-aware phone entry experience on registration forms.
- Store both the dialable international number and the human-friendly local one.
