<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cron, queue workers, continuous jobs & Views fields

Source: `bureauworks_tmgmt.module`, `src/Plugin/QueueWorker/*`, `src/Helper/QueueGateKeeper.php`,
`src/Helper/BureauCacheHelper.php`, `src/Plugin/views/field/*`.

## Cron — `bureauworks_tmgmt_cron()`

Runs two things each cron:
1. `QueueGateKeeper::requeueCachedNodes()` — re-queues nodes that were deferred by the continuous-job
   gatekeeper (see below).
2. `process_ongoing_job_items()` — pages (50 at a time) over `tmgmt_job_item` in state ACTIVE or REVIEW and,
   for each not already in flight (dedup cache key `bureauworks_tmgmt.fetch_queued.<id>`, TTL 600s), pushes
   `{job_item_id, timestamp}` onto the **`bureauworks_tmgmt.fetch_queue`** queue.

So translation delivery is **polled from the server side** — there is no inbound HTTP endpoint/callback. All
API calls are outbound and authenticated with the cached `X-AUTH-TOKEN`.

## Queue workers (both `cron = {"time" = 30}`)

- **`bureauworks_tmgmt.fetch_queue`** — `BureauApiFetchQueueWorker::processItem()`. Loads the job item,
  skips it unless its job's translator id is `bwx`, and calls the translator plugin's `importAndCleanup()`
  (guarded by `method_exists`). Always clears the `fetch_queued.<id>` dedup key in a `finally`.
- **`bureauworks_tmgmt.job_queue`** — `BureauApiJobQueueWorker::processItem()`. Continuous-job re-submission:
  loads the queued node, finds **continuous** `tmgmt_job` rows for the `bwx` translator and the source→target
  language pair (`getContinuousJobsForLanguagePair`), and — if there is no ongoing job item already
  (`findOngoingJobItemForNode`) — creates a new `tmgmt_job_item` (`plugin: content`, `item_type: node`) and
  calls `requestJobItemTranslation()` on the plugin. Uses `shouldDiscardQueueItem()` (compares the queue
  timestamp against the existing item's creation/change time) to decide whether to drop or defer a duplicate.

## Continuous jobs — `hook_entity_update` + `QueueGateKeeper`

`bureauworks_tmgmt_entity_update()` → `on_node_update()` fires on **node** saves of translatable nodes and
enqueues to `job_queue` **only** when all guards pass:
- not marked "cached for skip" (`is_cached_for_skip`, a short-lived cache set right after the module itself
  saves an auto-accepted/auto-saved translation, to avoid feedback loops);
- not an inferred translation *addition* or *deletion* (language-count comparison vs `$entity->original`);
- has real translatable-field changes (`has_translation_changes`, limited to an allow-list of core field
  types — string/text/date/link/file/image/etc.);
- the entity is **already tracked** (`is_entity_tracked` — a non-aborted `tmgmt_job_item` exists for this
  node + source language). Untracked nodes are never auto-submitted.

`QueueGateKeeper` (static helper) manages: per-node/language queue dedup mirror
(`bureauworks_tmgmt.node_<id>_<lang>`, permanent, cache-tagged `bw_node:<id>_<lang>`), a
"nodes to requeue" cache (`bureauworks_tmgmt.nodes_to_requeue`) for deferred items, an available-language-code
cache (20 min), and the short-lived "entity update" skip cache
(`bureauworks_tmgmt.entity_update_<type>_<id>_<lang>`, 180s). `BureauCacheHelper` is a thin static wrapper
around `\Drupal::cache()` (set/get/delete/invalidateTags) used throughout.

## Views fields (`hook_views_data_alter`)

Attaches two computed fields to `tmgmt_job_item` (real field `tjiid`):
- **`bw_project_name`** → `BureauWorksProjectNameField::render()` returns the first non-empty
  `remote_identifier_3` (Bureau Works project name) across the item's remote mappings, else `N/A`.
- **`bw_last_workflow_delivered`** → `BureauWorksLastWorkflowDeliveredField::render()` returns the remote data
  `last_delivered_workflow` plus a formatted `last_delivered_workflow_timestamp`, else `N/A`.

Both wrap output in `Html::escape()`. `hook_uninstall` strips both fields from the
`tmgmt_translation_all_job_items` view.
