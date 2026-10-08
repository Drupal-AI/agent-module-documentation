Telephone Validation adds real phone-number validation to Drupal's core Telephone field (and to any `tel` form element) using the giggsey/libphonenumber-for-php library, a PHP port of Google's libphonenumber.

---

The module wires a `Telephone` validation constraint onto every `telephone` field via `hook_field_info_alter()`, so validation is opt-in per field instance. On a telephone field's settings form (Field UI) it injects a "Telephone validation" fieldset with an **Enabled** checkbox, a **Format** select (E164 or National), and a **Country** select; these are stored as the field's third-party settings (`format`, `country`). At validation time `TelephoneConstraintValidator` reads those third-party settings and calls the `telephone_validation.validator` service, whose `isValid($value, $format, $country)` parses the number with `PhoneNumberUtil`, checks `isValidNumber()`, and — when a country list is supplied — confirms the number's region is allowed. E164 format lets the validator auto-discover the country of origin from the `+` country code; National format requires exactly one country to supply the default region. A site-wide default (Format + Valid countries) is configured at **Admin → Configuration → Content authoring → Telephone Validation** (`telephone_validation.settings`), and those defaults are pushed onto the core `tel` render element through `hook_element_info_alter()` so custom forms validate too. Developers can also attach validation directly to a `tel` element with the `TelephoneValidation::validateTel` `#element_validate` callback and `#element_validate_settings`. The `Validator` service also exposes `getCountryList()`, returning a select-ready list of countries with their calling codes.

---

- Validate that a phone number entered in a core Telephone field is a real, dialable number.
- Turn on validation per field instance from the field's Field UI settings form (opt-in).
- Require numbers in E164 international format (e.g. `+14155552671`) so the country is auto-detected.
- Restrict a field to numbers from one country using National format plus a country selection.
- Allow numbers from a specific set of countries (multi-select) while rejecting all others.
- Accept numbers from any country by leaving the country list empty.
- Reject malformed or unparseable input before it is saved to an entity.
- Set a site-wide default validation format and country list at the settings page.
- Have custom `tel` form elements automatically pick up the global validation defaults.
- Attach phone validation to a bespoke form's `tel` element via `#element_validate`.
- Override validation settings per form element with `#element_validate_settings`.
- Validate a phone number programmatically by calling the `telephone_validation.validator` service.
- Build a country dropdown (name + calling code) from `getCountryList()`.
- Enforce E164 storage so numbers are consistent for SMS or telephony integrations.
- Collect nationally-formatted numbers (without the `+` prefix) for a single-country audience.
- Prevent typo'd or fake phone numbers on contact, registration, or lead-capture forms.
- Add the `Telephone` constraint's behavior to any telephone field without writing code.
- Deploy default validation settings between environments as configuration.
- Use libphonenumber's metadata to check that a number's length and pattern fit its region.
- Switch a field between international and national validation without data migration.
- Skip validation gracefully when a field has no validation settings enabled.
- Show a clear "not a valid phone number" violation message on invalid input.
- Extend or decorate the `Validator` service for custom number-validation rules.
- Gate access to the default-settings form behind the `administer site configuration` permission.
