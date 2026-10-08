<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `bwx` translator plugin — API client, submission & import

Source: `src/Plugin/tmgmt/Translator/BureauTranslator.php` (the bulk of the module), `src/BureauTranslatorUi.php`.

## Plugin definition

`@TranslatorPlugin(id = "bwx", label = "Bureau Works", logo = "icons/bureau-icon.png",
ui = "Drupal\bureauworks_tmgmt\BureauTranslatorUi")`. Class `BureauTranslator extends TranslatorPluginBase
implements ContainerFactoryPluginInterface, ContinuousTranslatorInterface`. Injected services (`create()`):
core **`http_client`** (Guzzle) and **`plugin.manager.tmgmt_file.format`** (XLIFF export/import).

`defaultSettings()` forces `export_format = 'xlf'`, `xliff_cdata = TRUE`, `xliff_processing = FALSE`.
`checkAvailable()` returns available iff `end_point_api` is set.

## API client — `doRequest()`

All Bureau Works calls go through `doRequest($translator, $path, $parameters, $method, $requesttype)`:

- Base URL = `end_point_api` setting `. '/api/v3'`.
- **Auth**: a token cached under `bureauworks_tmgmt.auth_token.<translator id>` in `\Drupal::cache()`. When
  absent, POSTs JSON `{accessKey, secret}` to `/api/v3/auth` and reads the **`X-AUTH-TOKEN`** response header,
  caching it for ~120s (`time() + 120`). Missing token → `TMGMTException`.
- Subsequent calls send header `X-AUTH-TOKEN: <token>`. `GET` → params as query string; `POST/PUT` JSON body
  (`Content-Type: application/json`); `fileupload` request type → Guzzle `multipart` upload; `download`
  request type → raw body returned (not JSON-decoded).
- On `BadResponseException` the cached token is deleted and a `TMGMTException` is thrown with the API's reason
  phrase / status code.

Uses the Guzzle client with **default options** — TLS certificate verification is on (no `verify => false`,
no `CURLOPT_SSL_VERIFYPEER` override). Credentials travel in the JSON body, not the URL/query string.

## Submission — `requestJobItemsTranslation()`

Called from `requestTranslation(JobInterface)` and `requestJobItemTranslation($job_item)`:

1. `createProject()` → POST `project/ci` with `{reference, orgUnitUUID, contactUUID, source, tags:['drupal'],
   ciTag}`; response `uuid` is the Bureau Works **project/order id**, `name` the project name.
2. Per job item: `Xliff::export($job, ['tjiid' => ...])` builds the XLIFF; `createProjectResource()` → POST
   `project/{order}/resource` (optionally with `previewUrl`); `sendSourceFile()` → PUT
   `project/{order}/resource/{resource}/content` (multipart file upload); `sendResourceWorkUnits()` → POST
   `project/{order}/work-unit?bulk=true` with the configured `workflows` + target locale.
3. `job_item->active()` and a TMGMT **remote mapping** is stored: `remote_identifier_1 = resource UUID`,
   `remote_identifier_2 = project/order UUID`, `remote_identifier_3 = BW project name`, plus remote data
   `project_created_at`.
4. On any exception the partly-created project is cancelled and cleaned up
   (`cancelAndCleanupProject()` → POST `project/{order}/status {newStatus: CANCELLED}` + delete mappings),
   items are aborted, and a non-continuous job is `rejected()`.

`buildPreviewUrl()` (only when `shouldSendPreviewUrl`) builds `<previewBaseUrl or request host>` + the job
item's source URL and validates it with `isValidExternalUrl()` (scheme http/https, host present, resolved IP
must pass `FILTER_FLAG_NO_PRIV_RANGE | FILTER_FLAG_NO_RES_RANGE`); non-public URLs are dropped, not sent.

## Delivery & import — pull based

- `importAndCleanup($job_item)` (called by the fetch queue worker) → `fetchDeliveredContentInfo()` compares the
  API's highest **DELIVERED** work-unit sequence/date against the mapping's stored
  `last_delivered_sequence` / `last_delivery_date`; returns NULL when nothing new.
- `importTranslation()` downloads the translated files (`downloadFilesAsync()` → POST `project/{order}/download`
  then polls `.../download/{requestUuid}/status` up to 3 min, then `file_get_contents($response['downloadUrl'])`),
  saves the ZIP under `public://bureau_translation/{order}/`, extracts it with `ZipArchive`, reads the target
  XLIFF, and (after normalizing `target-language`) calls `Xliff::validateImport()` + `Xliff::import()`.
- **Job binding is enforced**: `validateImport()` must return a job whose id equals the current job item's job
  id, otherwise a `TMGMTException` aborts the import (a delivered file for a different job is rejected).
- `onTranslationImport()` then auto-accepts (`autoAcceptableWorkflows`) or auto-saves
  (`autoSaveTranslationsForWorkflows`) based on the last delivered workflow name; imported translation data is
  added via `getJob()->addTranslatedData(..., TMGMT_DATA_ITEM_STATE_TRANSLATED)`.
- `cleanupExtractedFiles()` deletes the extracted directory afterwards.

## Manual fetch & sandbox actions (`BureauTranslatorUi`)

- **checkoutInfo()** on an active job renders a *Fetch translations* submit → `submitFetchTranslations()` →
  `BureauTranslator::fetchTranslations($job)` (same delivery/import path, per job item).
- When `use_sandbox` is set: *Simulate complete* → `simulateCompleteOrder()`, *Simulate preview* →
  `submitSimulateTranslationPreview()` (calls `simulateTranslationPreview()`).
- `checkoutSettingsForm()` adds job-level `name` / `comment` / `duedate` fields.

## Abort

`abortTranslation()` / `abortJob()` aborts each job item, sets the job state to aborted, and cancels the
Bureau Works project (`cancelProject()` → POST `project/{order}/status {CANCELLED}`). Continuous jobs cannot
be aborted.
