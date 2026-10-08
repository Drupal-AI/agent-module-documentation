<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Math Field is a field formatter that reads a text field containing an arithmetic expression and renders the computed result, using a small hand-written lexer and a shunting-yard parser exposed as a service.

---

The premise is narrow and the README is honest about the boundaries. The formatter supports `+`, `-`, `*` and `/`, handles parentheses and decimal numbers, and — stated explicitly — cannot handle negative numbers or unary operations. So `(2 + 3) * 4.5` evaluates, but `-5 + 3` does not. Evaluation is done without `eval()`: `Calculator::lexer()` tokenizes the string and converts it to postfix (reverse Polish) notation with the shunting-yard algorithm, and `Calculator::evaluate()` walks that postfix stack. The only things it can compute are the four operations it implements.

Setup is entirely through the display UI. Create a `string`, `string_long`, `text` or `text_long` field, then on *Manage display* set the format to **Math field formatter**. The stored field value is the expression itself; the result is computed at render time. The theme (`math_field` / `math-field.html.twig`) emits the expression and the result as two spans, and the bundled CSS library (`math_field/animate_expression`) hides the result until hover, when it fades in after a short delay.

Errors are shown inline rather than thrown: a malformed expression (invalid character, mismatched parentheses, unknown token) is caught, added as a Drupal error message, and also rendered in place of the result. That is convenient during authoring but means an editing mistake becomes visible on public-facing displays, so review error output on anonymous views.

Two adoption caveats. Because the field stores the expression and not the number, the value is recomputed on every render and cannot be sorted or filtered on in Views. And the module declares `package: custom`, so it appears under the *custom* heading on the Extend page rather than under a themed group.

---

- Display the numeric result of an arithmetic expression stored in a text field.
- Add, subtract, multiply and divide numeric literals in one expression.
- Respect operator precedence (`*` and `/` bind tighter than `+` and `-`).
- Handle parentheses to force evaluation order, e.g. `(1 + 2) * 4 = 12`.
- Handle decimal / floating-point numbers such as `1.1 + 2`.
- Compute a displayed total or subtotal from a fixed formula.
- Evaluate user-supplied arithmetic without ever calling `eval()`.
- Reuse the `math_field.calculator` service from custom code to parse or evaluate expressions.
- Convert an infix expression to postfix with `Calculator::lexer()`.
- Evaluate a postfix expression with `Calculator::evaluate()`.
- Show a formula first and reveal its result on hover with a CSS animation.
- Surface expression errors inline for content editors during authoring.
- Apply the formatter to `string`, `string_long`, `text` or `text_long` fields.
- Set the formatter via *Manage display* or via `core.entity_view_display.*` config.
- Provide a lightweight calculated-display field without installing a full computed-field module.
- Accept that the field stores the expression, not the result.
- Accept that results cannot be sorted or filtered in Views.
- Accept that negative numbers and unary minus are unsupported.
- Accept that whitespace is optional between tokens (`(1+2.1)*33` works).
- Locate the module under the "custom" package on the Extend page.
- Keep the computation grammar deliberately small for predictability.
