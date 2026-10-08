<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Simple Math Field adds a "Global: Simple Math Field" Views field handler that computes a value from a formula referencing other fields in the same view (e.g. `(@field_a + @field_b) / @field_c`), plus a matching sort handler.

---

The module registers, via `hook_views_data()`, a `#global` table `views_simple_math_field` exposing the field `field_views_simple_math_field` (handler `SimpleMathField`, extends core `NumericField`) and a sort `views_simple_math_field_sort`. In the field's Views settings you tick the other view fields to feed into the formula and write the formula in a textarea, referencing each chosen field by a token `@<field_id>` (the token is shown next to each field's checkbox). At render time `getValue()` reads each selected field's row value (handling relationships, rewritten/aliased fields, and Commerce price fields), sanitises it to a float, substitutes the tokens, and evaluates the expression with the `andileco/eval-math` (`EvalMath`) library. A "Mute database logs for this field" checkbox (`mute_logs`) suppresses the logger entry that a `DivisionByZeroException` would otherwise write. The sort handler sorts rows by a chosen Simple Math Field's computed value in PHP (`postExecute`), since the value is not a real database column. There is no admin settings page (`configure` null); all configuration is per-field inside a view. Requires core `views` and the external `andileco/eval-math` library.

---

- Show a computed subtotal in a view by multiplying a quantity field by a price field.
- Display a percentage column, e.g. `(@field_completed / @field_total) * 100`.
- Calculate a per-unit cost by dividing a total field by a count field in a report view.
- Sum several numeric fields into a single "score" column without writing a custom handler.
- Add a difference/delta column between two date-derived numeric fields.
- Feed a computed value into the Charts module instead of a Twig field rewrite.
- Compute a running margin from Commerce price fields (default, calculated, plain, order total).
- Divide safely and mute the division-by-zero log noise when some rows legitimately contain zero.
- Provide a derived metric column for a dashboard-style view.
- Sort a view by a calculated field value using the module's Simple Math Field sort handler.
- Rank rows by a computed ratio (e.g. highest revenue-per-order first).
- Build a "weighted score" column combining several rated fields with coefficients.
- Convert units in a view, e.g. multiply a metres field by a constant to show feet.
- Chain multiple Simple Math Fields, using an earlier computed field as input to a later one.
- Add a tax-inclusive price column derived from a net price and a tax-rate field.
- Present an average across two or more fields per row.
- Show remaining budget as `@field_budget - @field_spent`.
- Compute values from fields pulled in through a view relationship (referenced entity fields).
- Use a rewritten/aliased view field's numeric output inside a formula.
- Keep computation in PHP for accuracy where Twig math would be awkward or imprecise.
- Avoid a custom Views field plugin for simple arithmetic over existing fields.
- Deploy the calculation as part of the view configuration (portable, no code).
- Give site builders a no-code way to add arithmetic columns to any view.
- Produce a normalized 0–1 or 0–100 value for progress bars rendered from a view.
