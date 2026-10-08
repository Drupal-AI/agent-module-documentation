# TMGMT Extension Suit — agent index

Queue-based bulk upload/download of TMGMT translation jobs, "track changes" auto-resubmission of
edited source content, and bulk job actions. Extends the TMGMT (Translation Management Tool) workflow.
Depends on `tmgmt`, `tmgmt_file`, `serialization`. No `configure` key in info.yml, but a settings form
exists (below). No own permissions (everything uses core/TMGMT `administer tmgmt`).

- **Settings form `/admin/tmgmt/extension-settings` (track changes, per provider+language)** →
  [configure/settings.md](configure/settings.md)
- **`ExtendedTranslatorPluginInterface` — implement it on your TMGMT translator to enable upload/download/sync** →
  [extend/translator-plugin.md](extend/translator-plugin.md)
- **Bulk Actions, QueueWorkers, FlowScheduler, track-changes flow** →
  [plugins/actions-and-queues.md](plugins/actions-and-queues.md)
- **`hook_tmgmt_extension_suit_updated_entity_jobs`** →
  [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Translator plugins opt in via `Drupal\tmgmt_extension_suit\ExtendedTranslatorPluginInterface`
  (extends TMGMT `TranslatorPluginInterface`). Only such plugins get queue/track-changes behavior.
- QueueWorkers `tmgmt_extension_suit_upload` (calls `requestTranslationExtended()`) and
  `tmgmt_extension_suit_download` (calls `downloadTranslation()` / `downloadAttachmentTranslation()`),
  both cron `time = 30`, dispatched via `tmgmt_extension_suit.utils.flow_scheduler`.
- Base fields added: `tes_source_content_hash` (md5) on `tmgmt_job_item`, `job_file_name` on `tmgmt_job`.
- 5 bulk Actions on the `tmgmt_job_overview` view; each confirms via `/admin/tmgmt/extension-approve-action-*`
  (`_permission: administer tmgmt`).
- Hidden test submodule `tmgmt_extension_suit_test` exists but is not documented (test-only).
