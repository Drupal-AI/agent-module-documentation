# Display formatters

The `phone` field type ships three formatters. `phone_international` is the default. Output is
rendered through `#plain_text` or a Drupal `#type => link` render element.

| Formatter id | Class | Applies to | Shows |
|---|---|---|---|
| `phone_international` | `PhoneInternationalFormatter` | `phone`, `telephone` | `+<dial> <national>` |
| `phone_national` | `PhoneNationalFormatter` | `phone`, `telephone` | `0<national>` |
| `phone_country` | `PhoneCountryFormatter` | `phone` | Country name / code / ISO |

`PhoneNationalFormatter` extends `PhoneInternationalFormatter` and only overrides
`$phoneDisplayFormat = 'national'`.

## `phone_international` / `phone_national`

Settings (`field.formatter.settings.phone_international`, and `phone_national` inherits it):

| Setting | Type | Default | Effect |
|---|---|---|---|
| `link` | boolean | `FALSE` | Render as a `tel:` link instead of plain text. |
| `title` | string | `''` | Replacement link text (only when `link` is on). |

Behavior (`viewElements()`): items with an empty `phone_number` **or** empty `local_number` are
skipped. In `national` mode the output is `0` + local number (a `-` is inserted after the first
digit when the local number is ≤ 5 chars); otherwise `+<country_code> <local_number>`. When `link`
is on it emits `#type => link` to `Url::fromUri('tel:' . $phone_number)` with the title or the
formatted number; otherwise `#plain_text`. Any field-item `_attributes` are merged onto the link.

## `phone_country`

Class `PhoneCountryFormatter` (injects core `country_manager`). Setting
`field.formatter.settings.phone_country`:

| Setting | Default | Renders |
|---|---|---|
| `type = 'name'` | default | Country name (from `country_manager`, case-matched to the list keys). |
| `type = 'code'` | | Dial code (`country_code`). |
| `type = 'iso2'` | | ISO alpha-2 (`country_iso2`). |

Items with empty `country_code` or `country_iso2` are skipped. Output uses `#plain_text`.

## Notes

- `phonenumber_field_formatter_info_alter()` also registers core's `string` formatter for the
  `phone` field type, so a plain-string display is available too.
- Set a formatter with `EntityViewDisplay::setComponent('field_phone', ['type' => 'phone_national', 'settings' => ['link' => TRUE]])`.
