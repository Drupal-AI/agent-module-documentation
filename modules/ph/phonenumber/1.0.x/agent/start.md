<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PhoneNumber (phonenumber) — agent index

Defines a `phone` field type for international phone numbers, backed by
`giggsey/libphonenumber-for-php ~8.0`. Stores the number in five parts (international
number, local number, dial code, ISO alpha-2, extension), ships an intl-tel-input–style
JS widget with a country dropdown/flags, three display formatters, and a server-side
`Phone` validation constraint. Depends only on core `field`. Core: `^8.8 || ^9 || ^10 || ^11`.
Latest release is **1.0.0-beta1** (no stable release exists yet).

- **No settings page** (`configure` is null). All configuration is per field via Field UI
  (field settings, widget settings, formatter settings).
- No permissions, no drush commands, no new plugin managers. Provides config schema.
- Also registers a `phone` Feeds target and a `phone` Webform composite element when those
  modules are present.

Solution docs:
- **Add / configure the phone field type, storage & field settings** → [fields/field-type.md](fields/field-type.md)
- **Configure the entry widget (country dropdown, geo-IP, mask, placeholders)** → [fields/widget.md](fields/widget.md)
- **Choose a display formatter (international / national / country)** → [fields/formatters.md](fields/formatters.md)
- **Understand server-side validation (validity, allowed country, uniqueness)** → [fields/validation.md](fields/validation.md)
- **Integrate via Feeds target, Webform element, or the `phone` form element** → [api/integrations.md](api/integrations.md)
- **Add a GeoIP lookup service / react to the alter hooks** → [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Field type id: `phone`; default widget: `phone_default`; default formatter: `phone_international`.
- Formatter ids: `phone_international`, `phone_national`, `phone_country`.
- Field-type class: `Drupal\phonenumber\Plugin\Field\FieldType\PhoneItem` (`MAX_LENGTH = 16`).
- Storage columns: `phone_number`, `local_number`, `country_code`, `country_iso2`, `extension`; index on `phone_number`.
- Constraint id `Phone` → `PhoneConstraintValidator`; form element `#type => phone` (`Drupal\phonenumber\Element\Phone`).
- Config schema keys: `field.storage_settings.phone` (`unique`), `field.field_settings.phone`,
  `field.widget.settings.phone_default`, `field.formatter.settings.phone_international|phone_national|phone_country`.
- Libraries: `phonenumber/phone`, `phonenumber/phonenumber`, `phonenumber/phonenumber.formatter`, `phonenumber/phonenumber.phone-icon`.
- Helper functions in `phonenumber.module`: `phonenumber_geo_ip_lookup_services()`, `phonenumber_number_types()`.
- Submodules (each has its own docs): `phonenumber_validation` (libphonenumber-based
  format/country/type validation, adds a `phonenumber_validation.settings` config route and
  a `PhoneValidation` widget), `phonenumber_verification` (SMS ownership-verification flow,
  a `phone_verified` formatter, TFA integration; requires an SMS gateway such as SMS Framework).
