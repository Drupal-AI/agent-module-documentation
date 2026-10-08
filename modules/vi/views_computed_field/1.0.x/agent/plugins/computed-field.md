# `field_computed_field` — the computed Views field

The module's entire surface is one Views field handler.
`src/Plugin/views/field/FieldComputedField.php`, `@ViewsField("field_computed_field")`, extends
`Drupal\views\Plugin\views\field\FieldPluginBase`. `views_computed_field_views_data_alter()`
(`.module`) exposes it under `$data['views']['computed_field']`, so in the Views UI it is added via
**Add fields → Global: Computed field**.

## Add it to a view

1. Edit a view. Add the fields you want to combine (e.g. `field_price`, `field_quantity`) **first**.
2. Add **Global: Computed field**. In its options set a **Formula** referencing the earlier fields by
   their machine name, e.g. `field_price * field_quantity`.
3. Order the computed field **after** the fields it references — it reads each referenced field's
   already-rendered value (`$handler->last_render`), so those handlers must run first.

## Options (`defineOptions()` / `buildOptionsForm()`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `formula` | textarea (required) | `''` | Expression over field machine names + literals. |
| `hide_empty_fields` | checkbox | `TRUE` | Treat an empty referenced field as `0` in the calc. |
| `error_handling` | select | `show` | On evaluation error: `show` (print the message), `zero` (render `0`), `hide` (render nothing). |

The Formula field's `#description` lists the fields available in the current view
(`array_keys($this->getPreviousFieldLabels())`).

## How a row is evaluated (`render()` → `evaluateFormula()`)

- `query()` is intentionally empty — no SQL is added; the value is computed in PHP per row.
- `getFieldValues()` builds the variable map:
  - A regex extracts every bareword identifier in the formula **except** the reserved words
    `round|ceil|floor|min|max|avg` and anything immediately followed by `(`:
    `/\b(?!(?:round|ceil|floor|min|max|avg)\b)([a-zA-Z_][a-zA-Z0-9_]*)\b(?!\s*\()/`.
  - **Each such identifier must be a real field** in `getPreviousFieldLabels()`, else it throws
    `InvalidArgumentException('Invalid field: @field')`. This acts as an allowlist: only names of
    fields actually present in the view are accepted as variables.
  - For each valid field it reads `$field_handlers[$field]->last_render`. If `hide_empty_fields` and
    the value is empty → `0`. Otherwise `convertToNumeric()` runs: objects are cast via
    `__toString()`, numeric strings kept, and any other string has all non-`[0-9.,]` characters
    stripped (`preg_replace('/[^0-9.,]/', '', …)`); non-numeric result → `0`. **All variables are
    numeric.**
- A fresh `Symfony\Component\ExpressionLanguage\ExpressionLanguage` evaluates the formula against
  that numeric map. Only `round`/`ceil` are registered (`addMathFunctions()`); ExpressionLanguage
  supplies its built-in `constant` and the standard operators. The result is wrapped in
  `ViewsRenderPipelineMarkup::create($result)` and returned.

## Formula language (Symfony ExpressionLanguage — not PHP)

- Arithmetic: `+ - * / %`, power `**`. Comparisons: `> < >= <= == != === !==`. Logic:
  `and`/`&&`, `or`/`||`, `not`/`!`. Ternary: `cond ? a : b`. String concat: `~`.
- Registered functions: **`round(number, precision = 0)`** and **`ceil(number)`** only.
  `floor`, `min`, `max`, `avg` are *reserved words* in the field-detection regex but are **not
  registered as functions** — a formula that calls them raises
  `Formula error: The function "floor" does not exist` (caught and routed through `error_handling`).
- Because a formula can only call the two registered functions and its variables resolve to numbers
  supplied by the module, it cannot invoke arbitrary PHP or reach objects/services.

### Examples that work

```
field_price * field_quantity
round((field_base + field_bonus) * (1 + field_tax_rate), 2)
field_quantity > 10 ? field_price * 0.9 : field_price
ceil(field_total / field_pages)
```

## Errors & logging

Any exception from `render()`/`evaluateFormula()` is caught by `handleError()`, which logs the
message to the `views_computed_field` logger channel and returns per `error_handling`:
`show` → `ViewsRenderPipelineMarkup` of `Calculation error: @error`; `zero` → `'0'`; `hide` → `''`.

## Limitations

- **Display-only.** No DB expression, so the column cannot be sorted or filtered by the query;
  Views sorts/filters see nothing for it.
- Reads the *rendered* output of prior fields, so field ordering and each field's formatter affect
  the numeric value parsed out by `convertToNumeric()`.
- No config schema ships for the options, so `drush config:*` / config-import may emit a schema
  notice for `formula`/`hide_empty_fields`/`error_handling`.
