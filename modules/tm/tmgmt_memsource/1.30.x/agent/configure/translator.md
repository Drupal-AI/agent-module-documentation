<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Phrase TMS provider

`tmgmt_memsource` has no standalone settings page. It adds a TMGMT translator plugin
(`id: memsource`, class `MemsourceTranslator`); you configure it as a **Provider**
(`tmgmt_translator` config entity).

## Create the provider

- UI: Configuration → Regional and language → Translation Management → **Providers**
  (route `entity.tmgmt_translator.collection`) → *Add Translator*, set *Translator plugin* = "phrase".
- Provider form is built by `Drupal\tmgmt_memsource\MemsourceTranslatorUi::buildConfigurationForm()`.
- On save, `validateConfigurationForm()` clears any cached token and calls
  `MemsourceTranslator::loginToMemsource()`; a bad URL/user/password fails validation with
  "Login incorrect. Please check the API endpoint, user name and password." A successful login
  hex-encodes the password (`encodePassword()`) before it is persisted and caches an API token in
  `state`. The *Preview connector* select only appears once `checkMemsourceConnection()` (a
  `/api2/v1/auth/whoAmI` probe) succeeds.

## Settings keys (stored on the translator entity's `settings` map)

| Key | Type | Meaning |
|---|---|---|
| `service_url` | string | Phrase TMS Home URL, e.g. `https://cloud.memsource.com/web` (required). `/web/...` suffixes are trimmed to `/web` by `updateServiceUrl()`. |
| `memsource_user_name` | string | Phrase TMS user name (required). |
| `memsource_password` | password | Stored hex-encoded with prefix `MEMSOURCE_V2___` (reversible; see `encodePassword`/`decodePassword`). A "Change password" checkbox appears once settings exist so the stored value is kept unless changed. |
| `enable_file_translation` | bool | Upload attached Office files with the XLIFF (form default checked). |
| `memsource_update_job_status` | bool | Set the Phrase job to *Delivered* (`setStatus`) after import into Drupal. |
| `memsource_cron_use` | bool | Pull completed translations on cron. |
| `memsource_cron_start_hour` / `memsource_cron_end_hour` | select (0–23) | Active window; cron pulls only when `start <= hour < end` (defaults 8 / 18). |
| `memsource_cron_time` | int (min 5) | Minutes between pulls. |
| `memsource_cron_limit` | int | Max job items per cron run (default 100). |
| `memsource_connector_token` | select | Phrase *preview connector* (`localToken` of a `DRUPAL_PLUGIN` connector, via `getDrupalConnectors()`); only shown once the connection succeeds. |

`MemsourceTranslator::defaultSettings()` also lists `project_template`, `due_date`, `group_jobs`,
`force_new_project` (these are per-job checkout values, below). The declared config schema
`tmgmt.translator.settings.memsource` only covers `auto_accept`, `url`, `client_id`,
`client_secret`; the keys above are set by the UI and are the ones that matter in practice.
`config/install/tmgmt_memsource.settings.yml` ships only `debug: false` (gates the extra
warning/debug logging).

## Per-job (checkout) settings — `checkoutSettingsForm()`

Set when submitting a job to this provider: `project_template` (Phrase template id, `0` = none;
list filtered to templates whose source/target langs match the job), `due_date` (`Y-m-d`, forwarded
as end-of-day UTC via `convertDateToEod()`), `group_jobs` (one Phrase project for the whole group),
`force_new_project`, and a hidden `batch_id` (`uniqid()`) used to correlate grouped jobs.

## Runtime flow (grounding, not something you call directly)

1. `requestTranslation()` → `requestJobItemsTranslation()`: creates or re-uses a Phrase project
   (`newTranslationProject()`, optionally `/api2/v2/projects/applyTemplate/{id}`;
   `getMemsourceProjectIdByBatchId()` / `getMemsourceProjectIdByContent()` find a reusable project),
   exports each item to XLIFF (`tmgmt_file` `xlf` format), uploads job parts (`createJob()` /
   `sendFiles()`), and stores a `tmgmt_remote` RemoteMapping per item keyed by project uid
   (`remote_identifier_2`) + job-part uid (`remote_identifier_3`). File attachments are uploaded as
   separate Phrase jobs when `enable_file_translation` is on. Uploads retry up to
   `CHECK_JOB_MAX_RETRIES` (5) with backoff. Providers from the template are assigned via
   `assignMemsourceProviders()`.
2. Completed work returns three ways: cron
   (`PullTranslationsTask` → `PullTranslationsWorker::processItem()` → `fetchTranslatedFiles()`),
   the *Pull translations* button (`MemsourceTranslatorUi::submitPullTranslations()` →
   `fetchTranslatedFiles()`), or the webhook (`WebHookController::callback()`).
   `processJobItemMappings()` fetches each job-part status, and completed parts
   (`remoteTranslationCompleted()` = `COMPLETED_BY_LINGUIST` / `COMPLETED` / `DELIVERED`) are
   imported by `addFileDataToJob()`, which downloads the target file
   (`/api2/v1/projects/{id}/jobs/{part}/targetFile`) and either parses the XLIFF back into the job
   item (`parseTranslationData()` → `addTranslatedData()`) or writes the translated binary file to a
   language-suffixed file entity (`createFileTranslation()`). `checkAllMappingsComplete()` advances
   the job item to REVIEW (or ACCEPTED when auto-accept is on) once every mapping is complete.
3. API calls go through `sendApiRequest()` → `request()` (Guzzle `http_client`); the token is sent
   as an `Authorization: ApiToken <token>` header and auto-refreshed on HTTP 401 via
   `loginToMemsource()`. Token stored in `state` key `tmgmt_memsource.token.<translator_id>`.
   Timeouts: 30s default, 180s for `/targetFile` downloads.

## Routes

| Route | Path | Access | Purpose |
|---|---|---|---|
| `tmgmt_memsource.callback` | `/tmgmt_memsource_callback` | `_access: 'TRUE'` | Inbound webhook; Phrase POSTs `jobParts[]` status JSON → module looks up the RemoteMapping by job-part uid and, for a completed part, re-fetches and imports that job part from the Phrase API. Returns 200 (or 207 if some parts failed). |
| `tmgmt_memsource.no_preview` | `/no_preview` | `_access: 'TRUE'` | Static "No preview url available" text. |
| `tmgmt_memsource.pull_all_remote_translations` | `/pull_all_remote_translations` | `administer tmgmt` + `accept translation jobs` | Batch-pull all active/review items across memsource translators. |

## Cron

`memsource.cron_task` (`Cron\PullTranslationsTask`) is tagged `cron` and also force-invoked by
`tmgmt_memsource_cron()` (the module found the tag unreliable). It queues `PullTranslationsWorker`
items to pull completed translations, respecting the per-translator active-hours window
(`memsource_cron_start_hour`/`end_hour`), the interval (`memsource_cron_time` minutes, tracked in
`state` key `cron_las_time.<translator_id>`), and item limit (`memsource_cron_limit`).
