<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Scheduling and processing transitions in code

## The `scheduled_transition` content entity

An internal `@ContentEntityType` (`base_table`/`data_table` = `scheduled_transition`), one row
per pending/processed change. It is not fieldable/bundled. Notable base fields:

- `entity` — dynamic_entity_reference to the target content entity.
- `entity_revision_id` (int), `entity_revision_langcode` (language) — the revision + language.
- `workflow` (ref to `workflow`), `moderation_state` (string) — the target state.
- `transition_on` (timestamp) — when it should run.
- `is_processed` (bool), `processed_date`, `processed_revisions`, `locked_on`, `options` (map).

## Create one (schedule a transition)

Use the factory `ScheduledTransition::createFrom()`:

```php
use Drupal\scheduled_transitions\Entity\ScheduledTransition;
use Drupal\workflows\Entity\Workflow;

$workflow = Workflow::load('editorial');
$node = \Drupal::entityTypeManager()->getStorage('node')->load($nid); // a moderated, revisionable entity
$when = new \DateTime('@' . (\Drupal::time()->getRequestTime() + 3600)); // 1h from now

$st = ScheduledTransition::createFrom(
  $workflow,
  'archived',            // target moderation state id
  $node,                 // the revision/entity to transition
  $when,
  \Drupal::currentUser()->getAccount(),
);
$st->save();
```

`createFrom($workflow, $state, $revision, \DateTimeInterface $dateTime, $author)` chains
`setState()`, `setEntity()`, `setTransitionDate()`, `setAuthor()`. Setters also exist:
`setEntityRevisionId()`, `setEntityRevisionLanguage()`, `setTransitionTime(int)`,
`setOptions([ScheduledTransition::OPTION_RECREATE_NON_DEFAULT_HEAD => TRUE])`.

## Services

- `scheduled_transitions.utility` (`ScheduledTransitionsUtilityInterface`) —
  `getTransitions($entity)` lists an entity's transitions; `getBundles()` returns enabled
  moderated bundles; `getTargetRevisionIds($entity, $language)`; `generateRevisionLog()`.
- `scheduled_transitions.jobs` (`ScheduledTransitionsJobsInterface`) — `jobCreator()` queues all
  **due** (`transition_on <= now`, not processed, unlocked) transitions onto the
  `scheduled_transition_job` queue; `cleanupExpired()` deletes retained-but-expired ones.
- `scheduled_transitions.runner` (`ScheduledTransitionsRunnerInterface`) —
  `runTransition($scheduledTransition)` performs one transition now: dispatches the
  `NEW_REVISION` event to pick the revision, creates a new default revision in the target state
  with the templated log message, sets `is_processed`, and deletes the record unless
  `retain_processed.enabled` is true.

## Processing due transitions

- Let cron do it (`automation.cron_create_queue_items: true`) — the `scheduled_transition_job`
  QueueWorker (cron time 900s) runs each queued job through the runner.
- Or force queueing now: `drush scheduled-transitions:queue-jobs` then `drush queue:run scheduled_transition_job`.
- Or run one immediately in code: `\Drupal::service('scheduled_transitions.runner')->runTransition($st);`
