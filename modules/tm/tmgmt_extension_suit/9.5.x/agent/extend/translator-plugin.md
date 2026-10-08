# TMGMT Extension Suit — ExtendedTranslatorPluginInterface

To get this module's queue upload/download and track-changes automation, your TMGMT translator plugin
must implement `Drupal\tmgmt_extension_suit\ExtendedTranslatorPluginInterface` (which
`extends Drupal\tmgmt\TranslatorPluginInterface`). All queue workers and the track-changes hook check
`instanceof ExtendedTranslatorPluginInterface` and silently skip translators that don't implement it.

## Methods to implement
| Method | Called by | Purpose |
|---|---|---|
| `requestTranslationExtended(JobInterface $job, array $data)` | `tmgmt_extension_suit_upload` queue worker (`JobUpload`) | Send/queue the job to the 3rd-party service. `$data` is the queue item payload. |
| `isReadyForDownload(JobInterface $job)` : bool | `tmgmt_extension_suit_download` worker | Whether the translation can be fetched yet. |
| `downloadTranslation(JobInterface $job, ?JobItemInterface $jobItem = NULL)` : bool | download worker | Apply translation to all items (or one if `$jobItem` given). |
| `isAttachmentReadyForDownload(JobInterface $job, FileInterface $file)` : bool | download worker | Attachment-file readiness. |
| `downloadAttachmentTranslation(JobInterface $job, FileInterface $file)` : bool | download worker | Apply a translated attachment file. |
| `getFileName(JobInterface $job)` : string | `hook_ENTITY_TYPE_presave` on `tmgmt_job` | Deterministic export file name; stored in the `job_file_name` base field. |
| `getAttachmentFileName(JobInterface $job, FileInterface $file)` : string | your code | Attachment file name. |
| `cancelTranslation(JobInterface $job)` : bool | Cancel action flow | Cancel in the 3rd-party service (not the Drupal translation). |

## Dispatching work onto the queues
Use the `tmgmt_extension_suit.utils.flow_scheduler` service (`Utils\FlowScheduler`), backed by
`tmgmt_extension_suit.utils.queue_unique_item` (`Utils\UniqueQueueItem`, de-dupes items):
```php
$scheduler = \Drupal::service('tmgmt_extension_suit.utils.flow_scheduler');
$scheduler->scheduleUpload($jobId, $data = [], $force = FALSE);            // → queue tmgmt_extension_suit_upload
$scheduler->scheduleDownload($jobId, $jobItemId = NULL, $fileId = NULL, $force = FALSE); // → queue tmgmt_extension_suit_download
```
Queue items carry `tjid` (job id), and for download also `tjiid` (job item id) and `fid` (file id).
Workers extend `QueueWorkerLockedBase` (a lock wrapper) and run on cron (`time = 30`).

## What the module wires for you
- `hook_entity_update` (track changes) computes a per-item md5 hash of translatable source data, and for
  enabled provider+language pairs resets the item, reopens the job, and calls `scheduleUpload()`.
- `hook_tmgmt_job_presave` sets `job_file_name` from `getFileName()`.
- `hook_tmgmt_translatable_fields_alter` removes `moderation_state` from translatable fields.
