<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Calculation Fields adds spreadsheet-style form elements that evaluate a math expression (e.g. `:quantity * :unit_price`) over the values of other fields and show the result. It provides two Form API render elements — `form_calculation_element` (a readonly number input) and `form_calculation_markup` (HTML output) — and, via the `webform_calculation_fields` submodule, the same two as Webform elements so site builders can build live calculators without code.

---

The expression is authored by a developer (in a Form API render array) or by a webform builder (in the element's config UI), never by the end user. Referenced fields are written as their machine name prefixed with a colon; an optional default value until the field is populated is appended with a pipe, e.g. `:discount|0` (use `|1` for a divisor/multiplier). As the user changes the referenced inputs, the result is computed live in the browser by the bundled math.js library (loaded from cdnjs); math.js `^` power syntax is supported. On submit the value is not trusted from the client: the server re-evaluates the expression with `symfony/expression-language` (a sandboxed tokenizing expression evaluator — not `eval()`), after validating that every referenced field value is numeric, and overwrites the submitted value with the authoritative result. `form_calculation_element` submits its numeric result as the field value; `form_calculation_markup` renders the result inside `{{ }}` in surrounding HTML and is display-only (its value is not meant to be stored). Options include `#evaluation_decimals` (rounding), an input mask (none / numeric / currency) and a currency symbol. A `restrict access` permission, "Administer calculation_fields configuration", gates editing/deleting the number calculation element in the Webform UI. The base module needs no configuration; enable `webform_calculation_fields` for the webform integration, and the `*_example` / `*_examples` submodules for ready-made demos.

---

- Order form: compute line total as `:quantity * :unit_price` and show it live as the user types.
- Cart-style subtotal, tax and grand total across several number inputs, e.g. `(:subtotal + :shipping) * :tax_rate`.
- BMI calculator: `:weight / (:height * :height)` on a health-assessment form.
- Loan repayment estimator: `(:loan_amount * :interest_rate * (1 + :interest_rate) ^ :loan_term) / ((1 + :interest_rate) ^ :loan_term - 1)`.
- Discount pricing: `:price - (:price * :discount|0 / 100)` with a default of 0% until entered.
- Event registration cost: `:attendees * :ticket_price + :add_on_fee|0`.
- Donation form that totals a base amount plus an optional tip percentage.
- Quote/estimate builder that sums several optional service line items using `|0` defaults.
- Currency-formatted total using the numeric/currency input mask and a currency symbol.
- Percentage or ratio fields, e.g. conversion rate `:conversions / :visitors * 100`.
- Multi-page webform wizard where a later page shows a total calculated from earlier pages (the module carries "deep" field values across steps).
- Display-only summary markup on a webform, e.g. `<h3>Total: {{ :a + :b }}</h3>`, using the Calculation Markup element.
- Area/volume calculators for product configurators (`:length * :width`, `:length * :width * :height`).
- Nutrition or fitness forms summing macro/calorie inputs.
- Invoice line calculations combining quantity, unit price and a tax multiplier.
- Rounding results to a fixed number of decimals for money display via `#evaluation_decimals`.
- Providing a developer-facing computed field in a custom Form API form without writing evaluation logic.
- Salary/hourly-rate estimators (`:hours * :rate`).
- Shipping cost estimation combining weight and per-unit rate.
- Score/grade totals on quiz-like custom forms.
- Any form needing a read-only field whose value derives from other fields and must stay authoritative on the server.
