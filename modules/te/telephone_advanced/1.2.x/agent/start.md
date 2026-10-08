<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Telephone Advanced (telephone_advanced) — agent index

Adds validation and formatting to Drupal **core's** `telephone` field (and to the `tel`
form element), backed by `giggsey/libphonenumber-for-php ^8.12 || ^9.0` (Google's
libphonenumber, a LOCAL PHP library — no external number-lookup service). It does NOT
define a new field type or widget: it swaps core's telephone field-item class, adds a
validation constraint, and provides one field formatter. Depends on core `telephone`.
Core `^10 || ^11`. No routes, no permissions, no admin settings page — configuration is
per telephone field.

- **Enable/limit validation per field (default & allowed countries, line types, storage format) + config schema** → [configure/field-settings.md](configure/field-settings.md)
- **The `TelephoneAdvanced` constraint: how numbers are validated, incl. custom `tel` elements** → [fields/validation.md](fields/validation.md)
- **The `Formatted` field formatter + how numbers are stored vs formatted for display** → [fields/formatter.md](fields/formatter.md)
- **Parser / validator / formatter services + line-type & format reference** → [api/services.md](api/services.md)

Key facts:
- Field formatter plugin id `telephone_advanced` (label "Formatted", field type `telephone`).
- Validation constraint id `TelephoneAdvanced` (validator `TelephoneAdvancedConstraintValidator`), attached to EVERY `telephone` field via `hook_field_info_alter`, but a no-op unless that field's third-party `enabled` flag is set.
- Field-item class override `Drupal\telephone_advanced\Plugin\Field\FieldType\TelephoneItem` — reformats the value to the storage format in `preSave()`.
- Services: `telephone_advanced.telephone_parser`, `telephone_advanced.telephone_validator`, `telephone_advanced.telephone_formatter`.
- Per-field config = `field_config` third-party settings, namespace `telephone_advanced`: `enabled`, `default_country`, `allowed_countries`, `allowed_types`, `storage_format`.
- Formatter settings: `format`, `link`. Format ids: E164=0, INTERNATIONAL=1, NATIONAL=2, RFC3966=3.
- Custom forms: add `#telephone_advanced` to a `tel` render element to validate/format it (`hook_element_info_alter`).
