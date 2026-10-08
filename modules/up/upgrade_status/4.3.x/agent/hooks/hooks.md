# Hooks

Defined in `upgrade_status.api.php`.

### `hook_upgrade_status_operations_alter(array &$operations, FormStateInterface $form_state)`
Alter the batch operations run when the user scans projects. `$operations` is the standard batch
operations array. Example: duplicate each operation to also run drupal-rector on the same extension.
```php
function mymodule_upgrade_status_operations_alter(array &$operations, FormStateInterface $form_state) {
  if (!empty($form_state->getValue('run_rector'))) {
    foreach (array_keys($operations) as $key) {
      $operations[] = ['update_rector_run_rector_batch', [$operations[$key][1][0]]];
    }
  }
}
```

### `hook_upgrade_status_result_alter(array &$build, Extension $extension, $group_key)`
Alter the render array for one project's result group before display. `$group_key` is one of
`rector`, `now`, `uncategorized`, `later`, `ignore`. `$build` has `title`, `description`,
`errors`, etc.
```php
function mymodule_upgrade_status_result_alter(array &$build, Extension $extension, $group_key) {
  if ($group_key == 'rector') {
    $build['description']['#markup'] = t('Here is your patch...');
  }
}
```
