# Adding & configuring the three filters

The module adds nothing to configure globally. You work entirely inside a **View**: add
one of its filters, then set the target field's machine name in the filter's options. All
three attach to the `node_field_data` table, group **"Custom View Filters"**.

## The handlers (from `hook_views_data_alter`)

| Views field key | Filter handler id (`plugin_id`) | Class | Purpose |
|---|---|---|---|
| `custom_az_filter` | `custom_az_filter` | `CustomAzFilter` | Match first letter of first/second word of a text field |
| `nodes_granular_dates` | `node_granular_date_filter` | `NodeGranularDateFilter` | Filter by year and/or month of a date field |
| `date_range_picker` | `date_range_picker_filter` | `DateRangePickerFilter` | Filter between a "since" and "until" date |

In the Views UI these appear under **Add filter → group "Custom View Filters"**. In the
saved View config, the filter handler carries `plugin_id`, `table: node_field_data`, the
`field` key above, and the options below.

## Custom AZ filter (`custom_az_filter`)

Options (`defineOptions`):
- `az_field_name` (**required**) — machine name of the text field, e.g. `field_fullname`,
  or the special value `title`. Non-`title` fields are matched on `node__<field>.<field>_value`.
- `operator` — `first_word_check` (default) matches the first letter of the **first** word;
  `second_word_check` matches the first letter of the **second** word (`LIKE '% X%'`).
- Admin (non-exposed): `az_letter` — one or more letters chosen in the View UI.
- Exposed: rendered as `radios` (single) or `checkboxes` when the exposed option
  "Allow multiple selections" is on; the control is keyed by the exposed **identifier**.

## Node granular date filter (`node_granular_date_filter`)

Options:
- `granular_field_name` (**required**) — date field machine name, or special `created` /
  `changed` (matched against the `node_field_data` unix timestamp column).
- `granular_year_from` (default `2000`) and `granular_year_until` (default current year + 1)
  — bound the exposed **Year** dropdown.
- Admin: `node_year`, `node_month`. Exposed: two selects (`exposed_year`, `exposed_month`),
  each defaulting to `All`. Year-only, month-only, and year+month combinations are all
  supported; month-only uses a `DATE_FORMAT`/`FROM_UNIXTIME` month expression.

## Date range picker filter (`date_range_picker_filter`)

Options:
- `granular_field_name` (**required**) — date field machine name, or special `created` /
  `changed`.
- Admin: `node_from_date`, `node_to_date` (HTML5 `date` inputs). Exposed: `exposed_from_date`
  ("Since") and `exposed_to_date` ("Until"); an empty bound is simply omitted from the query.

## Exposed use & printing in Twig

Each filter builds its exposed widgets in `buildExposedForm()` and stitches them back into the
real filter value via `acceptExposedInput()`, so the control is a normal exposed-form element
keyed by the filter's **exposed identifier**. That lets you render it directly in a Views
template instead of the default exposed-form block:

```twig
{{ form.custom_az_filter }}
{{ form.nodes_granular_dates }}
{{ form.date_range_picker }}
```

(The token matches whatever exposed **identifier** you set; the defaults are the field keys
above.) None of the filters support Views "grouped filters" (`canBuildGroup()` returns FALSE).
