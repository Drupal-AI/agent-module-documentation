<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The calculator service (math_field.calculator)

`Drupal\math_field\Calculator` (`src/Calculator.php`), registered as service
**`math_field.calculator`** in `math_field.services.yml` with no constructor arguments. It is the
parser/evaluator behind the formatter and is safe to reuse from custom code. Both methods are
declared `public static`, so you can call them statically or on the service instance.

## Grammar

- Operators: `+`, `-` (precedence 2) and `*`, `/` (precedence 3). No exponent, modulo, or unary
  operators.
- Grouping: `(` `)`.
- Operands: non-negative decimal numbers (`0123456789.`), parsed with `floatval()`.
- Whitespace (space, tab, newline) is ignored between tokens.
- **No** negative numbers, variables, functions, or tokens. Any other character is rejected.
- Evaluation deliberately avoids `eval()` — the restricted grammar is enforced by the tokenizer and
  the parser can only ever perform those four arithmetic operations.

## `Calculator::lexer(string $expression): string`

Tokenizes an infix expression and returns it in **postfix** (reverse Polish) notation using the
shunting-yard algorithm.

- Tokenizer classifies each char as whitespace, a simple token (`+ - * / ( )`), part of a number, or
  invalid. Consecutive number chars are accumulated into one `floatval` token.
- Shunting-yard pops higher/equal-precedence operators to the output queue before pushing the current
  operator; parentheses control grouping.

Examples (from `tests/src/Unit/CalculatorTest.php`):

| Infix | Postfix |
|---|---|
| `1 + 2` | `1 2 +` |
| `(2 + 3) * 5` | `2 3 + 5 *` |
| `1.1 + 2` | `1.1 2 +` |
| `(1+2.1) * 33 + 200 / 10 +  100` | `1 2.1 + 33 * 200 10 / + 100 +` |

Throws `\Exception` on:

- **"Empty expression"** — falsy/empty input.
- **"Invalid character (X) at position N"** — any char outside the grammar.
- **"Mismatched parentheses!"** — unbalanced `(` / `)`.
- **"Unexpected token …"** — a token that fits none of the parser branches.

## `Calculator::evaluate(string $postfix): string`

Evaluates a space-separated postfix string and returns the numeric result (`end($stack)`).

- Splits on spaces; pushes numeric tokens; for each operator pops two operands and applies
  `* / - +`.
- Throws `\Exception` **"Unknown operator …"** for a non-numeric, non-operator token.
- Division uses PHP `/` directly, so a zero divisor raises `DivisionByZeroError` (a subclass of
  `Error`, **not** `Exception`) — guard your input if divisors can be zero.

## Reuse example

```php
/** @var \Drupal\math_field\Calculator $calc */
$calc = \Drupal::service('math_field.calculator');
try {
  $postfix = $calc::lexer('(1 + 2) * 4');   // "1 2 + 4 *"
  $value   = $calc::evaluate($postfix);      // 12
}
catch (\Exception $e) {
  // Empty / invalid character / mismatched parentheses / unexpected token.
  \Drupal::logger('my_module')->error($e->getMessage());
}
```

The formatter (`MathFieldFormatter::viewValue()`) does exactly this and then escapes the result with
`Html::escape()` before output.
