<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks implemented (`tmgmt_contentapi.module`)

These are the procedural hooks the connector implements. Most act only on TMGMT jobs whose
translator plugin id is `contentapi`.

| Hook | Function | What it does |
|---|---|---|
| `hook_cron` | `tmgmt_contentapi_cron` | Poll Lionbridge for status updates (`CapiDataProcessor::scanStatusData` + `updateRequestStatus`); if any translator has `cron-settings.status`, run `ImportJob::initiateImport()`. |
| `hook_tmgmt_job_delete` | `tmgmt_contentapi_tmgmt_job_delete` | For processed `contentapi` jobs, remove exported file usages/files and purge the job's rows from `tmgmt_capi_request_processor` / `tmgmt_capi_response`. |
| `hook_tmgmt_job_item_update` | `tmgmt_contentapi_tmgmt_job_item_update` | When an item is accepted, mark its processor row `COMPLETED`. |
| `hook_form_alter` | `tmgmt_contentapi_form_alter` | On `tmgmt_job_item_edit_form` / `tmgmt_job_edit_form`: hide abort/delete for active remote jobs, extend the label maxlength, add the complete-item submit handler, and fetch remote status to decide button visibility. |
| `hook_form_FORM_ID_alter` | `tmgmt_contentapi_form_tmgmt_job_edit_form_alter` | Adds `tmgmt_contentapi_job_form_validate` (validates due date > now, provider language support). |
| `hook_entity_operation_alter` | `tmgmt_contentapi_entity_operation_alter` | On the job overview: show "In Submission Queue" and remove abort/delete/clone operations for in-flight `contentapi` jobs (uses cached local status, not live API). |
| `hook_views_data` | `tmgmt_contentapi_views_data` | Exposes `tmgmt_capi_request_processor` (and virtual `views` fields `job_status_field`, `job_lioxid_field`, `job_providerid_field`) to Views. |
| `hook_views_pre_view` | `tmgmt_contentapi_views_pre_view` | Injects a custom header area into `tmgmt_job_overview`. |
| `hook_views_post_execute` | `tmgmt_contentapi_views_post_execute` | Caches entity ids from `tmgmt_job_overview` to avoid re-running the view. |
| `hook_views_query_alter` | `tmgmt_contentapi_views_query_alter` | Fixes the `tjid` field alias for a job-item state filter. |
| `hook_views_plugins_alter` | `tmgmt_contentapi_views_plugins_alter` | Registers the `tmgmt_capi_items_count` views field handler. |
| `hook_page_attachments` | `tmgmt_contentapi_page_attachments` | Attaches the `tmgmt_contentapi/my-block-styling` library. |

## Custom form submit / AJAX callbacks (referenced by the UI)

- `tmgmt_contentapi_semi_import_form_submit` — "Sync and Import" a job (`tmgmt_contentapi_process_jobs`).
- `tmgmt_contentapi_import_form_submit` — process a manual `.xlf`/`.zip` upload into the manual queue.
- `tmgmt_contentapi_update_tm_form_submit` — "Update TM" (`CreateConnectorJob::updateTranslationMemory`).
- `tmgmt_contentapi_check_empty_file` — validate the manual upload (extensions `zip`, `xlf`).
- `tmgmt_contentapi_ajax_provider_changed` — AJAX refresh of the quote/supported-languages block.
- `tmgmt_contentapi_ajax_test_freeway_connection` — AJAX "test connection" for the Freeway analysis-code API.
