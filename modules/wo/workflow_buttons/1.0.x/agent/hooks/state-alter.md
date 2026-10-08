# `hook_workflow_buttons_state_alter`

The one hook the module invites (`workflow_buttons.api.php`). It fires from the entity builder
`WorkflowButtonsWidget::updateStatus()` **before** the clicked button's target state is written to
`$entity->moderation_state`, letting you override which state a button actually sets. Useful when
you have added custom buttons via `hook_field_widget_WIDGET_TYPE_form_alter()` and need to map
them to a state, or to redirect a transition conditionally.

```php
/**
 * Implements hook_workflow_buttons_state_alter().
 *
 * @param string $moderation_state
 *   The workflow state to be used when saving the entity (alter by reference).
 * @param \Drupal\Core\Entity\EntityInterface $entity
 *   The entity being saved.
 * @param \Drupal\Core\Form\FormStateInterface $form_state
 *   The form state.
 */
function my_module_workflow_buttons_state_alter(string &$moderation_state, \Drupal\Core\Entity\EntityInterface &$entity, \Drupal\Core\Form\FormStateInterface &$form_state) {
  // Example: force anything an anonymous-ish flow tried to publish into review.
  if ($moderation_state === 'published' && !\Drupal::currentUser()->hasPermission('use editorial transition publish')) {
    $moderation_state = 'draft';
  }
}
```

The value passed in is the clicked button's `#moderation_state` (the transition's target state).
After the hook runs, `updateStatus()` does `$entity->moderation_state->value = $moderation_state;`.
Implement it in a `.module` file; no service registration needed. This is the only extension
point — the widget itself is a normal `OptionsSelectWidget` subclass you could also extend.
