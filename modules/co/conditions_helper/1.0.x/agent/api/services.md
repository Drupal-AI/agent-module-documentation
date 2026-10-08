# Conditions Helper — services & evaluation

Three services, all constructed around core's `plugin.manager.condition` and Context API.

## `conditions_helper.condition_selector_form_builder` — `ConditionSelectorFormBuilder`

Builds the "which conditions are available" selector.

- `buildSelectorFormElements(array $default_selected_ids = [], string $scope_identifier = 'default'): array`
  — returns a `#type => 'checkboxes'` element whose options are all condition plugin definitions
  (keyed by plugin ID, valued by label, sorted by label). Runs the alter hook (below) before building.
- `getAllConditionPluginDefinitions(string $scope_identifier = 'default'): array` — the altered,
  label-sorted definitions array, keyed by plugin ID.

## `conditions_helper.form_builder` — `ConditionsFormBuilder`

Builds and submits the detailed per-condition configuration sub-forms.

- `getAvailableConditions(string $config_name): array` — reads the consuming module's config and
  returns the enabled condition plugin configurations.
- `buildConditionsForm(array &$form, FormStateInterface $form_state, array $available_conditions, array $available_contexts, array $stored_values = []): void`
  — injects a sub-form per condition plugin, including context-mapping selects for context-aware
  plugins (uses `@context.handler`).
- `submitConditionsForm(array &$form, FormStateInterface $form_state, array $form_parents = []): void`
  — calls each plugin's `submitConfigurationForm()` and collects the resulting configuration.
- `getConditionManager(): ConditionManager` — the underlying core condition plugin manager.

## `conditions_helper.evaluator` — `ConditionsEvaluator`

Evaluates a set of stored condition configurations.

```php
$result = \Drupal::service('conditions_helper.evaluator')->evaluateConditions(
  $configured_conditions,   // [plugin_id => config array]; each may include negate + context_mapping
  $all_must_pass = TRUE,    // TRUE = AND (resolveConditions 'and'); FALSE = OR ('or')
  $additional_contexts = [] // extra ContextInterface objects (e.g. current node) merged into runtime contexts
);                          // returns bool; empty $configured_conditions => TRUE
```

Internally it injects the plugin ID into each config, builds a `ConditionPluginCollection`, and for
each `ContextAwarePluginInterface` condition pulls runtime contexts via
`ContextRepository::getRuntimeContexts(array_values($condition->getContextMapping()))`, merges any
`$additional_contexts`, applies them with the context handler (silently skipping on mapping errors),
then resolves with the core `ConditionAccessResolverTrait`.

## Alter hook

```php
/**
 * Alter the condition plugin definitions offered by the selector.
 *
 * @param array $definitions   Condition plugin definitions, keyed by plugin ID.
 * @param string $scope_identifier  Scope passed by the caller (often the form ID).
 */
function hook_conditions_helper_selector_definitions_alter(array &$definitions, string $scope_identifier): void {
  if ($scope_identifier === 'my_feature_conditions_settings') {
    // Restrict to content-related conditions only.
    $definitions = array_intersect_key($definitions, array_flip(['node_type', 'entity_bundle:node']));
  }
}
```

Invoked by both `buildSelectorFormElements()` and `getAllConditionPluginDefinitions()`.
