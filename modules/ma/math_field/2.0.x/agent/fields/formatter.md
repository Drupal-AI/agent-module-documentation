<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Math field formatter" (math_field_formatter)

## Install & enable

```bash
composer require drupal/math_field
drush en math_field -y
```

No module dependencies, no sub-modules, no permissions of its own, no Drush commands. `package` is
`custom`, so the module lists under **custom** on `/admin/modules`.

## Enable it on a field

Plugin id **`math_field_formatter`**, label *"Math field formatter"*, defined in
`src/Plugin/Field/FieldFormatter/MathFieldFormatter.php` via the `@FieldFormatter` annotation. It
applies to these core field types only:

```
string, string_long, text, text_long
```

It does **not** provide its own field type or widget — you store the arithmetic **expression** as
plain text in one of the above fields using the normal text widget, and this formatter computes and
displays the result at view time.

UI path: *Structure → (bundle) → Manage display* → set the field's format to **Math field
formatter**. There are no formatter options — `defaultSettings()`, `settingsForm()` and
`settingsSummary()` are empty stubs, so the gear icon shows nothing to configure.

Config equivalent (view display):

```bash
drush cset core.entity_view_display.node.article.default \
  content.field_formula.type math_field_formatter -y
drush cr
```

```yaml
# core.entity_view_display.node.article.default
content:
  field_formula:
    type: math_field_formatter
    label: above
    settings: {}
```

There is **no config schema** shipped for these settings (the module has no `config/` directory), but
`settings` is empty so strict schema tooling has nothing to flag.

## What renders

`viewElements()` builds, per field item, a render array with `#theme => 'math_field'` and:

- `#expression` = the raw stored field value (`$item->value`);
- `#result` = the output of `viewValue($item)`;
- `#attached[library]` = `math_field/animate_expression`;
- wrapper `#attributes[class]` = `math-field-container`.

`viewValue()` runs the value through the calculator:

```php
$postfix = $this->calculator->lexer($item->value);   // infix → postfix
$result  = $this->calculator->evaluate($postfix);     // postfix → number
return nl2br(Html::escape($result));
```

The template `templates/math-field.html.twig` prints three spans — `slp-expression`
({{ expression }}), `slp-equals` (`=`) and `slp-result` ({{ result }}). Twig autoescapes the
expression; the result is additionally `Html::escape()`-d in PHP. The CSS library
(`css/math_field.animate.css`, classes `slp-hidden` / `math-field-container:hover`) keeps `=` and
the result hidden until the container is hovered, then fades them in with a delayed transition. The
library is CSS-only — no JavaScript.

## Error behavior

Evaluation is wrapped in `try/catch (\Exception $e)`. On a parser error (empty expression, invalid
character, mismatched parentheses, unexpected/unknown token — see the service doc) the formatter:

1. adds the exception message as a Drupal **error** message via the `messenger` service, and
2. uses that same message string as `#result`, so it renders **inline** in place of the number.

This makes authoring mistakes visible directly in the output, including on public-facing displays —
review anonymous renders if editors can enter free-form expressions.

## Services injected

`create()` pulls two services into the formatter:

- `math_field.calculator` → `Drupal\math_field\Calculator` (the parser; see
  [`../api/calculator.md`](../api/calculator.md));
- `messenger` (core) for the inline error messages.

## Gotchas

- The field stores the **expression**, not the computed number, so the result is recomputed on every
  uncached render and **cannot be sorted or filtered in Views**.
- **No negative numbers / unary minus**: a leading `-` (e.g. `-5 + 3`) is not part of the grammar and
  produces a parser error, not a negative result.
- **Division by zero**: `evaluate()` performs `$firstOperand / $secondOperand` directly. On PHP 8+ a
  zero divisor raises `DivisionByZeroError`, which extends `Error` (not `Exception`), so it is **not**
  caught by the formatter's `catch (\Exception)` — keep zero divisors out of author-controlled
  formulas.
- Only the four binary operators and parentheses are recognized; anything else (letters, `^`, `%`,
  tokens/placeholders) is an "Invalid character" error.
- Whitespace is optional: the lexer skips spaces/tabs/newlines, so `(1+2.1)*33` tokenizes the same as
  the spaced form.
