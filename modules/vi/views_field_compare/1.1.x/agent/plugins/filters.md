# The comparison filter plugins

Both are `FilterPluginBase` subclasses added to the Views *Global* category (table `views`). Add them via
a display's **Filter criteria › Add › Global**. They store two options, `left_field` and `right_field`
(machine names of fields in the display), and are neither exposable nor groupable.

## `field_comparison` — Field comparison (`FieldComparison`)

- Option form: two selects (*left*/*right*) listing every **click-sortable** field in the display; errors
  if fewer than 2 such fields exist.
- Operators: `<`, `<=`, `=`, `!=`, `>=`, `>` (all method `opSimple`).
- `query()`: rebuilds fields, resolves each operand to `tableAlias.realField`, and if both resolve calls
  `opSimple()` → `$this->query->addWhereExpression($group, "$left {$operator} $right", [])`.
- `validate()`: requires a fields-based display and that both selected fields are present and click-sortable.
- If a chosen field is missing at query time, sets `build_info['fail'] = TRUE` so the view returns nothing
  (fails safe rather than showing unfiltered rows).

## `field_contained` — Field contained (`FieldContained`)

- Option form: *left* select = click-sortable fields; *right* select = **multi-valued** fields
  (`$field->multiple`).
- Operators: `in` (*Is contained in*, `opContained`) and `not in` (*Is not contained in*, `opNotContained`).
- `query()` resolves both operands to `EntityField` handlers, then:
  - `generateSubquery()` walks the target (multi-valued) field's `tableQueue`, reproducing its base table +
    joins, to build a correlated sub-SELECT that selects the target column and constrains it to the current
    row (`WHERE source.field = alias.field`). Square brackets around table names are converted to `{curly}`
    Drupal table placeholders.
  - `opContained` / `opNotContained` wrap that subquery as `source.col IN (\n<subquery>\n)` /
    `NOT IN (...)` and add it with `addWhereExpression()`.
- `tableAlias()` strips underscores to keep identifiers under the 63-char limit; `joinExtra()` /
  `extraStandard()` / `extraFieldOrLanguageJoin()` reproduce join `extra` conditions (langcode/bundle, etc.).

## Notes for agents

- Operands are **admin-selected field machine names** and operators come from a fixed whitelist; there is no
  exposed/end-user input path into these SQL expressions.
- Both fields must be attached to the same entity type for `field_contained`'s subquery to correlate
  correctly (the commented-out validation in source hints at this — comparisons across unrelated entity
  types may not join meaningfully).
- The operand fields must be present in the display (they can be hidden via *Exclude from display*).
