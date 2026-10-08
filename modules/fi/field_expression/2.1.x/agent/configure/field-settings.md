<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure an expression field

No module settings page and no config schema shipped — everything is per-field, set on the
normal field-config forms (`admin/structure/types/manage/{bundle}/fields`). Cardinality is
forced to 1 for these fields (a form_alter disables it; multiple items would evaluate to the
same value).

## Choosing a field type

| Field type id | Extends | Stored/sorted as | Statements | Widget | Formatter |
|---|---|---|---|---|---|
| `field_expression` | string (text, big) | string | one only | `field_expression_default` | `field_expression_value` |
| `expression_integer` | core IntegerItem | integer | multiple (`;`) | `expression` / `expression_editable` | `expression_integer` |
| `expression_decimal` | core DecimalItem | decimal | multiple (`;`) | `expression` / `expression_editable` | `expression_decimal` |
| `expression_float` | core FloatItem | float | multiple (`;`) | `expression` / `expression_editable` | `expression_decimal` |

Use a numeric variant when you need the value to sort/filter as a number or use its precision/
scale settings; use `field_expression` for a plain string result. The numeric variants also
inherit core number-field settings (min/max are removed from the form for expression fields).

## Field settings keys (`getSetting(...)`)

Set on the field instance settings form:

- `expression` (string, required) — the formula. Required.
- `default_zero` (bool, default TRUE) — replace any token that does not resolve with `0`.
  If FALSE, unresolved tokens are left in place (usually producing a blank result / error).
- `suppress_errors` (bool, default TRUE) — on an evaluation error, return blank instead of
  surfacing the error (passed to `EvalMath::$suppress_errors`).
- `debug_mode` (bool, default FALSE) — only shown when the `devel` module is enabled; logs
  the original expression, token-replaced expression, and result via `logger()->dump()`.

## Formatter setting

- `always_evaluate` (bool, default FALSE) — re-evaluate the expression on every render rather
  than reading the value stored at save time. Use when tokens read a referenced entity that
  can change without this entity being re-saved. Costs performance on large/token-heavy
  expressions. Available on all expression formatters.

## Writing the expression

- Operators: `+ - * / ^ %`. `^` is exponentiation (there is no `pow()`); `%` is modulo.
- Built-in functions take exactly one argument: `sin sinh arcsin/asin arcsinh/asinh cos cosh
  arccos/acos arccosh/acosh tan tanh arctan/atan arctanh/atanh sqrt abs ln log`. `log` is the
  natural log (same as `ln`). `min()`, `max()`, `round()` are NOT built in.
- Numeric field types only: assign variables and define multi-arg functions across `;`-separated
  statements; end with a value-producing statement, e.g.
  `min(a,b) = (a+b-abs(a-b))/2; min(3,5)`. The base `field_expression` type evaluates a single
  statement.
- Tokens (token module) are replaced when the host entity is saved. Per-token defaults go in
  curly braces immediately after the token: `[node:field_some_number]{100}`.
- Line breaks and spaces are stripped before evaluation (so `1 000` becomes `1000`, not zero).

## How/when it evaluates

`preSave()` on the field item calls `evaluateExpression()`: strip line breaks → `\Drupal::token()
->replace(...)` with `clear => FALSE` → apply curly-brace defaults / `default_zero` for leftover
tokens → strip spaces → `EvalMath::evaluate()`. Integer type casts the result to `(int)`. The
stored value is what the formatter shows unless `always_evaluate` recomputes at render time.
