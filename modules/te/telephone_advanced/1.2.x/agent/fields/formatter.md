# Formatter & field-type override (how numbers are stored / displayed)

This module does **not** define a new field type or widget. It reuses core's `telephone`
field type and its default widget, and adds one display formatter plus a storage hook.

## The `Formatted` formatter

- Class: `Drupal\telephone_advanced\Plugin\Field\FieldFormatter\TelephoneAdvancedFormatter` (id `telephone_advanced`, label "Formatted", field type `telephone`).
- Service used: `telephone_advanced.telephone_formatter`.
- `isApplicable()` returns TRUE only when the field has `telephone_advanced.enabled` set — so "Formatted" appears in the Manage display options only for advanced-enabled telephone fields.

### Settings (`field.formatter.settings.telephone_advanced`)

| Setting | Type | Default | Meaning |
|---|---|---|---|
| `format` | select | `NATIONAL` (2) | Output format: National, International, E164, RFC 3966. |
| `link` | checkbox | TRUE | Wrap the number in a `tel:` link. |

### Display logic (`viewElements()`)

For each item, the value is formatted to `format` for the visible text. If `link` is on:

- When `format` is not E164, the link target is separately computed in **E164** (`tel:+…`), while the visible text stays in the chosen format.
- When `format` is E164, text and link target are the same E164 string.
- Output is a core `link` render element: `#title` = formatted text, `#url` = `Url::fromUri('tel:' . $e164)`.

If libphonenumber cannot parse the stored value (`NumberParseException`), it falls back to
rendering the raw stored value as `#markup` with **no** link.

## Storage reformatting (field-item override)

`hook_field_info_alter()` sets the telephone field-item class to
`Drupal\telephone_advanced\Plugin\Field\FieldType\TelephoneItem` (extends core's
`TelephoneItem`). Its `preSave()`:

- No-ops unless the field is `enabled` and a `storage_format` is configured.
- Otherwise reformats the value to `storage_format` (using `default_country` to parse) via
  `telephone_advanced.telephone_formatter` before the value hits the database.

So the **stored** string is controlled by the field's `storage_format` setting, while the
**displayed** string is controlled independently by the formatter's `format` setting. Common
setup: store E164 (canonical, comparable) and display National.
