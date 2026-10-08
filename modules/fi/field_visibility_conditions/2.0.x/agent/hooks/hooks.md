# Hook — `field_visibility_conditions.api.php`

`hook_field_visibility_conditions_available_conditions_alter(array &$conditions, FormStateInterface $form_state, ?string $form_id = NULL): void`

Alter the set of Condition plugins offered on the field config form. `$conditions` is keyed by
condition plugin ID; add entries to offer more, or remove them:

```php
function my_module_field_visibility_conditions_available_conditions_alter(array &$conditions, FormStateInterface $form_state, ?string $form_id = NULL): void {
  // Drop conditions you don't want editors to use on fields.
  $remove = ['language', 'request_path', 'response_status', 'current_theme'];
  $conditions = array_diff_key($conditions, array_flip($remove));
}
```

The base list comes from the enabled conditions in `field_visibility_conditions.settings`
(`enabled_conditions`) resolved through `conditions_helper`. This is the only hook the module
invites; all field-hiding logic lives in `src/FormAlters.php`.
