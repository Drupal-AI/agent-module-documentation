# Configure telephone validation

Validation is **opt-in per telephone field**. The module also stores site-wide defaults that
seed the core `tel` render element.

## Enable validation on a field (Field UI)

On any `telephone` field's settings form (`entity.field_config.*_field_edit_form`),
`hook_form_field_config_edit_form_alter()` injects a **Telephone validation** fieldset:

| Control | Stored as third-party setting | Notes |
|---|---|---|
| **Enabled** (checkbox) | presence of settings | Unchecking removes `format` + `country` third-party settings |
| **Format** (select) | `format` | `0` = E164, `2` = National (libphonenumber `PhoneNumberFormat`) |
| **Country** (select) | `country` (array) | Multi-select for E164; single country when format = National. Empty = all countries valid |

Third-party settings live under `field.field.*.*.*.third_party.telephone_validation`
(keys `format`, `country`) — see `config/schema/telephone_validation.schema.yml`.

- **E164**: the validator auto-discovers the country from the `+` country code. Country
  select is optional and multi-valued (restrict to an allow-list of regions).
- **National**: the number has no `+` prefix, so exactly one country must be chosen to supply
  the default region.

Set in code:

```php
$field // \Drupal\field\Entity\FieldConfig
  ->setThirdPartySetting('telephone_validation', 'format', 0)        // E164
  ->setThirdPartySetting('telephone_validation', 'country', ['US', 'CA'])
  ->save();
```

## Global defaults — `telephone_validation.settings`

Form route `telephone_validation.settings` at
`/admin/config/content/telephone_validation` (permission: `administer site configuration`;
menu link under **Content authoring**). Config object `telephone_validation.settings`:

| Key | Default | Meaning |
|---|---|---|
| `format` | `0` (E164) | Default validation format for the `tel` element |
| `country` | `[]` | Default allowed countries (empty = all) |

`hook_element_info_alter()` copies these onto the core `tel` element as
`#element_validate_settings` (`format`, `country`), so custom `tel` elements validate against
the site defaults unless overridden. Saving the form clears the element-info cache. Config
exports/deploys with `drush config:export`; `drush cset telephone_validation.settings format 2`
switches the default to National.
