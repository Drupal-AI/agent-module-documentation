# Conditions Helper — agent index

API-only helper for Drupal core's **Condition plugin API**. No UI, routes, permissions, config, or
Drush — it is consumed by other modules. Provides three services (select / configure / evaluate
conditions) and two abstract base form classes. Depends only on core (Condition, Context, Form APIs).

- **The three services, their methods, the evaluate flow, and the alter hook** →
  [api/services.md](api/services.md)
- **The two base form classes (`ConditionSelectorSettingsFormBase`, `ConditionsFormBase`) and the
  `enabled_conditions` config convention** → [extend/base-classes.md](extend/base-classes.md)

Key facts:
- Services: `conditions_helper.condition_selector_form_builder`, `conditions_helper.form_builder`,
  `conditions_helper.evaluator`.
- `ConditionsEvaluator::evaluateConditions($configured, $all_must_pass = TRUE, $additional_contexts = [])`
  returns bool (AND when TRUE, OR when FALSE).
- Alter hook: `hook_conditions_helper_selector_definitions_alter(&$definitions, $scope_identifier)`.
- Consuming modules must define their own config schema for stored condition data.
