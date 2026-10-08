<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hook: alter available conditions

`views_access_conditions.api.php` documents one hook (invoked through the `conditions_helper` form builder when building the conditions UI):

```php
/**
 * Alter the conditions available for views access.
 *
 * @param array $conditions
 *   Condition plugin definitions keyed by plugin ID.
 * @param \Drupal\Core\Form\FormStateInterface|null $form_state
 * @param string|null $form_id
 */
function hook_views_access_conditions_available_conditions_alter(
  array &$conditions,
  ?FormStateInterface $form_state = NULL,
  ?string $form_id = NULL
): void {
  // Remove conditions that shouldn't be selectable for views access.
  $conditions = array_diff_key($conditions, array_flip([
    'language',
    'request_path',
  ]));
}
```

Use it to remove noisy/irrelevant condition plugins or to inject a custom condition into the picker. This affects the **UI list only**; the site-level `enabled_conditions` allow-list (see [../configure/conditions.md](../configure/conditions.md)) is the enforced runtime filter.
