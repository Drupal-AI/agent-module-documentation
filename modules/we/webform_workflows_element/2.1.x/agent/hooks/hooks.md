# Hooks (`webform_workflows_element.api.php`)

Three alter hooks let other modules influence access and the transition UI. Implement in your `.module`
(or a `Hook` class).

- **`hook_webform_workflow_element_access_alter(?bool &$access = NULL, array $context = [])`**
  Override access to a workflow **element**. `$context`: `webform`, `element_plugin`, `account`,
  `workflow_element`, `webform_submission`.

- **`hook_webform_workflow_element_transition_access_alter(?bool &$access = NULL, $context = [])`**
  Override access to a **transition**. Called at the end of
  `WebformWorkflowsManager::checkAccessForSubmissionAndTransition()`. `$context`: `workflow`, `webform`,
  `state`, `account`, `webform_submission`, `transition`. Set `$access = TRUE/FALSE` to allow/deny.

- **`hook_webform_workflow_element_transition_note_alter(?string &$transitionMessage = NULL, $context = [])`**
  Add/modify a note shown next to transitions on the submission form widget. `$context`:
  `webform_submission`, `form`, `form_state`.

Example:
```php
function mymodule_webform_workflow_element_transition_access_alter(?bool &$access, $context = []) {
  // Only let the submission owner run the 'submit_for_review' transition.
  if ($context['transition']->id() === 'submit_for_review') {
    $sub = $context['webform_submission'];
    $access = $sub && (int) $sub->getOwnerId() === (int) $context['account']->id();
  }
}
```
