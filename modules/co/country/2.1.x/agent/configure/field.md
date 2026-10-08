<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `country` field — widgets, formatters, settings

Field type: `\Drupal\country\Plugin\Field\FieldType\CountryItem`, **id `country`**.
Single property `value` = ISO 3166 alpha-2 code, DB column `value` VARCHAR(2)
(`COUNTRY_ISO_MAXLENGTH = 2`). `default_widget = country_default`,
`default_formatter = country_default`. There is no config UI page — use Field UI.

## Add the field (config or Field UI)

Manage fields → Add field → "Country". Or in config:

```yaml
# field.storage.node.field_country.yml
type: country
settings:
  selectable_countries: {  }   # empty = all countries
# field.field.node.article.field_country.yml
field_type: country
settings:
  selectable_countries: [US, GB, FR]   # restrict choices (optional)
```

## `selectable_countries` setting

Present on **both** storage and field settings (schema
`field.storage_settings.country` / `field.field_settings.country`): a sequence of ISO codes.
Empty = offer every country. The effective list is resolved by the
`country.field.manager` service (see [../api/api.md](../api/api.md)).

## Widgets

| Widget id | Class | Notes |
|---|---|---|
| `country_default` | `CountryDefaultWidget` | Select dropdown (default). |
| `country_autocomplete` | `CountryAutocompleteWidget` | Text field with autocomplete via route `country.autocomplete`. Settings: `size`, `placeholder`, `autocomplete_route_name`. |

## Formatters

| Formatter id | Class | Output |
|---|---|---|
| `country_default` | `CountryDefaultFormatter` | Localized **country name** (default). |
| `country_iso_code` | `CountryCodeFormatter` | Raw **ISO code** (e.g. `US`). |

Set them on Manage form display / Manage display, or in the
`core.entity_form_display.*` / `core.entity_view_display.*` component `type`.
