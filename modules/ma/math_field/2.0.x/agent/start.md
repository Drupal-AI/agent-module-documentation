<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Math Field (math_field) — agent index

Field formatter that **evaluates a text field's value as an arithmetic expression** and renders the
computed result. Version **2.0.4**. `core_version_requirement: ^9 || ^10 || ^11`. No module
dependencies, no composer requirements. `package: custom` (appears under *custom* on Extend).

Supports `+ - * /`, parentheses and decimals. **Cannot handle negative numbers or unary
operations** (README). `(2 + 3) * 4.5` works; `-5 + 3` does not. Evaluation uses a hand-written
lexer + shunting-yard parser — **no `eval()`**.

## What it provides

- **Formatter plugin** `math_field_formatter` (label *"Math field formatter"*) —
  `src/Plugin/Field/FieldFormatter/MathFieldFormatter.php`. Applies to field types
  `string`, `string_long`, `text`, `text_long`. Has no formatter settings.
- **Service** `math_field.calculator` → `Drupal\math_field\Calculator`
  (`src/Calculator.php`, `math_field.services.yml`). Static-style methods `lexer()` (infix →
  postfix) and `evaluate()` (postfix → number).
- **Theme hook** `math_field` (`math_field_theme()` in `math_field.module`,
  template `templates/math-field.html.twig`) with variables `expression`, `result`.
- **Asset library** `math_field/animate_expression` (`math_field.libraries.yml`, `css/math_field.animate.css`) —
  hover-reveal CSS animation, no JS.
- **hook_help** rendering `README.md` on `help.page.math_field`.

## What it does NOT provide

No routes, no menu links, no permissions, no config entities, no config schema, no Drush commands,
no field type or widget of its own, no settings form (the formatter's `settingsForm()` /
`settingsSummary()` are empty stubs). It reuses core string/text fields as the expression store.

## Solution docs

- [`agent/fields/formatter.md`](fields/formatter.md) — enabling and operating the
  `math_field_formatter` formatter, rendering pipeline, error behavior, theming, gotchas.
- [`agent/api/calculator.md`](api/calculator.md) — the `math_field.calculator` service:
  grammar, `lexer()`/`evaluate()` contract, exceptions, reuse from custom code.
