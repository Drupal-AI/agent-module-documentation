<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Triggering, recipient resolution & delivery

## Detecting a transition (immediate path)
`workflow_notifications.module`:
- `hook_entity_insert` delegates to `hook_entity_update`.
- `_workflow_notifications_get_transition_details($entity)` skips Workflow's own entity types
  (`WorkflowTargetEntity::isWorkflowEntityType`), then for each Workflow field on the entity reads
  the pending `WorkflowTransition` (`$entity->$field->first()->getTransition()`), skipping empty
  transitions. It returns `from_sid`, `to_sid`, `wid`, `trigger`, and `days`.
- Trigger is `on_state_change` for a normal transition; for a **scheduled** transition
  (`$transition->isScheduled()`) it becomes `before_state_change` and `days` is the difference
  between the scheduled date and today.
- Matching rules are loaded via `WorkflowNotification::loadMultipleByProperties(from, to, wid,
  trigger, days)` and each is sent with `->sendMessages($trigger, $transition)`.

## Query — `WorkflowAbstractNotification::loadMultipleByProperties()`
`entityQuery('workflow_notify')`, `accessCheck(FALSE)`. When both from/to are given it matches the
exact state **or** `'all'` (orConditionGroup on each); filters `wid`, `when_to_trigger` (IN, array
allowed), and `days` when non-empty. `WorkflowNotification` overrides only the default
`$entity_type` to `workflow_notify` (SMS subclass → `workflow_sms_notify`).

## Time-based path (cron + queue)
- `workflow_notifications_cron()` runs at most once per calendar day (guarded by State
  `workflow_notifications.mail.last_run`). It loads rules with trigger in
  `['before_state_change','no_state_change']` and pushes each onto the queue
  `workflow_notifications.send` as `['entity' => $notification, 'notify' => 'mail']`.
- `Plugin/QueueWorker/ScheduleMailQueue` (`id: workflow_notifications.send`, `cron time: 60`)
  processes items: for `before_state_change` it loads `WorkflowScheduledTransition::loadBetween()`
  for the day window offset by `days`; for `no_state_change` it calls
  `_workflow_notifications_read_last_transitions()` (transitions from `days` ago whose entity is
  still in that state, deduped to the latest per entity). Each resolved transition is sent with
  `getDefaultTriggerId()` as the mail key.

## Recipient resolution — `sendMessages()`
1. Re-check the rule's `from_sid`/`to_sid` against the transition (respecting `'all'`); bail if no match.
2. Token-replace the receiver ids, message body, and subject (`replaceTokens()`).
3. Start with explicit ids (`convertToArray()` splits on `\r\n`).
4. If the author role (`WorkflowRole::AUTHOR_RID`) is selected, add `$entity->getOwner()`'s id.
5. `collectReceiverIdsFromRoles()` — active users (`status = 1`) having any selected role.
6. `filterReceiverIdsByEntity()` — when `participate` is set, intersect with users who actually own
   a transition on this entity.
7. Hand `$ids` + `{subject, message}` params to the subclass `send()`.

## Token replacement
`replaceTokens()` (in the abstract base) runs `\Drupal::token()->replace()` over ids/subject/body
with contexts `<entity-type> => $entity`, `workflow_transition` and `workflow_scheduled_transition`
=> `$transition`, `['clear' => TRUE]`. The form's token browser offers node/term/site/paragraph/
comment plus the two workflow-transition types. `workflow_notifications.tokens.inc` additionally
declares a `workflow_state` token type (`id`, `label`, `wid`) and handles field-property tokens
resolving to a `WorkflowState`.

## Mail send — `WorkflowNotification::send()`
Dedupes/sorts recipients into a comma string and calls
`\Drupal::service('plugin.manager.mail')->mail('workflow_notifications', $trigger, $to, $langcode,
$params)`. `hook_mail()` sets `from` = site mail, the subject/body from params, and
`Content-Type: text/html; charset=UTF-8; format=flowed; delsp=yes` (body renders as HTML). Success
and failure both log to the `workflow_notifications` channel and add a messenger message.
