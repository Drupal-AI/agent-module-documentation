<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Phone Number — plugins it provides

The module does **not** define new plugin *types*; it provides implementations of core
field-plugin types (plus a Webform element). Use these ids in field/display config.

| Plugin | Kind | Id / class |
|---|---|---|
| Phone Number | Field type | `phone_number` — `Plugin/Field/FieldType/PhoneNumberItem` (default_widget `phone_number_default`, default_formatter `phone_number_international`, constraint `PhoneNumber`). |
| Phone Number widget | Field widget | `phone_number_default` — `Plugin/Field/FieldWidget/PhoneNumberWidget`. |
| International | Field formatter | `phone_number_international` — `Plugin/Field/FieldFormatter/PhoneNumberInternationalFormatter` (setting `as_link`). |
| Local | Field formatter | `phone_number_local` — `PhoneNumberLocalFormatter`. |
| Country | Field formatter | `phone_number_country` — `PhoneNumberCountryFormatter` (setting `type`). |
| PhoneNumber | Validation constraint | `Plugin/Validation/Constraint/PhoneNumberConstraint` + `PhoneNumberValidator` (uses libphonenumber; honours allowed countries/types). |
| phone_number | Form element (render element) | `Element/PhoneNumber` — the composite input the widget builds. |
| Phone Number | Webform element | `Plugin/WebformElement/PhoneNumber` (available when Webform is installed). |
| Phone Number | Feeds target | `Feeds/Target/PhoneNumber` (available when Feeds is installed). |

## Implementing on top

- **Reuse the field:** just add a `phone_number` field (see [../configure/field.md](../configure/field.md)).
- **Validate in code:** apply the `PhoneNumber` constraint or call the `phone_number.util`
  service (see [../api/util.md](../api/util.md)).
- **Custom widget/formatter:** subclass `PhoneNumberWidget` / a `PhoneNumber*Formatter` and
  register your own field-plugin — these are ordinary core plugin types, no module-specific
  plugin manager is involved.
- The `#type => 'phone_number'` render element can be used directly in custom forms; it expects
  `#phone_number` options (`allowed_countries`, `default_country`, `placeholder`, `phone_size`,
  `country_selection`, …).
