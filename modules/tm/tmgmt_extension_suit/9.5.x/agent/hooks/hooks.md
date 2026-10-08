# TMGMT Extension Suit — hooks

## Hook it invites (`tmgmt_extension_suit.api.php`)
```php
/**
 * React to jobs reopened because their source entity was updated.
 *
 * @param array  $job_ids        Reopened job ids (for one translator).
 * @param string $translator_id  Translator the jobs were submitted through.
 * @return array  Extra data merged into the upload queue item payload.
 */
function hook_tmgmt_extension_suit_updated_entity_jobs(array $job_ids, $translator_id) {
  // e.g. return provider-specific metadata to attach to the re-upload.
}
```
Invoked via `moduleHandler->invokeAll()` inside `tmgmt_extension_suit_entity_update()` (the track-changes
flow). The returned array is passed as `$data` to `FlowScheduler::scheduleUpload()` and ends up in the
`tmgmt_extension_suit_upload` queue item / `requestTranslationExtended($job, $data)`.

## Notable core hooks the module implements
- `hook_entity_update` — track-changes: reopen + re-queue jobs when source content changes.
- `hook_ENTITY_TYPE_presave` (`tmgmt_job_item`) — set `tes_source_content_hash` on creation.
- `hook_ENTITY_TYPE_presave` (`tmgmt_job`) — set `job_file_name` from the plugin's `getFileName()`.
- `hook_entity_base_field_info` — add `tes_source_content_hash` (md5) to `tmgmt_job_item`.
- `hook_entity_base_field_info_alter` — add `job_file_name` (string, 1024) to `tmgmt_job`.
- `hook_tmgmt_translatable_fields_alter` — unset `moderation_state` from translatable fields.
- `hook_views_pre_view` — inject the `tmgmt_job_bulk_form` (VBO) into the `tmgmt_job_overview` view.
- `hook_modules_installed` — seed track-changes state defaults when `tmgmt` is installed.
