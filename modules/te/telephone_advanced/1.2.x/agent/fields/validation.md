# Validation constraint & tel-element validation

## The `TelephoneAdvanced` constraint

- Plugin: `Drupal\telephone_advanced\Plugin\Validation\Constraint\TelephoneAdvancedConstraint` (id `TelephoneAdvanced`).
- Validator: `TelephoneAdvancedConstraintValidator` (services: `telephone_advanced.telephone_validator`, core `country_manager`).
- Attached to **every** `telephone` field via `telephone_advanced_field_info_alter()`
  (`$info['telephone']['constraints']['TelephoneAdvanced'] = []`). So installing the module
  adds the constraint globally, but the validator returns early unless the field's
  `enabled` third-party setting is TRUE.

### Validation flow (`validate()`)

1. Skip if the item is empty, or if `FieldSettings::isEnabled($field_definition)` is FALSE.
2. **Valid number** — `TelephoneValidator::isValid($value, $default_country)`. Internally libphonenumber `PhoneNumberUtil::parse()`; a `NumberParseException` means invalid. Violation `notValidMessage`.
3. **Allowed country** (only if `allowed_countries` set) — `isFromCountry()` compares the number's detected region to the list. Violation `countryNotAllowedSingularMessage` / `countryNotAllowedPluralMessage`.
4. **Allowed type** (only if `allowed_types` set) — `isOfType($value, $allowed_types, FALSE, $default_country)`. Non-strict: an allowed `FIXED_LINE` or `MOBILE` also matches libphonenumber `FIXED_LINE_OR_MOBILE`. Violation `typeNotAllowedSingularMessage` / `typeNotAllowedPluralMessage`.

Message strings are public properties on the constraint class (e.g. `notValidMessage = "@label isn't a valid telephone numer."`) and can be overridden by extending the constraint.

Operational note: because the constraint applies to all telephone fields, once a field is
`enabled`, previously stored values that libphonenumber rejects will start failing on the
next save/edit of that entity. Enable on fields whose existing data is already clean, or
plan a normalization pass.

## Validating a custom `tel` element

`telephone_advanced_element_info_alter()` appends `telephone_advanced_validate_tel` to the
`tel` element's `#element_validate`. Add a `#telephone_advanced` property (all keys
optional) to opt a `tel` element into validation/formatting:

```php
use libphonenumber\PhoneNumberFormat;
use libphonenumber\PhoneNumberType;

$form['phone'] = [
  '#type' => 'tel',
  '#title' => t('Phone'),
  '#telephone_advanced' => [
    'default_country' => 'BE',                      // recommended
    'allowed_countries' => ['BE', 'NL', 'FR', 'DE'],
    'allowed_types' => [PhoneNumberType::FIXED_LINE],
    'format' => PhoneNumberFormat::INTERNATIONAL,   // reformats #value on success
  ],
];
```

The handler skips empty values, runs the same valid/country/type checks as the field
constraint, and — if `format` is set and the number passed — rewrites the element's value
to that format via `telephone_advanced.telephone_formatter` (`$form_state->setValueForElement()`).
