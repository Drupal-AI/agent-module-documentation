# API — service, event, tokens

## Service `webform_workflows_element.manager` (`Service/WebformWorkflowsManager`)

The central helper. Selected public methods:
- `getWorkflowElementsForWebform(WebformInterface): array` — the workflow elements on a webform (keyed
  by element id; each includes `#workflow`).
- `getWorkflow($id)`, `getStates()/getTransitions*`, `getInitialStateForElement($element)`,
  `getStateFromElementAndId($element, $stateId)`.
- `getTransitionsToOfferForElement(...)` / availability helpers used by the render element.
- `checkAccessForSubmissionAndTransition(WorkflowInterface, AccountInterface, WebformInterface,
  TransitionInterface, $currentState = NULL, $submission = NULL): bool` — per-transition access; also
  invokes `hook_webform_workflow_element_transition_access_alter`.
- `checkAccessToUpdateBasedOnState(AccountInterface, WebformSubmissionInterface, array $element,
  string $stateId): AccessResultInterface` — per-state edit access (returns forbidden/neutral).
- `checkAccessForWorkflowAccessRules(...)` — evaluates the element's roles/users/permissions rules via
  Webform's `access_rules_manager`.
- Runs transitions and logs (dispatches the event below; optional `webform_submission_log.manager`).

Access it with `\Drupal::service('webform_workflows_element.manager')`.

## Event

`Event/WebformSubmissionWorkflowTransitionEvent` is dispatched by `EventSubscriber/TransitionEventSubscriber`
on each transition. Subscribe to react to state changes (e.g. custom notifications, external sync):
```php
// your.services.yml: tag { name: event_subscriber }
public static function getSubscribedEvents(): array {
  return [WebformSubmissionWorkflowTransitionEvent::class => 'onTransition'];
}
```
The event carries the submission, workflow, transition, and states.

## Tokens (`Hook/TokenHooks`)

Token type `webform_workflow` (name "Webform submissions - workflows"), dynamic tokens keyed by
`{element_id}:{transition_id}`:
- `webform_workflow:transition-url:<element>:<transition>` — URL to open the submission at that transition
  (user must log in).
- `webform_workflow:transition-link:<element>:<transition>` — rendered link.
- `webform_workflow:transition-url-secure-token:…` / `transition-link-secure-token:…` — URL/link that
  work **without login** IF the webform is configured to allow updating a submission via a secure token
  (a Webform feature the site must enable). Useful inside the transition email.

Note: the secure-token variants only bypass login when the site has explicitly enabled Webform's
"update a submission using a secure token" option — the module does not grant unauthenticated access on
its own.
