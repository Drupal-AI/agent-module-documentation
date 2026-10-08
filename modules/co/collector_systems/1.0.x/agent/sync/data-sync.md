<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sync subsystem: import, images, cron & queue

The module keeps a **local mirror** of the remote Collector Systems data in its own DB tables and
refreshes it either manually (Batch API) or automatically (cron + queue).

## The API client — `CollectorSystemsGetApiData`

Service `collector_systems.collector_systemsts_get_api_data` (note the vendor's typo in the service
id). One method per entity/count, each hand-rolling a `curl` call to an OData URL built from
`Csconstants::Public_API_URL . {account_guid} . '/' . {Entity} . '?$filter=SubscriptionId eq {id}…'`.
Examples: `getApiObjectsData()`, `getApiArtistsData()`, `getApiObjectImagesData($top,$skip)`,
`getApiTotalObjectsCount()`, plus per-entity image and count fetchers. `getApiObjectsData()` can
build a large dynamic `$expand`/`$select` URL from the admin-selected object fields
(`getDynamicUrlForEndpoint()` — a ~1500-line `switch` mapping each Collector Systems field to its
OData expansion path across Art/Archive/Biology/Geology/Car/Jewelry… model namespaces).

Security-relevant facts: **all** requests set `CURLOPT_SSL_VERIFYPEER = true` and
`CURLOPT_SSL_VERIFYHOST = 2` (TLS is verified). URLs are composed only from hardcoded constants +
admin-only config values (no request-supplied host/URL), so there is no SSRF surface. On HTTP 403
the client calls `exit()`.

## Manual import — `CreateTablesForm`

Route `collector_systems.create_tables_form` → `/admin/collector-systems/create-tables-form`,
`_permission: access administration pages`. A radios choice: **Reset and Create Dataset** vs
**Update Dataset**. `submitForm()`:
1. `DataSyncManager::clear_tables_data($btn_action)` — on reset, drops/empties the data tables.
2. `DataSyncManager::custom_api_integration_create_tables($btn_action)` — (re)creates them.
3. Records `SyncStarted` in `collector_systems_cssynced`.
4. `getDataForProcessing()` → `startBatchProcess()` — a Batch API run whose operations each call
   `DataSyncManager::processItem($item, $btn_action)` (fetches a page from the API and upserts rows).
   `batchFinished()` records `SyncCompleted` and redirects to the dashboard.

## Image sync — `SyncImagesForm` + `ImagesSyncManager`

`Form/SyncImagesForm` (service `collector_systems.images_sync_manager`) downloads attachment images.
Images can be stored **to a public directory** (`public://collector_systems/images`, path written to
`*_path` columns) or **as base64 BLOBs in the DB** (the `main_image_attachment`, `object_image_attachment`,
`thumb_size_URL`, … `blob/big` columns), selected by the `save_images_on_automatic_sync_to` setting
(`save_to_directory` / `save_to_database`). `hook_uninstall` deletes the image directory.

## Automatic sync — cron + queue

- `Form/AutomaticSyncSettingsForm` sets `collector_systems_automatic_sync` (frequency:
  `manually` / `every-night` / `7-days` / `14-days` / `30-days` / `90-days` / `annually`) and
  `collector_systems_automatic_sync_time`.
- `hook_cron` (`collector_systems.module`): when the frequency's schedule matches the current
  hour **and** the queue is empty, calls `Synchronizer::addItemsToQueue()`, which enqueues one item
  per data page plus per-image items into the `collector_systems_sync_queue_worker` queue (item
  `queue_type` ∈ `dataset` / `object_images` / `other_images`).
- **QueueWorker** `collector_systems_sync_queue_worker` (`Plugin/QueueWorker/SyncQueueWorker`,
  `cron = {time = 180}`) — `processItem()` dispatches by `queue_type` to
  `DataSyncManager::processItem()` / `ImagesSyncManager::processItem_ObjectImages() /
  _OtherImages()`, and when the queue empties records the automatic `SyncCompleted`.
- **Parallel runner**: when items remain, `hook_cron` fires **3** fire-and-forget `curl` calls
  (1-second timeout) to the queue-runner route so items drain in parallel during the cron window.

## Queue-runner route — `SyncQueueProcessController`

Route `collector_systems.sync_queue_process` → `/collector-systems/sync-queue-process/{key}`,
guarded by a **custom access callback** (no Drupal permission — it's hit by an unauthenticated
loopback curl). Access is `AccessResult::allowedIf(hash_equals(getQueueProcessKey(), $key))` with
`setCacheMaxAge(0)`. `getQueueProcessKey()` lazily generates a **`Crypt::randomBytesBase64(55)`**
secret stored in Drupal **state** (`collector_systems.sync_queue_key`) — the same shared-secret
pattern core uses for `/cron/{cron_key}`. `run()` claims and processes one queue item per request
(releasing it back on exception). The comparison is constant-time and the key is high-entropy and
never empty, so the route is not anonymously reachable without the secret.

## Sync tracking table

`collector_systems_cssynced` records `LastSyncedBy`, `SyncStarted`, `SyncCompleted`, `SyncType`
(`data` / `images` / `data_and_images`), `SyncTrigger` (`manual` / `automatic`) and a
human-readable `SyncCompletionTime`. `collector_systems_update_CSSynced_table()` in the `.module`
upserts these; `DashboardController` reads them to render the dashboard status panel.
