<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EDTF date field (`edtf`)

Stores a Library of Congress **Extended Date/Time Format** string (2018 spec / ISO 8601-2019).
Useful for archival dates that are uncertain, approximate, partial, open-ended, or seasonal — things
a normal date field cannot express (`1984?`, `19XX`, `1900-02/1901`, `2020-21` = Spring 2020).

- Field type class: `Drupal\controlled_access_terms\Plugin\Field\FieldType\ExtendedDateTimeFormat`
  (id `edtf`). Extends core `StringItem`; storage is a plain string column, `field.storage_settings.edtf`
  inherits `field.storage_settings.string`.
- Default widget `edtf_default`, default formatter `edtf_default`.
- Field-type constraint `EDTF` runs on every save (see below).

## Widget: `edtf_default`

Class `Plugin\Field\FieldWidget\EDTFWidget`. A single textfield with an `#element_validate` callback
that calls `EDTFUtils::validate()`. An empty value is accepted (stored as `''`).

Widget settings (`field.widget.settings.edtf_default`, extends `text_edtf`):

| Setting | Default | Effect |
|---|---|---|
| `strict_dates` | `false` | Require real calendar dates; rejects most level-1/2 features and extended years |
| `intervals` | `true` | Permit `begin/end` intervals (e.g. `1900/1950`, `../1950`, `1900/..`) |
| `sets` | `false` | Permit one-of `[..]` / all-of `{..}` sets (maintainer suggests a repeatable field instead) |

Note: widget validation only runs on form submits. Values written via Migrate API or REST bypass it;
set `validate: true` in a migration `destination` for coarse EDTF validation, and the field-type
`EDTF` constraint still applies on entity validation.

## Constraint: `EDTF`

`Plugin\Validation\Constraint\EDTF` + `EDTFValidator` validate each value with
`EDTFUtils::validate($val, TRUE, TRUE, FALSE)` (intervals + sets allowed, non-strict) and add a
violation `"%value is not valid EDTF: %verbose"` per parse error.

## Formatter: `edtf_default`

Class `Plugin\Field\FieldFormatter\EDTFFormatter` (label "Default EDTF formatter", level-1 support).
Parses the stored string with `EDTFUtils::DATE_PARSE_REGEX` and re-renders it human-readably; output is
built entirely with `t()` placeholders (auto-escaped). Handles intervals ("… to …", "open start/open
end"), sets ("one of the dates:" / "all of the dates:"), unspecified digits (`X` → "unknown year in
the decade of the 1900s"), seasons/sub-year groupings, and uncertainty/approximation qualifiers
(`?`, `~`, `%` → "(year uncertain; month approximate)").

Formatter settings (`field.formatter.settings.edtf_default`, extends `text_edtf_human`):

| Setting | Options | Default |
|---|---|---|
| `date_separator` | `dash` `stroke` `period` `space` | `dash` |
| `date_order` | `big_endian` (Y-M-D), `little_endian` (D-M-Y), `middle_endian` (M-D-Y) | `big_endian` |
| `year_format` | `ny` (hide), `yy` (2-digit), `y` (4-digit) | `y` |
| `month_format` | `nm`, `mm`, `m`, `mmm` (Apr), `mmmm` (April) | `mm` |
| `day_format` | `nd`, `dd`, `d` | `dd` |

`middle_endian` + `space` separator + spelled-out month triggers the verbose prose branch
("January 1, 1999", "3rd day of an unknown month, in 1999").

## Set a field's widget/formatter settings (PHP)

```php
$fd = \Drupal::service('entity_display.repository');
$fd->getFormDisplay('taxonomy_term', 'person')
  ->setComponent('field_birth_date', [
    'type' => 'edtf_default',
    'settings' => ['strict_dates' => FALSE, 'intervals' => TRUE, 'sets' => FALSE],
  ])->save();
$fd->getViewDisplay('taxonomy_term', 'person')
  ->setComponent('field_birth_date', [
    'type' => 'edtf_default',
    'settings' => ['date_separator' => 'dash', 'date_order' => 'big_endian', 'month_format' => 'mmmm'],
  ])->save();
```

Legacy `text_edtf` widget and `text_edtf_human` / `text_edtf_iso8601` display ids are migrated to
`edtf_default` by `hook_update_8002`; `hook_update_8003` rewrites stored strings from the 2012 draft
to the 2018 spec (`open`→`..`, `y`→`Y`, `u`→`X`, `?~`/`~?`→`%`).

See also [api/edtf-utils.md](../api/edtf-utils.md) for programmatic parsing/conversion.
