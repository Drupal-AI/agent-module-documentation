<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Orphans Media (orphans_media) — agent index

Finds and deletes **media entities that nothing references**. A single admin form at
`/admin/config/media/orphans-media` (route `orphans_media.delete`, permission
`access orphans media delete`, menu link under *Configuration → Media*) lists the unreferenced
media, lets you filter by bundle / title / created + updated date range and sort the table, then —
after a confirmation step — deletes the selected items through a Drupal **batch**. The detection
logic lives in the service `orphans_media.manager` (`OrphansMediaManager`): it builds the set of
*used* media ids by scanning every content entity type for fields whose `target_type` is `media`,
reading each `{entity_type}__{field}` table's `{field}_target_id` column, then returns the media
whose id is `NOT IN` that set (with the chosen bundle/filter conditions). Deletion runs one batch
operation per media id, and around each `$media->delete()` it fires a **pre-delete** and a
**post-delete** event so integrators can log, notify, or clean up related data.

> **Detection is by entity-reference field only — treat the list as review candidates, not a delete
> queue.** `getUsedMediaIds()` counts a media item as "used" only when it is referenced through an
> entity-reference field whose target type is `media`. It does **not** find media referenced from
> inside rich-text fields as an embedded `<drupal-media>`, from Layout Builder section / inline-block
> configuration, from serialised settings, or from another module's own tables. Media used only in
> one of those ways looks orphaned and is not. Deletion is irreversible and a missing image on a live
> page is a visible failure — back up first and confirm how the site actually references media before
> deleting.

- Depends on: `drupal:media`. No other dependencies; the package ships no `composer.json`.
- Core: `^10 || ^11`. Package: `Media`.
- Settings / `configure` route: `orphans_media.delete` (the delete form doubles as the configure
  link).
- Permissions: one — `access orphans media delete`. No drush commands. No plugin types. No config
  schema (`config/` directory absent). No hooks, no `.install` / `.module`.
- Provides two events (`pre` / `post` delete) for custom deletion workflows.

## What you'd do → where

- **Understand or use the admin delete form — route, permission, filters, sort, confirm step** →
  [forms/delete-form.md](forms/delete-form.md)
- **Call the detection / delete logic from code (list unused media, count them, run the delete
  batch, list media bundles)** → [api/manager.md](api/manager.md)
- **React to a media deletion (pre / post-delete event subscriber)** →
  [events/delete-events.md](events/delete-events.md)

## Key facts (real machine names)

- Route: `orphans_media.delete` → path `/admin/config/media/orphans-media`, `_form`
  `Drupal\orphans_media\Form\OrphansMediaDeleteForm`, `_permission: 'access orphans media delete'`.
  Menu link `orphans_media.delete` (parent `system.admin_config_media`).
- Permission: `access orphans media delete`.
- Service: `orphans_media.manager` = `Drupal\orphans_media\Manager\OrphansMediaManager`
  (const `SERVICE_NAME = 'orphans_media.manager'`; args `@entity_type.manager`,
  `@entity_type.bundle.info`, `@entity_field.manager`, `@database`, `@logger.channel.orphans_media`).
  Logger channel service: `logger.channel.orphans_media`.
- Manager methods: `getUnusedMedias()`, `getTotalUnusedMedias()`, `getUsedMediaIds()`,
  `getAvailableMediaBundles()`, `deleteMediaBatch()`.
- Batch worker: `Drupal\orphans_media\Batch\OrphansMediaDeleteMediaEntityBatchProcess`
  (`processBatch`, `delete`, `finishBatch`).
- Form: id `orphans_media_delete`, class extends `ConfirmFormBase`; traits `ListFormTrait`
  (list + filters) and `ConfirmFormTrait` (confirm step). Default items per page: `25`.
- Events: `orphans_media.pre_delete_media_entity` (`OrphansMediaPreDeleteMediaEntityEvent`) and
  `orphans_media.post_delete_media_entity` (`OrphansMediaPostDeleteMediaEntityEvent`); event-name
  constants `PRE_DELETE_EVENT` / `POST_DELETE_EVENT` on
  `OrphansMediaDeleteMediaEntityEventInterface`. Both carry public `$media`; the post event receives
  a clone captured before deletion.
