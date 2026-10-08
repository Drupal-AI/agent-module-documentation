<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Render elements: form_calculation_element & form_calculation_markup

Both are Form API render elements (plugin type `@FormElement`), usable in any Drupal form array. The Webform submodule wraps them as Webform elements.

## form_calculation_element

`src/Element/FormCalculationElement.php`, extends core `Drupal\Core\Render\Element\Number`. Rendered as a `type=text`, `readonly` input; submits the computed numeric result as its value.

Render-array example:

```php
$form['quantity']   = ['#type' => 'textfield', '#title' => $this->t('Quantity')];
$form['unit_price'] = ['#type' => 'textfield', '#title' => $this->t('Unit price')];
$form['total'] = [
  '#type' => 'form_calculation_element',
  '#title' => $this->t('Total'),
  '#required' => TRUE,
  '#evaluation_fields' => ':quantity * :unit_price',
  '#evaluation_decimals' => 2,
  '#evaluation_fields_mask' => 'currency', // optional: none | numeric | currency
  '#currency_symbol' => 'EUR',             // optional, used with the currency mask
];
```

Custom properties (set in `getInfo()`):
- `#evaluation_fields` — the expression. Fields referenced as `:machine_name`; optional default via `:field|0`.
- `#evaluation_decimals` — decimals to round to (`roundResult()` → `round()`).
- `#evaluation_fields_mask` — client-side display mask (`data-inputmask`).
- `#currency_symbol` — currency symbol for the currency mask.

Processing:
- `processFormCalculationElement()` adds `data-evaluate-*` attributes (context = form id, decimals, and JSON of "deep" dependency values for fields not on the current wizard page).
- `preRenderNumber()` marks the input readonly, attaches the `calculation_fields/calculation_fields` library, and emits `data-evaluate-expression` / `data-evaluate-fields`.
- `validate()` is the authoritative server-side callback: it requires every referenced field to be numeric, runs `validateExpression()`, `buildExpression()`, rewrites `^`→`**`, calls `evaluate()`, rounds, and **overwrites** the submitted value with the computed result. Failures are logged and set a form error.
- Multi-step/webform readiness is handled by `fieldIsReadyToValidate()` / `findStepPageOfElement()` so a total on a later wizard page validates only once its inputs have been seen.

## form_calculation_markup

`src/Element/FormCalculationMarkupElement.php`, extends core `Textfield`. Display-oriented: the author writes HTML containing the expression inside `{{ }}`, e.g. `<h3>Total: {{ :a + :b }}</h3>`. `extractEvaluation()` pulls the expression from between `{{ }}`; `preRenderTextfield()` renders via the `form_calculation_element_template` theme hook, replacing the expression with a `[RESULT]` placeholder that JS fills in live.

Server side, `validateExpressionValue()` mirrors the number element: numeric-checks referenced fields, validates + builds + evaluates the expression, `Html::escape()`s the numeric result, and substitutes it back into the markup. Result must be numeric.

## Evaluation service

`src/Services/CalculationFieldsHandlerExpression.php` (service id `calculation_fields.handler_expression`, interface `CalculationFieldsHandlerExpressionInterface`):
- `getFieldsFromExpression()` / `getExpressionInfo()` — parse field names and `|default` values from the expression.
- `buildExpression()` — substitute numeric values for `:field` tokens; returns NULL unless every field has a value; normalizes `,`→`.`.
- `validateExpression()` — extracts `:field` tokens, feeds fake random values, and runs a trial `ExpressionLanguage::evaluate()`; throws `InvalidExpressionException` on failure.
- `evaluate()` — `(new ExpressionLanguage())->evaluate($expression)`. Sandboxed tokenizing parser (no arbitrary PHP calls); the fresh instance registers only ExpressionLanguage's default function set.
- `roundResult()` — `round($value, #evaluation_decimals)`.

Client side (`js/calculation-fields.js`): reads the `data-evaluate-*` attributes, substitutes live input values, guards that each value is numeric, and calls math.js `math.evaluate()` in the user's browser; math.js (v11.11.1) is loaded externally from cdnjs (`calculation_fields.libraries.yml`).
