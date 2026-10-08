<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Workflow Clean Up form

Route **`workflow.cleanup.settings`** → `/admin/config/workflow/workflow/cleanup`
(permission `administer workflow`). Form class `WorkflowCleanupSettingsForm` (a plain `FormBase`;
this module ships **no** config or schema).

## What it lists

It loads all `workflow_state` config entities and splits them into two `details` groups:

- **Orphaned States** — `!$state->getWorkflow()` (the parent workflow no longer exists).
- **Inactive (Deleted) States** — `$state->getWorkflow()` exists but `!$state->isActive()`.

Each row is a checkbox keyed by the state id (`sid`).

## What submitting does

For every checked state, `submitForm()`:

1. Loads all `workflow_config_transition` entities and **deletes** those whose `from_sid` or
   `to_sid` equals the state's `sid` (reports the count).
2. **Deletes** the state itself (reports it).

(History-record deletion is a TODO in the code and currently not performed.)

## Equivalent programmatic cleanup

```php
use Drupal\workflow\Entity\WorkflowState;
use Drupal\workflow\Entity\WorkflowConfigTransition;

foreach (WorkflowState::loadMultiple() as $sid => $state) {
  $orphan   = !$state->getWorkflow();
  $inactive = $state->getWorkflow() && !$state->isActive();
  if ($orphan || $inactive) {
    foreach (WorkflowConfigTransition::loadMultiple() as $t) {
      if ($t->getFromSid() === $sid || $t->getToSid() === $sid) { $t->delete(); }
    }
    $state->delete();
  }
}
```

## Notes

- Intended as a one-off maintenance tool; the info file says **do not enable on production**.
- It does not create or alter workflows — it only deletes stale states/transitions.
