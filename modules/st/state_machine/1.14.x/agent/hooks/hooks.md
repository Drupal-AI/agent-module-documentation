# Hooks (`state_machine.api.php`)

Two alter hooks let you change plugin definitions discovered from YAML. Both run at discovery
time; `drush cr` after changing code.

```php
/**
 * Alter workflow definitions, keyed by plugin id.
 */
function hook_workflows_alter(array &$workflows) {
  $workflows['default']['label'] = 'Altered label';
  // Add a state/transition to another module's workflow:
  $workflows['default']['states']['on_hold'] = ['label' => 'On hold'];
}

/**
 * Alter workflow group definitions, keyed by plugin id.
 */
function hook_workflow_groups_alter(array &$workflow_groups) {
  $workflow_groups['commerce_order']['label'] = 'Altered label';
}
```

Use these to extend or relabel workflows shipped by another module (e.g. add a state to the
Commerce order workflow) without forking its YAML.
