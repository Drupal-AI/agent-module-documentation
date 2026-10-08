# Month/Year form widgets

Two field widgets. Both reduce a core date select to year+month (or month+year, or year only) and
then, on submit, supply the day the editor never picked. They store nothing themselves — the value
goes into a core `datetime` or `daterange` field and is displayed by whatever core formatter is set.

| Widget id | For core field type | Class | Extends |
|---|---|---|---|
| `month_year_range` | `daterange` | `MonthYearRangeWidget` | `datetime_range`'s `DateRangeDatelistWidget` |
| `month_year_datetime` | `datetime` | `MonthYearDatetimeWidget` | `datetime`'s `DateTimeDatelistWidget` |

There is no field type and no formatter here — you attach these to an existing core Date / Date range
field on **Manage form display**. Neither widget appears in the option list unless the field is the
matching core type (a `datetime` field for `month_year_datetime`, a `daterange` field for
`month_year_range`).

## `month_year_range` (daterange)

`src/Plugin/Field/FieldWidget/MonthYearRangeWidget.php`. Builds on the parent's two `datelist`
elements (`value` and `end_value`), overriding each with `#type => datelist` and the computed
`#date_part_order`; the end date is forced `#required => FALSE`. In `massageFormValues()` each of the
start and end `DrupalDateTime` values has its day set (see `applyDayOption()` at
`MonthYearRangeWidget.php:194`) and is formatted by `formatDate()` (`:215`) to `Y-m-d` when the
field's `datetime_type` setting is `date`, otherwise `Y-m-d\TH:i:s`. Empty values are nulled.

| Setting | Default | Values | Effect |
|---|---|---|---|
| `date_order` | `YM` | `YM`, `MY`, `Y` | `#date_part_order`: `['year','month']`, `['month','year']`, or `['year']` (year only). |
| `year_range` | `''` (empty) | e.g. `0:+10`, `2000:2025`, `2025:+5` | When non-empty, sets `#date_year_range` on both selects; empty = no restriction. |
| `day_option_start` | `first` | `first`, `last` | Day assigned to the **start** value: 1st, or last day of the month (`format('t')`). |
| `day_option_end` | `last` | `first`, `last` | Day assigned to the **end** value: 1st, or last day of the month. |

Plus the inherited `DateRangeDatelistWidget` settings (e.g. `increment`, `date_order` for time parts)
which are irrelevant here since only year/month are shown.

## `month_year_datetime` (datetime)

`src/Plugin/Field/FieldWidget/MonthYearDatetimeWidget.php`. Deliberately does **not** call
`parent::formElement()` (comment on `:38`: it bypasses the parent to avoid a match error) — it builds
one `datelist` element itself, seeds `#default_value` from the stored value if it parses, and sets
`#date_part_order` from `date_order`. `massageFormValues()` (`:160`) sets the day per `day_option`
and formats to `Y-m-d` / `Y-m-d\TH:i:s` based on the field's `datetime_type`.

| Setting | Default | Values | Effect |
|---|---|---|---|
| `date_order` | `YM` | `YM`, `MY`, `Y` | Same `#date_part_order` mapping as above. |
| `year_range` | `''` (empty) | e.g. `0:+10`, `2000:2025`, `2025:+5` | When non-empty, sets `#date_year_range`; empty = no restriction. |
| `day_option` | `first` | `first`, `last` | Day assigned to the single value: 1st, or last day of the month. |

Plus the inherited `DateTimeDatelistWidget` settings.

## Setting a widget from code

```php
\Drupal::service('entity_display.repository')
  ->getFormDisplay('node', 'article', 'default')
  ->setComponent('field_period', [
    'type' => 'month_year_range',              // or 'month_year_datetime'
    'settings' => [
      'date_order' => 'YM',
      'year_range' => '2000:+5',
      'day_option_start' => 'first',
      'day_option_end' => 'last',
    ],
  ])->save();
```

## Notes / gotchas

- **No config schema ships.** The custom settings above are written to the entity form display
  config but have no `field.widget.settings.month_year_range` (or `_datetime`) schema, so
  `drush config:inspect` / strict-schema checks will report them as unknown; they still work.
- The day the editor did not choose is invented on save (1st or last of month) exactly like a full
  date field would store — the granularity limit is in the widget, not in storage. Downstream sorts,
  Views filters and formatters see a normal `Y-m-d` date.
- `year_range` is passed straight through to core's `#date_year_range`, so it accepts the same
  absolute (`2000:2025`) and relative (`-5:+5`, `2025:+5`, `0:+10`) syntax core supports.
