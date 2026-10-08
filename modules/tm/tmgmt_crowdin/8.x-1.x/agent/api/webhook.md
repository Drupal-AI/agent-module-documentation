<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Crowdin webhook endpoint

Route **`tmgmt_crowdin.file_webhook`** (`tmgmt_crowdin.routing.yml`), path
**`/tmgmt_crowdin/process/file_webhook`**, controller
`CrowdinWebhookController::process()` (`src/Controller/CrowdinWebhookController.php`). This is the
endpoint Crowdin calls when a file is translated or approved, so translations import automatically
without a manual "Fetch translations" click.

## Registration

The webhook is created on the Crowdin side by the translator plugin, not configured by hand:

- `CrowdinTranslator::requestFileWebhook()` runs during job submission. It first checks the local
  `webhook_id_by_project_id` map (config object `tmgmt_crowdin.settings`); if this project already has
  a webhook, it returns. Otherwise it lists `projects/{id}/webhooks`, reuses an active one named
  **`Files Webhooks for Drupal Connector`** (`WEBHOOK_NAME`) if present, else calls `createWebhook()`.
- `createWebhook()` POSTs a webhook to Crowdin with `url = Url::fromRoute('tmgmt_crowdin.file_webhook')`
  (absolute), events `['file.translated', 'file.approved']`, `requestType => 'POST'`, and stores the
  returned webhook id in `webhook_id_by_project_id` (serialized).

## `process(Request $request)` behavior

Returns a `JsonResponse`; always HTTP 200 for ignorable/invalid payloads (so Crowdin does not retry):

1. `Json::decode($request->getContent())`; requires `file.path`. Missing → logs a warning, 200.
2. Extracts `project_id` (`file.project.id` or flat `project_id`), `file_id` (`file.id`/`file_id`),
   `target_language` (`targetLanguage.id`/`language`). Any missing → warning, 200.
3. Recovers `[$job_id, $job_item_id]` from the filename via
   `sscanf(end($file_path), CrowdinTranslator::FORMAT_FILE_NAME)` (the `Job_%d_JobItem_%d_%s_%s.xml`
   pattern). If neither parses → 200.
4. Loads `Job` and `JobItem`; unknown → warning, 200. Aborted job/item → warning message, HTTP 404.
5. Confirms `project_id` is present in the local `webhook_id_by_project_id` map (else 200).
6. Loads the project; if the project exports approved-only and the event is not `file.approved`,
   returns 200 (waits for approval).
7. Calls `crowdin_translator->updateTranslation($job_item, $project, $file_id, $target_language)` — the
   same path as manual fetch (see [../plugins/translator.md](../plugins/translator.md)). On success
   returns `{success: true, translations_updated: true}`; `TMGMTException` is recorded on the job item;
   other exceptions are logged and return HTTP 500.

The actual translated content is re-fetched server-side from the **authenticated Crowdin API**
(`getFile()`) and re-validated by `WebXML::validateImport()` (job-id/language match) before it is
written into the job — the webhook body only identifies which job/file/language to import, not the
content itself.
