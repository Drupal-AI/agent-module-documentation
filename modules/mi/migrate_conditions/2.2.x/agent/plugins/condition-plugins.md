<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate Conditions — condition plugins

Condition plugins live in `Plugin/migrate_conditions/condition`, are managed by
`plugin.manager.migrate_conditions.condition`, carry the `@MigrateConditionsConditionPlugin`
annotation, and implement `ConditionInterface::evaluate($source, Row): bool`.

## Universal config keys (from `ConditionBase`)

- `negate` — invert the result (XOR). Equivalent to the `not:` id prefix.
- `source` — property (string) or array of properties to evaluate against, **overriding** the
  process plugin's value. When set, the row values are fetched via `Row::get()`.
- `requires` (annotation) — config keys that MUST be provided, else `InvalidArgumentException`.

## Shorthands (handled by the manager's `createInstance()`)

- **`not:` prefix** — `condition: not:empty` == `{ plugin: empty, negate: true }`
  (multiple `not:` prefixes cancel out).
- **`parens`** — a condition may declare a `parens` config key; `equals(bird)` sets that key
  to the string `bird`. Values in parens are always strings. `property` can NOT be set via
  parens.

## Comparison conditions

Most extend `SimpleComparisonBase`, which requires **exactly one** of `value` (a literal) or
`property` (a source/`@destination` key to `get` and compare against).

| id | parens | Notes |
|---|---|---|
| `equals` | `value` | `strict: true` → `===`. |
| `greater_than` | `value` | `source > value`. |
| `less_than` | `value` | `source < value`. |
| `contains` | `value` | substring. |
| `matches` | `regex` | requires `regex`; `preg_match`. |
| `in_array` | — | source is a needle, `value`/`property` an array (or vice-versa per plugin). |
| `older_than` | — | requires `format` (a date format, e.g. `U`, `j M Y`); `value` is a reference time like `now`, `-1 month`. |
| `callback` | `callable` | requires `callable`; runs any PHP callable on the source. |
| `entity_exists` | `entity_type` | requires `entity_type`; true if an entity with the source id/value exists. |
| `in_migrate_map` | `migration` | requires `migration`; true if the value is in that migration's map. Supports `include_skipped`. |
| `http_status` | `code` | checks an HTTP status. |

## Value-shape conditions (no value/property)

| id | Meaning |
|---|---|
| `empty` | PHP `empty()`. |
| `isset` | value is set. |
| `is_null` | value is NULL. |
| `is_stub` | the row is a migration stub. |
| `default` | always TRUE (handy as a `switch_on_condition` catch-all). |

## Logical & array-helper conditions

- `and` (requires `conditions`) / `or` — group child `conditions`. With `iterate: true` each
  child is evaluated against the corresponding element of an array source.
- `all_elements` (requires `condition`) — the child condition must hold for **every** element
  of the (array) source.
- `has_element` (requires `condition`) — the child condition holds for **at least one**
  element of the source.

```yaml
# 13 <= age < 20
condition:
  plugin: and
  conditions:
    - { plugin: less_than, negate: true, value: 13 }
    - { plugin: less_than, value: 20 }
```

## Writing a custom condition

```php
namespace Drupal\my_module\Plugin\migrate_conditions\condition;

use Drupal\migrate\Row;
use Drupal\migrate_conditions\Plugin\ConditionBase;

/**
 * @MigrateConditionsConditionPlugin(
 *   id = "starts_with",
 *   requires = {"prefix"},
 *   parens = "prefix"
 * )
 */
class StartsWith extends ConditionBase {
  protected function doEvaluate($source, Row $row): bool {
    return str_starts_with((string) $source, $this->configuration['prefix']);
  }
}
```

Extend `SimpleComparisonBase` instead (implement `compare($source, $value)`) for a plain
value/property comparison; extend `LogicalConditionBase` for a grouper. `ConditionBase`
handles `negate` and `source` for you — implement `doEvaluate()`, not `evaluate()`.

## Instantiating from code (used in evals/tests)

```php
$manager = \Drupal::service('plugin.manager.migrate_conditions.condition');
$cond = $manager->createInstance('greater_than(3)');   // parens shorthand
$result = $cond->evaluate(5, new \Drupal\migrate\Row());  // TRUE
```
