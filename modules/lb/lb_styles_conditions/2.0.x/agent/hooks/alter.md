<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hook: alter available conditions

`lb_styles_conditions.api.php` documents one hook, invoked when building the "Condition restrictions" / settings condition picker:

```php
/**
 * Alter the condition plugins available for Layout Builder Styles.
 *
 * @param array $conditions
 *   Condition plugin definitions keyed by plugin ID.
 * @param \Drupal\Core\Form\FormStateInterface $form_state
 * @param string|null $form_id
 *
 * @see \Drupal\lb_styles_conditions\Form\SettingsForm::buildForm()
 */
function hook_lb_styles_conditions_available_conditions_alter(
  array &$conditions,
  FormStateInterface $form_state,
  ?string $form_id = NULL
): void {
  $conditions = array_diff_key($conditions, array_flip([
    'language',
    'request_path',
    'response_status',
    'current_theme',
  ]));
}
```

Use it to remove irrelevant condition plugins or add a custom one. The site-level `enabled_conditions` allow-list (see [../configure/conditions.md](../configure/conditions.md)) is the persisted filter.
