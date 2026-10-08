# Views plugins provided

The module does **not** define any plugin *type*; it provides plugin *instances* that extend
core Views handlers. You normally get these by converting a filter (see
`configure/assignment.md`) rather than selecting them directly.

## Argument (contextual filter) handlers

| Plugin id | Class | Extends | Matches |
|---|---|---|---|
| `numeric_range` | `NumericRangeArgument` | core `NumericArgument` | integer / float / entity-id / list-key ranges |
| `string_range` | `StringRangeArgument` | core `StringArgument` | case-insensitive alphabetic ranges (glossary-mode aware) |
| `date_range` | `DateRange` | core `Date` | date ranges (strict `YYYY-MM-DD` or relative dates) |

All three use `MultiRangesTrait` for the `break_phrase` ("Allow multiple ranges" via `+`) and
"Exclude" (negate) options. `string_range` adds its own `not` (Exclude) option since the core
String base class lacks it.

## Argument validator

| Plugin id | Class | Extends |
|---|---|---|
| `numeric_range` | `NumericRangeArgumentValidator` | core `NumericArgumentValidator` |

Selectable in the Views UI *"When the filter value IS in the URL…"* → "Specify validation
criteria" → **Numeric Range**. Do not combine it with "Allow multiple numeric ranges" (use
*-Basic validation-* instead in that case).

## Argument default (PHP code)

| Plugin id | Class | Title |
|---|---|---|
| `php_default` | `PhpDefault` (implements `CacheableDependencyInterface`) | "PHP code" |

Runs a PHP snippet that returns a single string/number used as the default contextual value when
the URL has no argument — ideal for "related content" blocks. Requires the **`use php code for
default contextual filter`** permission. In the snippet, some entities are available as
`$entity['node']`, `$entity['user']`, etc., and `--` is the range operator. Example returning
"everything cheaper than the current node's price":

```php
return '--' . $entity['node']->field_price->getString();
```

## How the range query is built

`ContextualRangeFilter::buildRangeQuery($argument_plugin, $field = NULL, $range_converter = NULL)`
(static, in `src/ContextualRangeFilter.php`) splits each `from--to` value (separators `--` or
`:`) and adds WHERE expressions to the View query:

- `from--to` → `BETWEEN` (or `NOT BETWEEN` if Exclude)
- `from--` → `>=` (or `<`)
- `--to` → `<=` (or `>`)
- single value → `=` (or `!=`)

OR'd ranges go in an `OR` where-group; when negated they go in an `AND` group with an
`OR <field> IS NULL` guard. `date_range` passes a `$range_converter` to normalise relative dates
before comparison.
