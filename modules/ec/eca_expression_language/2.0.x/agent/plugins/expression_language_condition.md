<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Expression language condition (`eca_el`)

Source: `src/Plugin/ECA/Condition/ExpressionLanguageCondition.php`. The module's only plugin. It is
an **ECA condition** you attach to a model to gate an event/action on the boolean result of a
Symfony Expression Language expression.

## Install / enable

- `composer require drupal/eca_expression_language` (pulls `drupal/eca ^2.1 || ^3.0` and
  `symfony/expression-language 6.4|^7.1|^8.0`), then enable `eca` and `eca_expression_language`.
- No settings form, no config objects, no permissions. Everything is configured per-condition
  inside an ECA model (via ECA's own model UI / config).

## Plugin definition

Declared with `#[EcaCondition(...)]` from `Drupal\eca\Attribute\EcaCondition`:

- `id`: **`eca_el`**
- `label`: *Expression language condition*
- `description`: *Evaluates an expression language expression.*
- `version_introduced`: `1.0.0`

Class `ExpressionLanguageCondition extends ConditionBase` (from
`Drupal\eca\Plugin\ECA\Condition`) and `use PluginFormTrait`. `create()` additionally injects
`logger.factory` into `$loggerFactory`.

## Configuration (`defaultConfiguration()` + `buildConfigurationForm()`)

Two keys are stored on the condition config:

| Key | Type | Default | Form element |
| --- | --- | --- | --- |
| `el` | string | `''` | `textarea` titled *Expression*, weight −90, description *"The expression to be evaluated."* |
| `error_fallback` | string | `'no'` | `select` titled *Fallback value*, options `yes` → *True*, `no` → *False*, weight −89, description *"Condition value in case the expression processing fails, false otherwise."*, with `#eca_token_select_option => FALSE` |

`submitConfigurationForm()` copies `el` and `error_fallback` from form state into
`$this->configuration`. Getters: `getEl()` returns `configuration['el'] ?? ''`;
`getFallbackValue()` returns `configuration['error_fallback'] ?? 'no'`. There is no module-provided
config schema; the condition config is persisted as part of the ECA model by the `eca` module.

## Evaluation (`evaluate(): bool`)

1. `$processedExpression = $this->getEl();`
2. Because the static property `$replaceTokens` is `TRUE`, tokens are substituted first:
   `$processedExpression = $this->tokenService->replace($this->getEl());` (ECA's token service,
   `ConditionBase::$tokenService`). Token replacement is textual — the token's value is inserted
   into the expression **string** before it is parsed. This is why expressions reference data as
   tokens (e.g. `"[entity:type]" == "article"`, `[user:uid] == 1`) rather than as expression
   variables.
3. `$expressionLanguage = new ExpressionLanguage();` — a **plain** instance:
   **no** `ExpressionFunctionProviderInterface` is registered, **no** custom functions are added,
   and **no** `$values` array is passed to `evaluate()`. The expression therefore has access only
   to Expression Language's built-in operators and the literal text produced by step 2.
4. `$result = $expressionLanguage->evaluate($processedExpression);`
   - If `$result` is **not** a bool, an error is logged to the `default` channel
     (*"The expression '…' must return a boolean value. Returning fallback value."*) and the
     fallback is returned (`getFallbackValue() === 'yes'`).
   - A `Symfony\Component\ExpressionLanguage\SyntaxError` is caught, logged to the `default`
     channel (*"Wrong syntax for expression '…'. Returning fallback value."*), and the fallback is
     returned.
   - Otherwise the boolean `$result` is returned.

## Expression syntax notes

Symfony Expression Language supports comparison (`==`, `!=`, `<`, `>`, …), boolean logic
(`and`/`or`/`not`, `&&`/`||`), grouping with `()`, arithmetic (`+ - * / %`), string concatenation
(`~`), membership (`in` / `not in`), the `matches` regex operator, ternary (`? :`), and array/hash
literals (`[1, 2, 3]`). Because no functions or variables are exposed here, an expression that names
a function or an unbound variable raises a `SyntaxError`/runtime error and falls back. Author
expressions so they evaluate to a boolean; anything else triggers the fallback path.

## Operating tips

- Set `error_fallback` to *True* to fail open or *False* (default) to fail closed when an
  expression is malformed.
- Watch the `default` log channel for the two error messages above to catch bad expressions.
- Quote string tokens (`"[node:title]"`) so the replaced value is a valid string literal; leave
  numeric tokens (`[node:nid]`) unquoted for numeric comparisons.
