TMGMT Extension Suit adds queue-based bulk upload/download of translation jobs, "track changes" auto-resubmission of edited source content, and a set of bulk actions to the Translation Management Tool (TMGMT) job workflow.

---

The module layers extra automation on top of TMGMT for translator plugins that opt in by implementing its `ExtendedTranslatorPluginInterface` (extends TMGMT's `TranslatorPluginInterface` with `requestTranslationExtended()`, `isReadyForDownload()`, `downloadTranslation()`, attachment variants, `getFileName()`, `cancelTranslation()`). Two cron `QueueWorker`s — `tmgmt_extension_suit_upload` and `tmgmt_extension_suit_download` — process job upload (request translation) and download (apply translation) asynchronously; a `FlowScheduler` service plus a `UniqueQueueItem` helper enqueue jobs/files without duplicates. Five bulk `Action` plugins (Request Translation, Download Translation, Cancel Job, Delete Job, Clear JobItem data) are wired into the `tmgmt_job_overview` view as a VBO bulk form, each routing through a dedicated confirm/approve form under `/admin/tmgmt/extension-approve-action-*` (all `_permission: administer tmgmt`). The "track changes" feature (`hook_entity_update`) watches translatable source entities: when a source that already has active/finished jobs changes, it stores an md5 `tes_source_content_hash` per job item (added as a base field), and for enabled provider+language pairs it resets the item, reopens the job, and re-queues it for upload — keeping translations in sync automatically. A settings form at `/admin/tmgmt/extension-settings` toggles `do_track_changes` globally and per translator+target-language (stored in state). The module also adds a generated `job_file_name` base field to jobs and removes `moderation_state` from translatable fields. It ships a hidden test submodule (`tmgmt_extension_suit_test`) that is not documented here.

---

- Upload TMGMT jobs to a translation provider asynchronously via cron queue instead of inline.
- Download and apply completed translations in the background from a cron queue.
- Bulk-request translation for many jobs at once from the job overview.
- Bulk-download translations for a selection of jobs.
- Bulk-cancel translation jobs (also cancelling in the 3rd-party service).
- Bulk-delete translation jobs from the overview.
- Bulk-clear cached JobItem `data` to reclaim space or force a refresh.
- Auto-resubmit content for translation when its source entity is edited ("track changes").
- Scope auto-resubmission to specific translation providers and target languages.
- Detect source changes via a per-job-item md5 content hash (`tes_source_content_hash`).
- Reopen finished/active jobs automatically when their source content changes.
- De-duplicate queued upload/download items so the same job isn't processed twice.
- Give each job a deterministic generated file name via the translator plugin (`job_file_name`).
- Add extended upload/download hooks to a custom TMGMT translator plugin.
- Handle attachment-file translations separately from job translations in the download queue.
- Exclude `moderation_state` from the set of translatable fields sent to translation.
- Add a bulk-operations form to the TMGMT job overview view automatically.
- Approve bulk actions through explicit confirmation forms before they run.
- React to reopened jobs from custom code via `hook_tmgmt_extension_suit_updated_entity_jobs`.
- Run continuous translation sync for a site whose source content changes frequently.
- Offload large translation batches to background processing to avoid request timeouts.
