<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Using the filter in a View

There is no admin config for this module. It attaches itself and you select an operator in
the Views UI (or in config).

## How it attaches

`views_daterange_filters_field_views_data_alter()` (in `views_daterange_filters.module`)
runs for every field storage. When the field type is `daterange` or `date_recur`, it walks
the field's Views data and, for each column key that does **not** end in `_end_value`, sets
`filter.id = 'views_daterange_filters_daterange'`. So the start column of a daterange field
gets the enhanced filter automatically; the `_end_value` column keeps core's filter.

Result: in *Add filter criteria* the daterange field's date filter now offers the extra
operators (Includes, Includes (Unbound), Includes (Unbound Indexed), Overlaps, Ends by,
Not ended) alongside the core ones.

## Config shape

A daterange filter using this plugin looks like this inside a
`views.view.<id>` display's `display_options.filters` (start column
`field_when_value`, derived end column `field_when_end_value`):

```yaml
field_when_value:
  id: field_when_value
  table: node__field_when
  field: field_when_value
  plugin_id: views_daterange_filters_daterange
  operator: includes          # or overlaps / ends_by / not_ended / includes_unbound / includes_unbound_indexed
  value:
    value: ''                 # single-value operators use value.value
    # overlaps uses value.min and value.max instead
  exposed: true               # optional
  expose:
    operator_id: field_when_value_op
    identifier: field_when_value
```

- `plugin_id` **must** be `views_daterange_filters_daterange` for the operators to exist.
  Adding the daterange field as a filter through the UI sets this for you (via the hook);
  when writing config by hand, set it explicitly.
- Single-value operators (`includes`, `includes_unbound`, `includes_unbound_indexed`,
  `ends_by`, `not_ended`) read `value.value`. `overlaps` reads `value.min` and `value.max`.
- The field must be a real `daterange` (or `date_recur`) field with both a `_value` and
  `_end_value` storage column; the plugin derives the end column name from the start column.
- Config schema is `views.filter.views_daterange_filters_daterange` /
  `views.filter_value.views_daterange_filters_daterange` (both alias core `views_filter` /
  `views.filter_value.date`).
