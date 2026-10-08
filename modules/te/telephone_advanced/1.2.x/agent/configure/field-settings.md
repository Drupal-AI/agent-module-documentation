# Per-field settings (Telephone Advanced)

There is **no module settings page** (`configure` is null). All configuration lives as
**third-party settings on each telephone field instance** (`field_config` entity), under the
`telephone_advanced` namespace. The module injects an "Advanced settings" fieldset into the
field-config edit form (Manage fields → the telephone field → its settings) via
`telephone_advanced_form_field_config_edit_form_alter()` (only when the field type is
`telephone`).

## Settings

| Third-party key | Form control | Meaning |
|---|---|---|
| `enabled` | checkbox "Enabled" | Master switch. When off, all advanced behavior (constraint, formatter applicability, storage reformatting) is skipped and the other keys are unset on save. |
| `default_country` | select (ISO 3166 alpha-2) | Region used to parse numbers entered without a `+` country code. Optional but recommended. |
| `allowed_countries` | multi-select | If non-empty, the number's detected region must be one of these. Empty = any country. |
| `allowed_types` | multi-select | If non-empty, the number's libphonenumber line type must be one of these (stored as int enum values). Empty = any type. See [api/services.md](../api/services.md) for the type list. |
| `storage_format` | select | If set, the value is reformatted to this format on save (see [fields/formatter.md](../fields/formatter.md)). Empty = store as entered. Ids: E164=0, INTERNATIONAL=1, NATIONAL=2, RFC3966=3. |

## Form validation rules (`telephone_advanced_form_field_config_edit_form_validate`)

- If `default_country` is set and `allowed_countries` is non-empty, the default must be one of the allowed countries.
- `storage_format = NATIONAL (2)` is rejected when more than one country is allowed (national format is ambiguous across countries).

## Set via PHP / drush

```php
$field = \Drupal\field\Entity\FieldConfig::loadByName('node', 'contact', 'field_phone');
$field->setThirdPartySetting('telephone_advanced', 'enabled', TRUE);
$field->setThirdPartySetting('telephone_advanced', 'default_country', 'BE');
$field->setThirdPartySetting('telephone_advanced', 'allowed_countries', ['BE', 'NL']);
// Line types are libphonenumber PhoneNumberType enum ints:
$field->setThirdPartySetting('telephone_advanced', 'allowed_types', [\libphonenumber\PhoneNumberType::MOBILE->value]);
$field->setThirdPartySetting('telephone_advanced', 'storage_format', \libphonenumber\PhoneNumberFormat::E164->value); // 0
$field->save();
```

(On 8.12.x where the constants are plain ints, use `\libphonenumber\PhoneNumberType::MOBILE` / `\libphonenumber\PhoneNumberFormat::E164` without `->value`.)

Run with `drush php:eval` / `drush scr`. There are no drush commands of the module's own.

## Config schema

Defined in `config/schema/telephone_advanced.schema.yml`:

- `field.field.*.*.*.third_party.telephone_advanced` — mapping: `enabled` (bool), `default_country` (string, nullable), `allowed_countries` (sequence of string), `allowed_types` (sequence of int), `storage_format`.
- `field.formatter.settings.telephone_advanced` — mapping: `format` (string), `link` (bool).

Note: the schema declares `storage_format` as `bool`, but the value actually stored is an
integer format id (0–3) or null. This is a schema-label inaccuracy, not a behavioral bug;
the 1.2.1 release fixed a related `UnsupportedDataTypeConfigException` in the formatter.
