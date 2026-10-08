<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Calculation Fields — agent index

Spreadsheet-style computed form elements. An expression like `:quantity * :unit_price` is evaluated over the values of other fields and the result is displayed. Two Form API render elements plus a Webform integration submodule.

## What it provides

- **`form_calculation_element`** (render element, extends core `Number`) — a readonly number input whose value is a computed result; the result is submitted as the field value. Class: `src/Element/FormCalculationElement.php`.
- **`form_calculation_markup`** (render element, extends core `Textfield`) — renders the computed result inside surrounding HTML via `{{ expression }}`; display-only. Class: `src/Element/FormCalculationMarkupElement.php`.
- **Webform elements** (submodule `webform_calculation_fields`): "Calculation Field" (`WebformCalculationNumber`) and "Calculation Markup" (`WebformCalculationMarkup`) — the same two elements usable in the Webform UI without code.

## How the formula is evaluated (key mechanism)

1. Expression syntax: fields referenced as `:machine_name`; optional default via pipe, `:field|0`. Author is a developer (render array) or a webform builder (element config), never the end user.
2. **Client-side (live):** `js/calculation-fields.js` substitutes the current input values into the expression and runs `math.evaluate()` from **math.js 11.11.1** (external, loaded from cdnjs — see `calculation_fields.libraries.yml`). Runs in the end user's own browser. `^` power syntax supported.
3. **Server-side (authoritative, on submit):** `Drupal\calculation_fields\Services\CalculationFieldsHandlerExpression` (service `calculation_fields.handler_expression`):
   - `getFieldsFromExpression()` extracts referenced field names.
   - element validate callbacks first reject any referenced field whose submitted value is **not numeric**.
   - `validateExpression()` sanity-checks the expression with fake random values.
   - `buildExpression()` `str_replace`s each field token with its numeric value.
   - `^` is rewritten to `**`, then `evaluate()` runs `(new \Symfony\Component\ExpressionLanguage\ExpressionLanguage())->evaluate($expression)`.
   - The result overwrites the client-submitted value so a tampered client value cannot forge the stored result.

**The evaluator is `symfony/expression-language` — a sandboxed tokenizing expression parser, NOT `eval()`/`create_function()`.** Numeric field values are substituted only after numeric validation, so end-user input cannot inject expression syntax.

## Key files

- `src/Services/CalculationFieldsHandlerExpression.php` — the evaluation service (the core).
- `src/Element/FormCalculationElement.php`, `src/Element/FormCalculationMarkupElement.php` — the two render elements.
- `src/CalculationFieldsTrait.php` — element lookup + service accessor.
- `src/InvalidExpressionException.php` — thrown on invalid expressions.
- `js/calculation-fields.js` — client-side live calc with math.js.
- `templates/form-calculation-element-template.html.twig` — markup element output.
- `calculation_fields.permissions.yml` — `administer calculation_fields configuration` (restricted).
- `modules/webform_calculation_fields/**` — Webform integration (element plugins, UI-access route override).

## Detail docs

- `agent/fields/elements.md` — the two render elements, their `#` properties, and full evaluation pipeline.
- `agent/submodules/webform.md` — the Webform integration and the example submodules.

## Config / requirements

- Requires `symfony/expression-language:^6` (Composer). No config entities or schema shipped by the main module. Base module needs no configuration.
- Core `^9 || ^10 || ^11`. Installed here: 1.0.4, enabled.
