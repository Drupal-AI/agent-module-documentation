<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `vbo_workflow_transition_` VBO action

Class `Drupal\vbo_workflow_transition\Plugin\Action\VboWorkflowTransition`
(`src/Plugin/Action/VboWorkflowTransition.php`). The entire module is this one class.

```php
#[Action(
  id: 'vbo_workflow_transition_',            // note the trailing underscore
  label: new TranslatableMarkup('Transition content to a new workflow state'),
  type: '',                                  // empty => applies to every entity type
)]
class VboWorkflowTransition extends ViewsBulkOperationsActionBase
  implements ContainerFactoryPluginInterface { … }
```

Injected services (constructor): `entity_type.manager`, `content_moderation.moderation_information`,
`current_user`, `content_moderation.state_transition_validation`, `datetime.time`,
`logger.factory`, the VBO `action_processor`, and `language_manager`.

Configuration keys (`defaultConfiguration()`): `transition_id`, `workflow_id`,
`revision_log_message` — all empty strings by default.

## Confirmation / config form — `buildConfigurationForm()`

This action is configurable (it implements `buildConfigurationForm`), so VBO shows a confirm page.

1. Removes the default submit button; it uses one button per transition instead.
2. `getAllResultsFromViewAsVboList($storage['views_bulk_operations'])` turns the selection into a
   concrete list. In **exclude mode** ("select all pages of results"), `list` is treated as the
   *excluded* rows: it promotes them to `exclude_list`, then walks each page with
   `actionProcessor->initialize($vbo)` + `actionProcessor->getPageList($page)`, stopping once
   `MAX_SCAN_COUNT = 500` rows are collected. Otherwise it returns `vbo['list']` as-is. Empty list
   or malformed rows (fewer than 4 id parts) → `unsupported()` error.
3. Loads each entity type's revisions via `RevisionableStorageInterface::loadMultipleRevisions()`
   (non-revisionable storage → `unsupported()`), skips entities with no `moderation_state`, gets
   the workflow via `moderationInfo->getWorkflowForEntity()`, and resolves the latest
   translation-affected revision with `getLatestRevision()`.
4. For each entity, `validator->getValidTransitions($entity, $this->currentUser)` yields the
   transitions **the current user is allowed to make**. These are grouped as
   `$transitions[$workflow_id]['transitions'][$transition_id]` with label, target-state label, and
   the eligible entities (each labeled with its current state, and latest state when different).
5. Builds a `details` element per workflow, a nested `details` per transition titled
   "@transition: N of M selected entities can make the transition to %to", an item list of the
   eligible entities, and a submit button whose `#name` is `submit:{transition_id}:{workflow_id}`.
   Adds a `revision_log_message` textarea (maxlength 255). If `exclude_mode` and the selection is
   ≥ `MAX_SCAN_COUNT`, a warning explains only the first 500 rows are guaranteed to contribute to
   the offered transitions (but all matching entities are still transitioned on submit).
6. If no transitions are available for anyone in the selection, `unsupported()` shows:
   *"None of the selected entities have any transitions available to them…"*.

## Choosing the transition — `submitConfigurationForm()`

Scans `$form_state->getValues()` for a key starting with `submit:`, splits it on `:` to recover
`transition_id` and `workflow_id`, and stores them plus the `revision_log_message` into
`$this->configuration`. Only the clicked button's key is present, so exactly one transition is
selected.

## Applying it — `execute(?EditorialContentEntityBase $entity)`

Runs once per selected entity in the VBO batch. Guards, in order:

- entity must be an `EditorialContentEntityBase` (else return NULL);
- `getWorkflow($entity)` must return a workflow whose `id()` equals `configuration['workflow_id']`
  (transition IDs are not unique across workflows, so the workflow must match) — else NULL;
- `getLatestRevision($entity)` must load (else NULL);
- the configured `transition_id` must appear in
  `validator->getValidTransitions($entity, $this->currentUser)`; the loop reads that transition's
  `to()` state. If not found, `$new_state` stays NULL and the method returns without saving.

When valid it applies the change and forces a new revision:

```php
$entity->set('moderation_state', $new_state->id());
$entity->setNewRevision(TRUE);
$entity->setRevisionLogMessage($this->configuration['revision_log_message']);
$entity->setRevisionCreationTime($this->dateTime->getRequestTime());
$entity->setChangedTime($this->dateTime->getRequestTime());
$entity->setRevisionTranslationAffected(TRUE);
$entity->setRevisionUserId($this->currentUser->id());
$entity->save();                              // EntityStorageException -> logged, error string returned
```

On success returns `"{label}||||{new_state_label}"` (the `MESSAGE_SEP` sentinel consumed by
`finished()`). A save failure is logged to the `vbo_workflow_transition` channel and returns a
per-entity error message.

## Access — `access()`

```php
public function access($object, ?AccountInterface $account = NULL, $return_as_object = FALSE) {
  // Which transition will run isn't known here, so the per-transition check is
  // done in execute(), skipping items the user can't moderate.
  $access = $object->access('update', $account, TRUE);
  return $return_as_object ? $access : $access->isAllowed();
}
```

`access()` requires the account's **entity `update`** access. The per-transition authorization is
enforced separately inside both `buildConfigurationForm()` and `execute()` via
`StateTransitionValidationInterface::getValidTransitions($entity, $currentUser)`, which honors
Content Moderation's `use {workflow} transition {transition}` permissions. A transition the current
user is not permitted to make is never offered and, even if the configuration named one, `execute()`
would find it absent from the valid set and skip the entity without saving.

## Batch completion — `finished()`

Overrides `ViewsBulkOperationsActionCompletedTrait::finished()` to collapse per-item messages into
one. It splits each `{label}||||{state}` result, then emits a single pluralized status message
("The following N entities have been transitioned to {state}: …"). Non-sentinel messages are shown
with their own type; an empty result set yields *"No entities given could be transitioned."*.

## Helpers

- `getWorkflow($entity, $showErrors)` — returns the moderation workflow for an
  `EditorialContentEntityBase`, or NULL (optionally warning that the entity is not editorial /
  not moderated).
- `getLatestRevision($entity, $showErrors)` — returns the latest **translation-affected** revision
  for the entity's language (uses `isLatestTranslationAffectedRevision()` and
  `getLatestTranslationAffectedRevisionId()`), so a later revision touching only another
  translation doesn't hide this language's real latest revision.
- `getWorkFlowStateLabel($workflow, $state_id)` — state label via the workflow type plugin.
- `unsupported($form, $message)` — adds an error and returns the form unchanged.
