<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate Conditions provides a framework of reusable **condition** plugins for the Migrate API plus a set of process plugins that evaluate them, letting migration YAML express conditional logic (skip, branch, filter, switch) declaratively.

---

Migrate Conditions defines a new plugin type, `migrate_conditions_condition` (manager service `plugin.manager.migrate_conditions.condition`, discovered from `Plugin/migrate_conditions/condition`, interface `ConditionInterface::evaluate($source, Row)`), and a family of migrate **process** plugins that take a `condition` and act on its boolean result. Process plugins: `evaluate_condition` (returns the boolean), `skip_on_condition` (skip the row or stop the property, with optional logged `message`), `stop_on_condition` (stop the pipeline, keeping the value), `if_condition` (branch with `do_get`/`else_get`, `do_process`/`else_process`, or `do_default_value`/`else_default_value`), `first_meeting_condition` (first source value meeting the condition, with `default_value`), `filter_on_condition` (array_filter over an array source), and `switch_on_condition` (ordered `cases`, first match wins). Any process plugin that declares `handle_multiples` also gets an auto-generated `:foreach` variant (via `hook_migrate_process_info_alter`) that applies the condition element-by-element over an array. Condition plugins ship built-in: `default` (always true), `empty`, `isset`, `is_null`, `equals`, `greater_than`, `less_than`, `contains`, `in_array`, `matches` (regex), `callback` (any callable), `older_than`, `entity_exists`, `in_migrate_map`, `is_stub`, the logical groupers `and`/`or`, and the array helpers `all_elements`/`has_element`. Conditions support three ergonomic shorthands handled by the manager's `createInstance()`: a `not:` prefix to negate (equivalent to `negate: true`), a `parens` shorthand so `equals(bird)` sets the plugin's designated config key, and a per-condition `source` override to evaluate against a different row property. There is no UI, config, permission, Drush command or hook you implement — you use it entirely from migration definition YAML.

---

- Skip a migration row when a source date is older than a month (`skip_on_condition` + `older_than`).
- Skip processing a property (not the whole row) when a value is empty.
- Log a message in the migrate message table for each skipped row.
- Branch a value: if `animal_family` is `bird` get `feather_color`, else `fur_color` (`if_condition`).
- Emulate `null_coalesce` — return the first non-null of several source fields (`first_meeting_condition`).
- Emulate an "empty coalesce" returning the first non-empty source value.
- Filter an array source, keeping only elements meeting a condition (`filter_on_condition`).
- Remove a specific taxonomy tid from a list of source tags via `not:equals` + `filter_on_condition`.
- Implement a switch/case mapping where each case is a full condition (`switch_on_condition`).
- Compute a boolean destination field from any condition (`evaluate_condition`).
- Stop a pipeline early once a value is (or isn't) present (`stop_on_condition`).
- Set publish status from whether an event date is in the past (`older_than` negated).
- Compare a source value to a literal with `equals`, `greater_than`, or `less_than`.
- Compare a source value to another **row property** using the `property` config key.
- Do a strict (`===`) comparison by passing `strict: true` to `equals`.
- Use the parens shorthand for terse conditions, e.g. `condition: equals(100)`.
- Negate any condition inline with the `not:` prefix (e.g. `not:in_migrate_map(my_migration)`).
- Test membership with `in_array`, pattern match with `matches`, or run any PHP callable with `callback`.
- Check whether a looked-up id is already in another migration's map (`in_migrate_map`).
- Detect stub rows with `is_stub` and existing entities with `entity_exists`.
- Combine several conditions with `and` / `or`, optionally iterating over an array source.
- Apply a condition element-by-element over an array using a `:foreach` process variant.
- Evaluate a condition on a different property than the process source via the condition's `source` key.
- Write a custom condition plugin by extending `ConditionBase`/`SimpleComparisonBase` with the `@MigrateConditionsConditionPlugin` annotation.
