<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring a Phone Number field

There is **no module settings page** (`configure: null`). You configure everything per field on
the entity's *Manage fields* / *Manage form display* / *Manage display* screens, or in code.

## Add the field (code)

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;

FieldStorageConfig::create([
  'field_name' => 'field_phone',
  'entity_type' => 'node',
  'type' => 'phone_number',          // the field type id
  'settings' => ['unique' => 0],     // storage setting
])->save();

FieldConfig::create([
  'field_name' => 'field_phone',
  'entity_type' => 'node',
  'bundle' => 'article',
  'label' => 'Phone',
  'settings' => [
    'allowed_countries' => ['US', 'GB'],  // empty = all countries
    'allowed_types' => [],                // empty = all libphonenumber types
    'extension_field' => FALSE,
  ],
])->save();
```

## Settings reference (config schema)

**Storage** (`field.storage_settings.phone_number`)
- `unique` (int) — enforce uniqueness of the number across entities.

**Field** (`field.field_settings.phone_number`)
- `allowed_countries` (sequence of ISO codes) — restrict input to these countries; empty = all.
- `allowed_types` (sequence of ints) — restrict to `\libphonenumber\PhoneNumberType` constants;
  empty = all types.
- `extension_field` (bool) — show an extension input.

**Widget** `phone_number_default` (`field.widget.settings.phone_number_default`)
- `default_country` (string, default `US`)
- `country_selection` (string, default `flag`) — how the country is chosen (flag vs select).
- `placeholder` (string, default "Phone number")
- `phone_size` (int, default 15) — input size.

**Formatters**
- `phone_number_international` — E.164 international; setting `as_link` (bool) renders a `tel:`
  link.
- `phone_number_local` — local national format (same `as_link` setting).
- `phone_number_country` — shows the number's country; setting `type` (display type).

## Stored columns

`value` (E.164, ≤19), `country` (ISO, ≤3), `local_number` (≤15), `extension` (≤40). A field item
is empty when both `value` and `local_number` are empty.
