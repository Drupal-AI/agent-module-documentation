# TMGMT Extension Suit — actions, queues, track-changes

## Bulk Actions (core `Action` plugins, `type = tmgmt_job`)
Shipped as `system.action.*` config in `config/install`; surfaced as a VBO bulk form on the
`tmgmt_job_overview` view via `hook_views_pre_view` (`tmgmt_job_bulk_form`). Each action has a
`confirm_form_route_name` and does its real work after that confirm form.

| Action id | Class | Confirm route (`/admin/tmgmt/...`) |
|---|---|---|
| `tmgmt_extension_suit_request_translation_job_action` | `RequestTranslationJobAction` | `extension-approve-action-request-translation` |
| `tmgmt_extension_suit_download_job_action` | `DowloadJobAction` | `extension-approve-action-download` |
| `tmgmt_extension_suit_cancel_job_action` | `CancelJobAction` | `extension-approve-action-cancel` |
| `tmgmt_extension_suit_delete_job_action` | `DeleteJobAction` | `extension-approve-action-delete` |
| `tmgmt_extension_suit_clear_job_items_data_action` | `ClearJobItemsDataAction` | `extension-approve-action-clear-job-items-data` |

All confirm routes require `_permission: administer tmgmt`. Actions extend `BaseJobAction`, which stashes
the selected entities in a `PrivateTempStore` (per-action store name) and redirects to the confirm form
(`BaseTmgmtActionApproveForm` subclasses). Note: `BaseJobAction::access()` returns `TRUE`
unconditionally, so access is enforced by the `administer tmgmt`-gated view/routes, not the action.

## QueueWorkers (cron, `time = 30`, extend `QueueWorkerLockedBase`)
- **`tmgmt_extension_suit_upload`** (`JobUpload`) — loads the job, and if its translator plugin is an
  `ExtendedTranslatorPluginInterface`, calls `requestTranslationExtended($job, $data)`.
- **`tmgmt_extension_suit_download`** (`JobDownload`) — loads job (+ optional job item / file); calls
  `isReadyForDownload()`→`downloadTranslation()` for job translations, or
  `isAttachmentReadyForDownload()`→`downloadAttachmentTranslation()` when a `fid` is present.

Enqueue via `FlowScheduler` (`tmgmt_extension_suit.utils.flow_scheduler`) →
`UniqueQueueItem` (`tmgmt_extension_suit.utils.queue_unique_item`, de-dupes). See
[../extend/translator-plugin.md](../extend/translator-plugin.md).

## Track-changes flow (`tmgmt_extension_suit_entity_update`)
Runs when a translatable source entity's default translation is saved and `do_track_changes` is on:
1. Query `tmgmt_job` / `tmgmt_job_item` for active/rejected/finished jobs containing this entity
   (parameterized DB select on `item_type`/`item_id`).
2. For each job whose translator is extended and whose `{translator}_{targetLang}` pair is enabled in
   state, recompute each item's md5 `tes_source_content_hash`.
3. If the hash changed: `resetData()`, update the hash, set item state ACTIVE, save; mark job for reopen.
4. Reopen the job (state ACTIVE) and `scheduleUpload()` it. Also invokes
   `hook_tmgmt_extension_suit_updated_entity_jobs($job_ids, $translator_id)` and passes its return as the
   upload payload.

Note (defense-in-depth, not a finding): the DB queries are parameterized entity/DB-API queries and every
trigger sits behind `administer tmgmt` / normal content-edit access; there is no untrusted-input sink.
