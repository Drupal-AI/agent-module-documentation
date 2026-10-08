<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API: how integrity checks fire, and how to influence them

There is **no callable "check this entity" API for other modules** and no report route. Enforcement is
wired in `entity_usage_integrity.module` via `hook_form_alter`, which (a) calls the form-open handlers
`ViewedDeleteForm`, `ViewedEditForm`, and (if `content_moderation` is on) `ModerationStateChangeConfirmDialog`,
and (b) appends `entity_usage_integrity_validate` to `$form['#validate']`, which runs `SubmittedEditForm`
and (if `content_moderation` is on) `SubmittedModerationStateForm`. Each handler decides applicability,
builds/loads the entity, asks the validator, and messages the user.

## Status logic — `IntegrityValidator::getStatus($source, $target, $skipUnpublished)`
Per relationship (source references target):
- source not published **and** not a draft → `ignore` (inactive relation).
- source is a draft **and** `ignore_unpublished_entities` is on → `ignore`.
- target is NULL (no longer exists) → currently returned as `ignore` (a `@todo` marks this to become a
  real `broken` status later).
- otherwise → `valid` if target is published, else `invalid`.

`isPublished()` returns TRUE for entities that are not `EntityPublishedInterface` (assumed published);
`isDraft()` uses `content_moderation.moderation_information` + `moderation_state === 'draft'`.

## `IntegrityValidator::getValidatedUsageRelations($entity, $context, $skipUnpublished)`
Returns a `RelationCollections` (buckets keyed by status: `valid` / `invalid`; query with
`hasRelationsWithStatus()` / `getRelationCollectionWithStatus()`).
- Always checks relations where `$entity` is the **target** (sources referencing it), using
  `EntityUsage::listDefaultRevisionsForSources()`.
- Only in context `EDIT_FORM_VIEW` also checks where `$entity` is the **source**
  (`listDefaultRevisionsForTargets()`), and at save time reads not-yet-persisted references straight
  from entity fields via `listDefaultRevisionsForTargetsFromFields()`.
- Paragraph targets are walked up via `getParentEntity()` / `parent_field_name` to their non-paragraph
  host (orphaned paragraphs → treated as missing). Translatable relatives are switched to the current
  entity's langcode when a matching translation exists.

Contexts (`IntegrityValidationContext`): `entity_edit_form_view`, `entity_delete_form_view`,
`entity_save`. Only the **default (live) revision** is validated; pending/forward revisions are skipped
(`isDefaultRevision()` checks).

## When each handler applies (`isApplicable()`)
- `ViewedEditForm`: `ContentEntityFormInterface`, operation `edit`/`default`, HTTP **GET**, entity not
  new. Always warns (mode-independent).
- `SubmittedEditForm`: `ContentEntityFormInterface`, operation `edit`/`default`, entity not new, **and
  mode == block**. Sets `$form_state->setErrorByName(...)` to block the save.
- `ViewedDeleteForm`: `ContentEntityFormInterface`, operation `delete`. Block mode disables the submit
  button; warning mode only warns.
- `SubmittedModerationStateForm` / `ModerationStateChangeConfirmDialog`: forms
  `content_moderation_entity_moderation_form` / `content_moderation_info_block_form`; the dialog runs in
  warning mode, the submit validator in block mode. Only present when `content_moderation` is enabled.

## Extension point — the applicability event
`ViewedEditForm::isApplicable()` and `ViewedDeleteForm::isApplicable()` (and the moderation dialog)
dispatch `EntityUsageIntegrityEvents::APPLICABILITY_CHECK`
(`'entity_usage_integrity.applicability_check'`) with an
`EntityUsageIntegrityApplicabilityCheckEvent`. Subscribe and call `$event->setApplicable(FALSE)` to
disable the check on a specific form; read the form via `$event->getFormState()`. This is the only
supported way for other modules to change the module's behavior.

```php
// my_module.services.yml: tag a class as an event_subscriber, then:
public static function getSubscribedEvents(): array {
  return [\Drupal\entity_usage_integrity\Event\EntityUsageIntegrityEvents::APPLICABILITY_CHECK => 'onCheck'];
}
public function onCheck(\Drupal\entity_usage_integrity\Event\EntityUsageIntegrityApplicabilityCheckEvent $event): void {
  $form = $event->getFormState()->getFormObject();
  if ($form instanceof \Drupal\Core\Entity\ContentEntityFormInterface
      && $form->getEntity()->getEntityTypeId() === 'my_type') {
    $event->setApplicable(FALSE);
  }
}
```

## Broken relations
When a usage row references an entity that no longer exists, the handler logs an error to
`logger.channel.entity_usage_integrity` and adds a warning listing the missing `/{type}/{id}` paths.
This never blocks (it is auto-corrected on the next save of the source) and is meant to flag targets
worth restoring.
