# Request / retrieval flow

All logic is in `src/Plugin/tmgmt/Translator/MemoQTranslator.php` plus the callback controller
`src/Controller/MemoQController.php`. This doc replaces reading both.

## Submitting a job — `requestTranslation(JobInterface $job)`

1. Validate the job's source+target langcodes are present in `memoq_languages`; else throw.
2. Build an `order` array (`Name` = prefix+label, `CallbackUrl` = absolute URL of route
   `tmgmt_memoq.callback` for this job, `TimeCreated`, `Status: Created`, optional `Deadline`), allow
   `hook_tmgmt_memoq_order_info_alter`, then `POST orders` → memoQ `OrderId`.
3. Save a `RemoteMapping` (`remote_identifier_1 = OrderId`) linked to the tmgmt job.
4. For each job item: export to XLIFF via `tmgmt_file` "xlf" format, gzip it, build a `translationJob`
   (Name, source URL, source/target memoQ langcodes, `FileType: xliff`), allow
   `hook_tmgmt_memoq_job_info_alter`, then `POST orders/{OrderId}/jobs` (multipart, the gzipped XLIFF as
   `file`) → `TranslationJobId`, stored on a per-item remote mapping (`remote_identifier_2`).
5. `PATCH orders/{OrderId}` to `NewStatus: Committed`; mark the job submitted. Any `TMGMTException` rejects
   the job.

## The HTTP client — `request($path, $method, $params, $files, $return_raw)`

- URL = `translator->getSetting('api_url') . '/' . $path`. Header
  `Authorization: CMSGATEWAY-API <api_key>`, `Accept: application/json`.
- POST with files → multipart; POST without → JSON body; PATCH → form params (`content`); GET → query.
- Non-2xx (`BadResponseException`) → `TMGMTException` with the reason phrase; a JSON body containing
  `ErrorCode` → `TMGMTException`. `$return_raw` skips JSON decoding (used for downloading translation files).

## Getting translations back

Two paths, both call `retrieveTranslation($memoq_job_id, $job)` which does
`GET jobs/{id}/translation` (raw), `gzdecode`s it, imports via the "xlf" format, and
`$job->addTranslatedData(...)`:

- **Callback (push):** route `tmgmt_memoq.callback` → `/tmgmt/memoqcallback/{tmgmt_job}`,
  `MemoQController::callback`. Reads JSON body; requires `Payload.NewStatus`. On `TranslationReady`, loads
  the `RemoteMapping` by `Payload.TranslationJobId`, resolves the job item + translator, and calls
  `retrieveTranslation(Payload.TranslationJobId, $tmgmt_job)`.
- **Fetch (pull):** `fetchJobs($job)` queries `GET orders/{OrderId}/jobs`, and for each job whose
  `Status == TranslationReady` calls `retrieveTranslation`. Adds summary messages to the job.

## Other endpoints

- `getSupportedMemoqLanguages()` → `GET languages` (populates the mapping select options).
- `testConnection()` → `GET client` (used by the settings-form Connect/validate).
