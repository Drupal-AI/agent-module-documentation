<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Formatted telephone formatter

No admin page (`configure` is null). The formatter is enabled per field on the entity's
**Manage display** UI: **Structure → (entity type) → Manage display** → set a `telephone`
field's Format to **Formatted telephone**, then open the gear/settings.

Formatter id `telephone_formatter`, `field_types = {"telephone"}`. Settings are stored on the
display in `field.formatter.settings.telephone_formatter` (schema
`config/schema/telephone_formatter.schema.yml`) and export with `drush config:export`.

## Settings

| Key | Type | Default | Meaning |
|---|---|---|---|
| `format` | integer | `1` (International) | libphonenumber output format — see table below |
| `link` | boolean | `true` | Wrap the formatted number in a `tel:` link (href is the RFC3966 form) |
| `default_country` | string | `null` | ISO country code used to parse national/local numbers; `null` = none |

### `format` values (libphonenumber `PhoneNumberFormat`)

| Value | Name | Example |
|---|---|---|
| `0` | E164 | `+12025550136` |
| `1` | International (default) | `+1 202-555-0136` |
| `2` | National | `(202) 555-0136` |
| `3` | RFC3966 | `tel:+1-202-555-0136` |

## Behavior

- With `link = true`, output is a `#type => link` render element titled with the formatted
  number and a `tel:` URI (RFC3966); `#options['external'] = true`. Field-item
  `_attributes` are merged onto the link.
- With `link = false`, output is the formatted number as plain inline text.
- Parsing/validation failures (invalid number, missing country for a local number) are caught
  and the **raw stored value** is printed instead — the formatter never fatals.
- `default_country` is only needed when the field stores non-E.164 (local) numbers; the
  module suggests `drupal/telephone_validation` to keep data parseable. The settings summary
  lists Format, Link (Yes/No), and Default country when set.

## Set it with drush (no UI)

```bash
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd->getComponent("field_phone");
  $c["type"] = "telephone_formatter";
  $c["settings"] = ["format" => 1, "link" => TRUE, "default_country" => NULL];
  $vd->setComponent("field_phone", $c)->save();
'
```
