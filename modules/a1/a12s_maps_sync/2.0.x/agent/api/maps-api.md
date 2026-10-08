<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The MaPS API client and the import/state engine

## MapsApi service (`src/MapsApi.php`, service `a12s_maps_sync.maps_api`)

Thin Guzzle wrapper (`@http_client`). Configuration comes entirely from environment variables:

- `getBaseUrl()` → `getenv('A12S_MAPS_SYNC_API_URL')`, right-trimmed of `/`; throws
  `MapsApiException` if the variable is empty.
- Every call sets header `X-Maps-Api-Key: <getenv('A12S_MAPS_SYNC_API_KEY')>` and `timeout => 0`.

Endpoints (all `GET`, URL shape `<base>/<python_profile_id>/<resource>`):

| Method | Resource | Purpose |
|---|---|---|
| `isAvailable()` | `HEAD /_healthcheck` | Connectivity check (200 = up). |
| `getLinks($profile, $filters, $ordered)` | `/links` | Object relationships; filters limited to `source_id`, `target_id`, `type_id`. |
| `getObjects($profile, $filters, $limit, $fromTime, $countOnly)` | `/objects` | MaPS objects; filters whitelisted to `id, parent_id, source_id, code, nature, type, status, class` + `attribute_*`. |
| `getMedias($converter, …)` | `/medias` | Media metadata; filters `id, type, object_id, extension, from_time` + `attribute_*`. |
| `getLibraries($profile, $attributeId, $fromTime)` | `/libraries/{id}` | Library (taxonomy) tree. |
| `getConfiguration($profile, $filters)` | `/config` | Remote languages/statuses; adds default `id_language`. |
| `getObjectProperties($profile)` | `/object-properties` | Available object properties. |

`execute()` appends whitelisted filters as `http_build_query`, requires HTTP 200 (else
`MapsApiException`), and `Json::decode()`s the body. Filter keys are whitelisted server-side by the
client before being sent, and `from_time` enables **differential** imports (only data changed since
the last import). Injected consumers can use `MapsApiTrait::mapsApi()` for lazy access.

## AutoConfigManager (`src/AutoConfigManager.php`, `a12s_maps_sync.auto_config_manager`)

Builds a converter's mapping automatically from the remote MaPS attribute sets
(`processConverter()`, `manageAttributeSets()`), honoring the converter's `attribute_sets`,
`attributes_deny_list` and `libraries_management` auto-config. Also handles library→taxonomy and
content-translation setup. Used by the `auto_config` Drush commands and the converter Auto-config
tab.

## Import / batch / state engine

Imports are queued and processed through a persistent state rather than a single batch:

- **`State`** (`src/State.php`) — a singleton state object holding a **queue** of
  `StateQueueItem` (profile id + optional converter id) and at most one active **`StateBatch`**
  (`src/StateBatch.php`: batch id, profile, converter, remaining items, per-item iteration count).
  `addToQueue()` throws `StateQueueItemAlreadyInBatchException` if the same item is already batched
  (override with `--force-queue`).
- **`BatchService`** (`src/BatchService.php`) — static factories:
  `getProfileImportBatchDefinition()`, `getConverterImportBatchDefinition()`,
  `getEntityImportBatchDefinition()`, `getObjectImportBatchDefinition()`.
- **Locking** — per profile, keyed `a12s_maps_sync:lock:profile:<python_profile_id>` in Drupal
  state. `import_batch_size` / `batch_max_iterations_count` / `ignore_lock` (settings) tune size,
  retry cap and whether locking is bypassed.

## Handler managers used during import

`ObjectManager` / `MediaManager` / `LibraryManager` (`src/Maps/…`, services
`a12s_maps_sync.maps_object_manager` etc.) wrap the API results into `MapsObject` / `Media` /
`Library` value objects; the converter's chosen `maps_sync_handler` and per-field
`maps_sync_mapping_handler` plugins then write them into Drupal entities/fields. See
[../plugins/handlers.md](../plugins/handlers.md).

## Events (`src/Event/`)

`ProfileImportEvent`, `ConverterImportEvent`, `ConverterItemImportEvent` are dispatched around
imports so other modules can react to each imported profile/converter/item.
