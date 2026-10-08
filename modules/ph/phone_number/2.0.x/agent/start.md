<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Phone Number — agent index

A validated international **phone_number field type** backed by
`giggsey/libphonenumber-for-php`. Depends on core `field`. No admin settings page
(`configure: null`) — configured per field. Submodule: **sms_phone_number** (SMS verify + TFA).

- **Add/configure a phone_number field: storage/field/widget/formatter settings** →
  [configure/field.md](configure/field.md)
- **The plugins it defines (field type, widget, formatters, constraint, form element)** →
  [plugins/plugins.md](plugins/plugins.md)
- **The `phone_number.util` service (parse/validate/format helpers)** →
  [api/util.md](api/util.md)

Key facts:
- Field type id **`phone_number`**; columns `value` (E.164), `country`, `local_number`,
  `extension`. Default widget `phone_number_default`; default formatter
  `phone_number_international`; validation constraint `PhoneNumber`.
- Field settings: `allowed_countries`, `allowed_types`, `extension_field`. Storage setting:
  `unique`. Widget settings: `default_country`, `country_selection`, `placeholder`, `phone_size`.
- Service **`phone_number.util`** (`PhoneNumberUtilInterface`) does all parsing/formatting.
