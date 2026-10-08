# The `phone` field type

Class: `Drupal\phonenumber\Plugin\Field\FieldType\PhoneItem` (extends `FieldItemBase`).
Annotation: `default_widget = "phone_default"`, `default_formatter = "phone_international"`,
`constraints = { "Phone" = {} }`. `const MAX_LENGTH = 16`.

Add it like any field via Field UI ("Phone number" under the *General* field-type category),
`drush field:create`, or `FieldStorageConfig`/`FieldConfig`. No custom settings page — everything
is configured on the field's storage/settings/widget/formatter forms.

## Stored columns (`schema()`)

| Column | Type | Length | Notes |
|---|---|---|---|
| `phone_number` | varchar | 16 | International (E.164-style, digits only). Indexed (`value`). |
| `local_number` | varchar | 18 | National/local number as typed. |
| `country_code` | varchar | 3 | Dial code, e.g. `1`, `44`. |
| `country_iso2` | varchar | 2 | ISO alpha-2, e.g. `US`. |
| `extension` | varchar | 40 | Optional extension (default NULL). |

`isEmpty()` is true when `phone_number` is NULL/empty. `preSave()` clears
`phone_number`/`country_code`/`country_iso2` when the field is optional and `local_number` is
blank, so an emptied optional field stores nothing.

## Storage settings (`field.storage_settings.phone`)

| Key | Type | Default | Effect |
|---|---|---|---|
| `unique` | boolean | `FALSE` | When on, the `Phone` constraint rejects a `phone_number` already stored in that field on another entity (see [validation.md](validation.md)). |

Set via storage settings form ("Unique number"). Uniqueness is checked with an `entityQuery`
on `<field>.phone_number` (`accessCheck(TRUE)`), excluding the current entity id — see
`PhoneItem::isUnique()`.

## Field settings (`field.field_settings.phone`)

`defaultFieldSettings()`:

| Key | Default | Purpose |
|---|---|---|
| `strict_mode` | `TRUE` | Restrict input to digits + optional leading `+`, cap at max valid length (client-side). |
| `national_mode` | `TRUE` | Format/enter numbers nationally (no country code) vs. international. |
| `allowed` | `'all'` | `all` \| `include` \| `exclude` — country allow/deny mode. |
| `countries` | `[]` | ISO codes used with `include`/`exclude`. |
| `country_order` | `[]` | Manual ordering of the country list. |
| `geo_ip_lookup` | `'ipapi'` | GeoIP service key used when widget default country is `auto` (see [widget.md](widget.md)). |
| `api_key` | `''` | API key for GeoIP services that require signup (e.g. `ipgeolocation`). |
| `validation_number_type` | `'MOBILE'` | libphonenumber number type enforced (client-side). |
| `placeholder_number_type` | `'MOBILE'` | Number type used to build the example placeholder. |
| `auto_placeholder` | `'polite'` | intl-tel-input autoPlaceholder mode. |
| `custom_placeholder` | `''` | Fixed placeholder for all countries (blank = per-country samples). |
| `container_class` | `''` | Extra CSS classes on the widget wrapper div. |
| `extension_field` | `FALSE` | Collect an extension alongside the number. |
| `enabled_localisation` | `FALSE` | Enable localised country names. |
| `localized_countries` | `[]` | iso2 → localised name map. |

Number-type options come from `phonenumber_number_types()` (`FIXED_LINE`, `MOBILE`,
`FIXED_LINE_OR_MOBILE`, `TOLL_FREE`, `PREMIUM_RATE`, `SHARED_COST`, `VOIP`, `PERSONAL_NUMBER`,
`PAGER`, `UAN`, `VOICEMAIL`, `UNKNOWN`, plus empty = None). GeoIP options come from
`phonenumber_geo_ip_lookup_services()`.

Note: the config schema (`config/schema/phonenumber.schema.yml`) declares `localise_country` and
`i18n` keys, while the PHP defaults use `enabled_localisation`/`localized_countries`; the schema
also lists extra keys (`extension_field`, etc.). Trust the PHP defaults above for runtime behavior.

## Set field settings via PHP

```php
$field = \Drupal\field\Entity\FieldConfig::loadByName('node', 'article', 'field_phone');
$field->setSetting('allowed', 'include')
  ->setSetting('countries', ['US', 'GB', 'DE'])
  ->setSetting('extension_field', TRUE)
  ->save();

// Storage-level uniqueness:
$storage = \Drupal\field\Entity\FieldStorageConfig::loadByName('node', 'field_phone');
$storage->setSetting('unique', TRUE)->save();
```

## Item helper methods (public API on a loaded item)

`getPhoneNumber()` (returns the stored `phone_number` string), `getCountryIso2()`,
`getCountryCode()`, `getCountryName()` (resolved via core `country_manager`), `isUnique()`,
`isEmpty()`. `generateSampleValue()` produces a random 8–9 digit sample (dev/demo only).
