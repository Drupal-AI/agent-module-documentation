<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA Expression Language (eca_expression_language) — agent index

Adds **one ECA condition plugin** that evaluates a **Symfony Expression Language** expression (from
`symfony/expression-language`) and returns a boolean, so ECA models can branch on composite logic
written as a single formula. Package **ECA**. Depends on **`eca`**. Core `^10 || ^11`. PHP `>=8.1`.
License GPL-2.0-or-later. Version-dir 2.0.x (release 2.0.0).

- **The condition plugin — id, settings, token handling, evaluation, fallback** →
  [plugins/expression_language_condition.md](plugins/expression_language_condition.md)

## What it actually is

- A single class: `ExpressionLanguageCondition`
  (`src/Plugin/ECA/Condition/ExpressionLanguageCondition.php`), declared with the ECA attribute
  `#[EcaCondition(id: 'eca_el', label: 'Expression language condition',
  description: 'Evaluates an expression language expression.', version_introduced: '1.0.0')]`.
  It extends ECA's `ConditionBase` and uses `PluginFormTrait`.
- **No** routes, permissions, services, hooks, `*.module`, `*.install`, `config/**`, submodules,
  Drush commands, or libraries. The module is purely this one plugin plus its Composer requirement
  on `symfony/expression-language`.
- The README mentions an "Expression Language Value" feature; it is **not** in this release
  (condition only).

## Mechanism (from source)

- `evaluate()` reads the configured expression string (`getEl()`); because the static flag
  `$replaceTokens` is TRUE it first runs `$this->tokenService->replace()` (ECA's token service) to
  substitute tokens into the string, then evaluates it with a **bare** `new ExpressionLanguage()` —
  **no** custom functions/providers are registered and **no** variables are passed to `evaluate()`,
  so the expression can only operate on the literal text produced by token replacement.
- A non-boolean result or a `SyntaxError` is logged to the `default` logger channel and the
  configured **fallback** (`error_fallback`: `yes`→TRUE, `no`→FALSE, default `no`) is returned.

## Settings (`defaultConfiguration()`)

- `el` (default `''`) — the expression, a textarea in the config form.
- `error_fallback` (default `'no'`) — a select (True/False) used when evaluation fails; its form
  element sets `#eca_token_select_option => FALSE`.

Full field/plugin detail in [plugins/expression_language_condition.md](plugins/expression_language_condition.md).
