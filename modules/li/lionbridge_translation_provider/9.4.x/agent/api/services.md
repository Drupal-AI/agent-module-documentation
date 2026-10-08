<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services, runtime flow, and the queue-process route

All services are defined in `tmgmt_contentapi.services.yml`. They are internal building
blocks (no formal public API), but this is what an integrator needs to know to operate the
module. The Lionbridge REST client lives under `src/Swagger/Client/` (auto-generated Swagger
client: `TokenApi`, `JobApi`, `ProviderApi`, `RequestApi`, `FileApi`, `SourceFileApi`,
`StatusUpdateApi`, `TranslationContentApi`, …); base config in `Swagger/Client/Configuration.php`
(`tokenEndpoint = https://login.lionbridge.com/connect/token`).

## Service ids

| Service id | Class | Role |
|---|---|---|
| `tmgmt_contentapi.create_job` | `Services\CreateConnectorJob` | Export + submit a job to the Content API (non-shared). |
| `tmgmt_contentapi.export_job` | `Services\ExportJobFiles` | Write TMGMT job items out as XLIFF files. |
| `tmgmt_contentapi.import_job` | `Services\ImportJob` | Download + import completed translations. |
| `tmgmt_contentapi.capi_data_processor` | `Services\CapiDataProcessor` | Read/write the `tmgmt_capi_request_processor` table; poll status updates. |
| `tmgmt_contentapi.capi_details` | `Services\CapiDetails` | `getCapiToken($translator)` → cached OAuth bearer token; provider helpers. |
| `tmgmt_contentapi.queue_operations` | `Services\QueueOperations` | Queue helpers, `processQueue()`, CSRF-token'd background dispatch. |
| `tmgmt_contentapi.job_upload_manager` | `Services\JobUploadManagerService` | Tracks per-file upload state/robustness. |
| `tmgmt_contentapi.job_helper` | `Services\JobHelper` | Job/translator lookups, filenames, mime, transliteration. |
| `tmgmt_contentapi.handle_throttling` | `Services\HandleThrottling` | Retry wrapper for 429/403/5xx responses. |
| `tmgmt_contentapi.analysis_code_api` | `Services\AnalysisCodeApi` | Freeway SOAP analysis-code integration (uses `@http_client`). |
| `plugin.manager.tmgmt_contentapi.format` | `Format\FormatManager` | Export-format plugin manager (see [plugins/format.md](../plugins/format.md)). |
| `tmgmt_contentapi.null_safe_link_generator` | `Services\NullSafeLinkGenerator` | Decorates `link_generator`. |

## Submit flow (Drupal → Lionbridge)

`ContentApiTranslator::requestTranslation($job)` (plugin id `contentapi`) → when the job task
is `trans`, calls `tmgmt_contentapi.create_job` → `CreateConnectorJob::submitJobToContentApi($job)`:

1. `addItemsToQueueToGenerateXlfFiles()` / `ExportJobFiles` render job items to XLIFF via the
   selected format plugin.
2. Work moves through Drupal queues (see workers below): `export_translation_jobs_to_capi` →
   `generate_file_for_translation_to_capi` → `send_file_for_translation_to_capi`.
3. `createCpJobs()` / `postFilesToCapi()` create a remote Content API job and upload source
   files (`JobApi`, `SourceFileApi`), wrapped by `HandleThrottling`.
4. Each request id is recorded in `tmgmt_capi_request_processor` (job id, request id,
   status code, `source_site`, upload status). The job moves to STATE_ACTIVE.

## Poll + import flow (Lionbridge → Drupal)

There is **no inbound webhook** — retrieval is polled. `tmgmt_contentapi_cron()`:

1. `CapiDataProcessor::scanStatusData()` → `StatusUpdateApi::statusupdatesGet($token)` fetches
   status updates, then `statusupdatesUpdateIdAcknowledgePut()` acknowledges them.
2. `CapiDataProcessor::updateRequestStatus()` updates local rows.
3. If any translator has `cron-settings.status` on, `ImportJob::initiateImport()` →
   `ImportJob::processRequestId()` downloads the finished file via
   `FileApi::jobsJobIdRequestsRequestIdRetrievefileGetWithHttpInfo($token, $jobId, $requestId)`
   and imports the XLIFF back into the job items (standard TMGMT import).

Manual import: the job detail page offers "Sync and Import"
(`tmgmt_contentapi_semi_import_form_submit`) and a "Manual Import" managed-file upload
(`tmgmt_contentapi_import_form_submit`, accepts `.xlf`/`.zip`, validated by
`tmgmt_contentapi_check_empty_file`). Accepting/rejecting an item in review
(`ContentApiTranslatorUI::reviewFormSubmit()`) calls `RequestApi::jobsJobIdRequestsApprovePut()`
/ `...RejectPut()` on Lionbridge.

## Queue workers (`src/Plugin/QueueWorker`)

| Worker / queue name | Purpose |
|---|---|
| `export_translation_jobs_to_capi` | Kick off export of a job. |
| `generate_file_for_translation_to_capi` | Generate XLIFF files. |
| `send_file_for_translation_to_capi` | Upload files to the Content API. |
| `import_translated_jobs_from_queue` | Import completed translations. |
| `import_jobs_manually_from_queue` | Process a manual upload. |
| `migrate_jobs_to_new_structure_queue` | One-off data migration (update hook 9101). |

(A seventh worker class, `ExportTranslationJobsToCapiFromQueue`, backs the export queue.)

## Background queue-process route

`tmgmt_contentapi.routing.yml` defines one route:

```
tmgmt_contentapi.queue_process_in_bg
  path:   /tmgmt-contentapi/queue-process-background/{queue_name}/{batch_size}
  methods: [POST]
  controller: QueueProcessController::processQueueInBackground
  _permission: 'access queue process'
```

`QueueProcessController` additionally requires an `X-CSRF-Token` header validated against the
value `queue_process_background`, restricts `{queue_name}` to a fixed allowlist of the queues
above, and bounds `{batch_size}` to 1–1000. It only drains items already queued locally (it
does not accept translation content from the request body). It is a self-dispatch endpoint the
site uses to process its own queues in the background — see [permissions/permissions.md](../permissions/permissions.md).

## Install schema

`tmgmt_contentapi.install` creates `tmgmt_capi_request_processor` (per-request tracking:
`tjid`, `tjiid`, `jobid`, `requestid`, `statuscode`, `status`, upload state, `source_site`, …)
and `tmgmt_capi_response` (raw API responses per job/item). Both are dropped on uninstall.
