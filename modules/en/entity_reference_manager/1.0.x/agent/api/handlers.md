<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Service & handler architecture

The merge engine is a small service-collector: one manager delegates to a per-entity-type handler. Everything runs on core `entity_type.manager` / `entity_field.manager`; there is no plugin type, no config, no external calls.

## `Service\ContentMergeManager` (service `entity_reference_manager.manager`)

Constructor args (`entity_reference_manager.services.yml`): `@entity_type.manager`, `@database`, `@logger.channel.default`, `@lock`, and `!tagged_iterator entity_reference_manager.handler`. `registerHandler()` also appends handlers (called by `ContentMergeServiceProvider::alter()`, which re-adds every service tagged `entity_reference_manager.handler`).

- `getHandler(EntityInterface)` — returns the first registered handler whose `supports()` returns TRUE, else NULL.
- `analyze($source, $target, $options)` — delegates to the handler's `analyze()`; throws `\InvalidArgumentException('Unsupported entity type.')` when no handler matches.
- `execute($source, $target, $options)` — acquires the named **lock** `entity_reference_manager` (throws `\RuntimeException('Merge already running.')` if held), opens a DB transaction (`database->startTransaction()`), calls the handler's `execute()`, and releases the lock in both success and error paths (re-throwing on error).

## `Handler\ContentMergeHandlerInterface`

Three methods: `supports(EntityInterface): bool`, `analyze($source, $target, $options): array`, `execute($source, $target, $options): void`. Implemented by `NodeMergeHandler`, `TaxonomyTermMergeHandler`, `MediaMergeHandler` (each a tagged service **and** `ContainerInjectionInterface`, constructed with `@entity_type.manager` + `@entity_field.manager`). The three handlers are near-identical; they differ only in `supports()` and the `target_type` they match.

- `supports()`: `NodeMergeHandler` → `$entity instanceof NodeInterface`; `TaxonomyTermMergeHandler` → `TermInterface`; `MediaMergeHandler` → `MediaInterface`.

## How references are found (`analyze()`)

For each source, iterate `entityFieldManager->getFieldMapByFieldType('entity_reference')` over every entity type / field / bundle; keep only field definitions whose `settings['target_type']` equals this handler's type (`node` / `taxonomy_term` / `media`) and (if the field restricts `handler_settings['target_bundles']`) whose set includes the **target** bundle. Count current references via `getStorage()->loadByProperties([$fieldName => $src->id()])` and matching `target_id`; when `update_revisions` and the type is revisionable, count all-revisions via an entity query with `->accessCheck(FALSE)->allRevisions()->condition($fieldName, $src->id())`. Returns `{entity_type, source, target, fields[], message}` where each `fields[]` row is `{entity_type, field, count, count_revisions}` (taxonomy handler also adds `bundle`).

## How the merge is applied (`execute()` → Batch API)

`execute()` builds a `batch_set()` operation list (title e.g. *"Merging node references…"*, `finished` = `batchFinished`):

- **`batchUpdateFieldReferences($entityType, $fieldName, $source_id, $target_id)`** (static) — loads referencing entities by property, and for each value whose `target_id` == source rewrites it to the target, dedupes values by `target_id`, and `$entity->save()`.
- **`batchUpdateFieldReferencesInRevisions(...)`** (static, only when `update_revisions` + revisionable) — same rewrite across all revisions via `loadRevision()`, saved with `setNewRevision(FALSE)` and `accessCheck(FALSE)` on the revision query.
- **`batchDeleteSource($entity_type_id, $source_id)`** (static, appended per source only when `keep_source` is FALSE) — loads and `$entity->delete()`s the source.
- **`batchFinished()`** — adds a success/failure status message.

Note: the batch callbacks are static and resolve `\Drupal::entityTypeManager()` directly, and rewrite matching is by integer `target_id` compare.

## Extending

To support another entity type, register a service implementing `ContentMergeHandlerInterface` tagged `{ name: entity_reference_manager.handler }` (constructor `@entity_type.manager`, `@entity_field.manager`). `supports()` should match your entity interface and the field scan should filter on your `target_type`. Note the form (`ContentMergeForm`) and Drush command hard-code the three built-in types in their UI/option lists, so a new handler is reachable only via a custom caller of `ContentMergeManager` unless you also alter the form.
