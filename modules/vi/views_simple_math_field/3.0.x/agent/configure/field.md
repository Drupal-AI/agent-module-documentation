<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Add & configure the Simple Math Field in a view

There is **no configure route**. Everything is set on the field inside a view.

## Add the field (UI)

1. Edit a view and click **Add** next to *Fields*.
2. Add the other numeric fields you want to use first (they must exist in the view to appear as
   formula inputs).
3. Add **Global: Simple Math Field** (search "Simple Math Field").
4. In its settings:
   - **Select the fields to use in the formula** — tick each field to feed in. Each ticked field
     shows its **formula token**, e.g. `@field_price`, `@nid`, `@counter` (the token equals the
     Views field id/alias).
   - **Formula** — write the expression using those tokens, e.g.
     `(@field_price + @field_tax) / @field_qty`. Evaluated by the `andileco/eval-math` library
     (supports `+ - * / ^`, parentheses, functions like `abs`, `sqrt`, etc.).
   - **Mute database logs for this field** — tick to suppress the watchdog entry that a
     `DivisionByZeroException` would otherwise log (useful when zeros are expected).
5. **Apply** and **Save** the view.

## Where it is stored (view config)

Under the display's field options
(`views.view.<view>.display.<display>.display_options.fields.<field_id>`):

```yaml
field_views_simple_math_field:
  id: field_views_simple_math_field
  table: views_simple_math_field
  field: field_views_simple_math_field
  plugin_id: field_views_simple_math_field
  fieldset_one:
    data_field:              # which fields feed the formula (keyed by field id)
      field_price: field_price
      field_tax: field_tax
    formula: '(@field_price + @field_tax) / @field_qty'
  mute_logs: 1
```

To add several math columns, add the field again — extra instances get ids like
`field_views_simple_math_field_1`.

## Formula / token rules

- Reference a field by `@<field_id>`. The id is what Views shows beside the checkbox (e.g.
  `@field_price`, or `@field_price_1` for a second instance of the same field).
- Each input value is coerced to a float; thousands separators are stripped. Missing values
  default to `0`.
- Values can come from relationship-referenced entities, rewritten/aliased fields, and Commerce
  price fields — all handled by `SimpleMathField::getFieldValue()`.

## Sorting by the computed value

Add a **Sort criteria** → **Global: Simple Math Fields** (`views_simple_math_field_sort`), then
pick which Simple Math Field to sort by (the `simple` option) and ASC/DESC. Because the value is
computed in PHP, the sort runs in `postExecute()` via `usort` on the result set — do not use it
together with a rewritten field that needs advanced rendering (the module warns about this).

## Notes

- The value is **not** a database column: `query()` is a no-op; the handler computes per row in
  `getValue()`. Aggregation/group-by is disabled (`usesGroupBy()` returns FALSE).
- Config schema is provided at `config/schema/views_simple_math_field.views.schema.yml`
  (`views.field.field_views_simple_math_field`, `views.sort.views_simple_math_field_sort`).
- Requires the `andileco/eval-math` Composer library (already pulled in by the module's
  `composer.json`).
