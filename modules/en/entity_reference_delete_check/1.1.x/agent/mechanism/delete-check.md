<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Delete-check mechanism

How the notice on a delete confirm form is produced. Source: `entity_reference_delete_check.module`,
`src/Service/EntityReferenceUsageChecker.php`, `src/Dto/UsageResult.php`,
`entity_reference_delete_check.services.yml`.

## Trigger: the form alter

`entity_reference_delete_check_form_alter(&$form, $form_state, $form_id)` runs on every form. It:

1. Gets `$form_state->getFormObject()`; **returns immediately unless** it is a
   `\Drupal\Core\Entity\ContentEntityDeleteForm` (so it fires on core content-entity delete confirm
   forms only — not config entities, not other forms).
2. Loads the entity via `$form_object->getEntity()`.
3. Calls `checkUsages($content_entity)` on service
   `entity_reference_delete_check.entity_reference_usage_checker`.
4. If `$usage_result->isEmpty()`, returns (no change to the form).
5. Otherwise builds one list item per referencing field item list and appends a single render element
   `$form['entity_reference_delete_check'] = ['#markup' => $markup]`.

It adds **no `#validate`/`#submit` handler and does not modify the confirm/cancel actions** — the
deletion proceeds exactly as core would. The feature is a warning, not a guard.

## Reference discovery: EntityReferenceUsageChecker

`checkUsages(ContentEntityInterface)` returns `new UsageResult($this->checkEntityReferenceFieldUsage(...))`.

`checkEntityReferenceFieldUsage()` scans for references by brute-force iteration:

- Loops all entity type definitions from `entityTypeManager->getDefinitions()`; skips any that do not
  `entityClassImplements(FieldableEntityInterface::class)`.
- For each fieldable type, loops its bundles via `entityTypeBundleInfo->getBundleInfo($type_id)`.
- For each field from `entityFieldManager->getFieldDefinitions($type_id, $bundle_name)`, **keeps only**
  fields where `getType() === 'entity_reference'`, that are **not** `isComputed()`, and whose
  `getSetting('target_type')` equals the deleted entity's `getEntityTypeId()`. (So only the base
  `entity_reference` field type is matched — not e.g. `entity_reference_revisions`/`file`/`image`.)
- Gets the referencing type's storage (skips the type on `InvalidPluginDefinitionException` /
  `PluginNotFoundException`).
- Runs an entity query:
  `$storage->getQuery()->accessCheck(TRUE)->condition($field_name, $content_entity->id())`, adding
  `->condition($bundle_key, $bundle_name)` when the bundle differs from the entity-type id.
  **`accessCheck(TRUE)`** means only entities the current user may view are returned.
- `loadMultiple()` of the result ids, then collects each referencing entity's field item list
  (`$referencing_entity->get($field_name)`) into the returned array.

`UsageResult` (`src/Dto/UsageResult.php`) is a small DTO: `public readonly array $entityReferenceFields`
and `isEmpty()` (returns `!$this->entityReferenceFields`).

## Rendering the notice

Back in the form alter, for each field item list it reads the referencing entity, its entity type, and
bundle entity type, dispatches a `DeleteCheckEntityUrlEvent` to resolve a URL (see
[../api/url-event.md](../api/url-event.md)), and builds a translated string with placeholders:
`%entity_type_label`, `@entity_id`, `%bundle_label` (loaded via the bundle entity type storage), and
`%field_label`. If a URL was set, the item wraps the label in an `<a href=":entity_url">`. All values
go through `t()` placeholders (translation context `entity_reference_delete_check`), so labels are
escaped. The items become a `#theme => 'item_list'` element with a title naming the entity, rendered
with `renderer->renderInIsolation()` and assigned as `#markup`.

## Services

`entity_reference_delete_check.services.yml` declares:
- `entity_reference_delete_check.entity_reference_usage_checker` (the checker, three entity services).
- `DeleteCheckEntityUrlEventSubscriber` (autoconfigured `event_subscriber`).

No permissions file, no routing file, no config schema, no install hooks.
