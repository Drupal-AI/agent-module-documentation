<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Submodules

## webform_calculation_fields (the main integration)

Depends on `calculation_fields` and `webform`. Exposes the two render elements as Webform elements in the "Calculation elements" category so site builders can add live calculators to a webform without code:

- **Calculation Field** — `src/Plugin/WebformElement/WebformCalculationNumber.php` (`@WebformElement id = "form_calculation_element"`), extends Webform's `Number`. Config form adds: `evaluation_fields` (the Math Expression, required textarea), `evaluation_decimals`, `evaluation_fields_mask` (none/numeric/currency), `currency_symbol`.
- **Calculation Markup** — `src/Plugin/WebformElement/WebformCalculationMarkup.php` (`@WebformElement id = "form_calculation_markup"`), extends Webform's `TextField`. The expression is authored in a `webform_html_editor` field as HTML with the expression inside `{{ }}`.

Config validation (`validateConfigurationForm()` on both plugins): every `:field` referenced must exist on the webform, and a non-required referenced field must supply a `|default`. `WebformCalculationNumber` also enforces that referenced fields are written with the leading colon.

Access control:
- `calculation_fields.permissions.yml` defines the restricted permission **"Administer calculation_fields configuration"** (`administer calculation_fields configuration`).
- `src/Routing/WebformCalculationFieldsRouting.php` (event subscriber) overrides the Webform UI element **edit** and **delete** routes with `WebformCalculationFieldsForm` / `WebformCalculationFieldsFormDelete`.
- `src/Form/WebformCalculationFieldsElementUiAccess.php` (trait) blocks the edit/delete form for elements of type `form_calculation_element` unless the user holds that permission (renders a "no access" markup instead).

The formula-evaluation mechanism is exactly the same as the render elements: live math.js in the browser, authoritative `symfony/expression-language` re-evaluation on submit (see `agent/fields/elements.md`).

## calculation_fields_example

Demo module (depends on `calculation_fields` only). Ships example custom forms — `CalculationFieldsExample`, `CalculationFieldsMaskSettingsExample`, `QuantityField1/2`, and a `MultipleFormsAtSamePageController` — showing the render elements in plain Form API forms (quantity/price, masks, multiple forms per page). Routing in `calculation_fields_example.routing.yml`. Enable only to view worked examples.

## webform_calculation_fields_examples

Demo module under `webform_calculation_fields/modules/`. Installs ready-made webforms via `config/install/` (`webform.webform.webform_calculation_fields_examp`, `..._multi`, `loan_repayment_calculation_examp`) demonstrating simple totals, multi-step totals, and a loan-repayment calculator. Enable only for demos.
