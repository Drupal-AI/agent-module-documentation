# Manager service & delete batch (API)

## Service — `orphans_media.manager`

`Drupal\orphans_media\Manager\OrphansMediaManager` (`orphans_media.services.yml`).
Constructor args: `@entity_type.manager`, `@entity_type.bundle.info`, `@entity_field.manager`,
`@database`, `@logger.channel.orphans_media`. Grab it by the const `SERVICE_NAME`:

```php
$manager = \Drupal::service(\Drupal\orphans_media\Manager\OrphansMediaManager::SERVICE_NAME);
// == \Drupal::service('orphans_media.manager');
```

## Detection algorithm (what counts as "used")

`getUsedMediaIds(bool $excludeConfigEntityTypes = FALSE): array`
Iterates **all** entity type definitions (skipping the `configuration` group when
`$excludeConfigEntityTypes` is TRUE — the form passes TRUE). For each entity type,
`getFieldsReferencingMedia()` collects field names whose item definition
`getSetting('target_type') == 'media'`, then `fetchReferencedMediaIdsByEntityTypeId()` selects the
`{field}_target_id` column from each `{entity_type}__{field}` field-data table. Returns the unique
union of those target ids. **Only entity-reference fields are inspected** — media embedded in
rich-text, placed via Layout Builder, or stored in serialised/foreign tables is *not* seen as used
(see the caveat in [../start.md](../start.md)).

## Query methods

`getUnusedMedias(?int $currentPage = NULL, ?int $itemsPerPage = NULL, ?int $offset = NULL, array $bundles = [], string $sortField = 'created', string $sortOrder = 'DESC', bool $excludeConfigEntityTypes = TRUE, array $filters = []): array`
Runs an access-checked (`->accessCheck()`) entity query on `media`, adds `mid NOT IN (usedIds)`,
optional `bundle IN (…)`, the `$filters` (see below), and `->sort($sortField, $sortOrder)` /
`->range($offset, $itemsPerPage)`. Returns **loaded `Media` entities keyed by mid** (or `[]`).

`getTotalUnusedMedias(array $bundles = [], array $filters = [], bool $excludeConfigEntityTypes = TRUE): int`
Same conditions, returns `->count()->execute()`.

`getAvailableMediaBundles(): array`
Returns `[bundle_machine_name => label]` for all media bundles (from `entity_type.bundle.info`).

### `$filters` array keys (`applyFilters`)

| Key | Condition |
|---|---|
| `title` | `name` LIKE `%value%` — value passed through `Connection::escapeLike()` |
| `created_from` / `created_to` | `created >= strtotime("$value 00:00:00")` / `<= "$value 23:59:59"` |
| `updated_from` / `updated_to` | `changed >= …` / `<= …` |

Queries use parameterised entity-query conditions; the LIKE value is `escapeLike`-quoted.

## Deleting — batch

`deleteMediaBatch(array $references): void`
`$references` is `[mid => label]`. Delegates to
`OrphansMediaDeleteMediaEntityBatchProcess::processBatch()`
(`src/Batch/OrphansMediaDeleteMediaEntityBatchProcess.php`), which builds a `BatchBuilder` with one
`delete` operation per media id and a `finishBatch` callback, then calls `batch_set()`. Run it inside
a form/controller (or drive the batch API yourself) so the batch actually executes.

Per-item `OrphansMediaDeleteMediaEntityBatchProcess::delete([$mid => $label], &$context)`:

1. Loads the media by id (`entity_type.manager` → `media` storage).
2. Dispatches the **pre-delete** event, clones the entity, calls `$media->delete()`, dispatches the
   **post-delete** event with the clone (see [../events/delete-events.md](../events/delete-events.md)).
3. Adds a status or error message via the `messenger` service; `EntityStorageException` is caught and
   surfaced as an error.

Authorisation for the operation is the route permission `access orphans media delete`
(see [../forms/delete-form.md](../forms/delete-form.md)).
