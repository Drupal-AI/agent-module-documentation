<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Expression Field (field_expression) — agent index

Field types whose value is **computed from a token expression**, evaluated by a
sandboxed math parser (`webit/eval-math`), not PHP `eval()`. Version **2.1.0**.
Core `^10.2 || ^11`. Depends on `token`. Requires the `webit/eval-math` Composer library.

The middle path between hand-maintained derived values (which drift) and render-time
computation (which cannot be sorted or filtered).

**Field types provided (all single-cardinality):**

- `field_expression` — original string field; evaluates **one** statement. Widget
  `field_expression_default`, formatter `field_expression_value`.
- `expression_integer` / `expression_decimal` / `expression_float` — new in 2.1; extend
  core Integer/Decimal/Float items so the value stores and sorts as a real number, and
  support **multiple `;`-separated statements** with variables and user-defined functions.
  Widget `expression` (also `expression_editable`), formatters `expression_integer` /
  `expression_decimal`.

**Capabilities:**

- Add and configure an expression field (settings keys, operators, functions, tokens,
  defaults, error handling, debug, when-to-evaluate) → [configure/field-settings.md](configure/field-settings.md)

**Two things to settle:**

1. **When the expression is evaluated** decides whether the value goes stale — computed on
   save by default; the formatter's "Always Evaluate" option recomputes on every render (at
   a performance cost) so it tracks a changing referenced entity.
2. **What an expression can reach.** Tokens can expose more than the immediate entity. On a
   site where whoever configures fields is not fully trusted, check that boundary rather than
   assume it. The math evaluator itself is sandboxed (arithmetic + fixed math functions only).
