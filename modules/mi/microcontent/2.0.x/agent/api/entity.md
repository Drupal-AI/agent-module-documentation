# Micro-content entity API

## The `microcontent` entity
`Drupal\microcontent\Entity\MicroContent` extends `EditorialContentEntityBase`, uses `EntityOwnerTrait`.
Tables: `microcontent` / `microcontent_field_data` (+ `microcontent_revision` / `microcontent_field_revision`).

Entity keys: `id`, `revision` = `revision_id`, `bundle` = `type`, `label` = `label`, `langcode`,
`uuid`, `status`/`published` = `status`, `uid`/`owner` = `uid`. Revision metadata keys: `revision_uid`,
`revision_timestamp`, `revision_log`.

Base fields (added on top of the editorial base): `label` (string, required, translatable, revisionable,
max 255), `uid` (author, entity_reference to user), `status` (published checkbox). Extra fields per type
come from Field UI.

## Create / load / query
```php
$storage = \Drupal::entityTypeManager()->getStorage('microcontent');

// Create.
$item = $storage->create([
  'type'   => 'promo',            // bundle = a microcontent_type id
  'label'  => 'Spring sale',
  'status' => 1,
  // 'uid' defaults to current user via EntityOwnerTrait.
  // ...any fields added to the 'promo' type.
]);
$item->save();

// Load / query.
$item = $storage->load($id);
$ids  = $storage->getQuery()->accessCheck(TRUE)
  ->condition('type', 'promo')->condition('status', 1)->execute();
```

## Revisions & moderation
- `show_revision_ui = TRUE`; per-type `new_revision` sets the default. Force a new revision with
  `$item->setNewRevision(TRUE)` and set `$item->setRevisionLogMessage(...)` / `setRevisionUserId(...)`.
- Content Moderation is supported via the `moderation` handler
  (`EntityHandlers\MicrocontentModerationHandler`); enable the core Content Moderation workflow for the
  `microcontent` entity type to use it.

## Rendering
- `view_builder` = `MicrocontentViewBuilder`; theme hook `microcontent`
  (`templates/microcontent.html.twig`) exposes `microcontent`, `name`, `content`, `view_mode`, and the
  type's `type_class`. A `preview` view mode ships as optional config.

## Integrations
- **JSON:API**: `microcontent_jsonapi_microcontent_filter_access()` allows the "among all" filter with
  `view unpublished microcontent` and "among published" with `access content`.
- **Backfill formatter**: `Plugin/BackFillQuery/MicroContentHandler` (`id default:microcontent`) extends
  `backfill_formatter`'s `PermissionStatusHandler`, using `view unpublished microcontent` — lets a
  reference field show a fallback value. Requires the optional `drupal/backfill_formatter` module.
