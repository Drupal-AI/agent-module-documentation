<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Phrase TMS provider

`tmgmt_memsource` has no standalone settings page. It adds a TMGMT translator plugin
(`id: memsource`, class `MemsourceTranslator`); you configure it as a **Provider**
(`tmgmt_translator` config entity).

## Create the provider

- UI: Configuration → Regional and language → Translation Management → **Providers**
  (route `entity.tmgmt_translator.collection`) → *Add Translator*, set *Translator plugin* = "phrase".
- Provider form is built by `Drupal\tmgmt_memsource\MemsourceTranslatorUi::buildConfigurationForm()`.
- On save, `validateConfigurationForm()` clears any cached token and logs in to validate the
  credentials; a bad endpoint/user/password (or Platform API Token) fails validation. A successful
  password login hex-encodes the password (`encodePassword()`) before it is persisted and caches an
  API token in `state`. The *Preview connector* / *Custom Field* / *Workflow step* selects only
  appear once `checkMemsourceConnection()` (a `/api2/v1/auth/whoAmI` probe) succeeds.

## Authentication method (`memsource_auth_method`)

A `radios` field with two options:

- **`password`** (default) — *User name* (`memsource_user_name`) + *Password* (`memsource_password`).
  On login the module POSTs to `/api2/v1/auth/login` and caches the returned API token; it is sent
  as an `Authorization: ApiToken <token>` header.
- **`platform_token`** — a Phrase *Platform API Token* (`memsource_platform_token`). The module
  exchanges it via OAuth 2.0 token-exchange (`grant_type=urn:ietf:params:oauth:grant-type:token-exchange`)
  at the IDM endpoint `/idm/oauth/token` for a short-lived JWT access token, sent as
  `Authorization: Bearer <jwt>`. The JWT's `expires_in` is stored and the token is proactively
  re-exchanged when it is within 5 minutes of expiry (`isPlatformTokenExpiringSoon()`).

A "Change password" checkbox (`memsource_change_password`) and a "Change Platform API Token"
checkbox (`memsource_change_platform_token`) appear once settings exist, so the stored secret is
kept unless the admin opts to change it (password/token fields are never re-rendered with a value).

## Settings keys (stored on the translator entity's `settings` map)

| Key | Type | Meaning |
|---|---|---|
| `service_url` | string | Phrase TMS Home URL, e.g. `https://cloud.memsource.com/web` (required). A `/web/...` suffix is trimmed back to `/web` by `updateServiceUrl()`. |
| `memsource_auth_method` | string | `password` (default) or `platform_token`. |
| `memsource_user_name` | string | Phrase TMS user name (password method). |
| `memsource_password` | password | Stored hex-encoded with prefix `MEMSOURCE_V2___` (reversible; see `encodePassword`/`decodePassword`). |
| `memsource_platform_token` | password | Platform API Token (platform_token method); exchanged for a JWT. Stored copy lives in `state`, not config (see below). |
| `enable_file_translation` | bool | Upload attached Office files with the XLIFF (form default checked; `defaultSettings()` default FALSE). |
| `memsource_update_job_status` | bool | Set the Phrase job to *Delivered* (`setStatus`) after import into Drupal. |
| `memsource_webhook_token` | password | Optional. Token Phrase TMS must present on the callback (see Routes). Stored in exportable config; can be overridden per-environment in settings.php. |
| `memsource_cron_use` | bool | Pull completed translations on cron. |
| `memsource_cron_start_hour` / `memsource_cron_end_hour` | select (0–23) | Active window; cron pulls only when `start <= hour < end` (defaults 8 / 18). |
| `memsource_cron_time` | int (min 5) | Minutes between pulls. |
| `memsource_cron_limit` | int | Max job items per cron run (default 100). |
| `memsource_preview_method` | radios | `legacy_connector` (a Phrase preview connector) or `preview_package` (render + upload a preview at job creation, no Drupal credentials stored in Phrase). |
| `memsource_connector_token` | select | Phrase *preview connector* (`localToken` of a `DRUPAL_PLUGIN` connector, via `getDrupalConnectors()`); shown for the legacy method once connected. |
| `memsource_source_url_custom_field_uid` | select/string | Optional. A Phrase job-level Custom Field that receives the public URL of the translated entity at job creation, so linguists can open the live source page. |
| `memsource_public_base_url` | string | Optional. Overrides the host of the entity URL written to the Custom Field above (reverse proxy / staging / multi-domain). |
| `memsource_export_workflow_step_uid` | select/string | Optional. The Phrase workflow step whose completion the module treats as "done" (defaults to the project's last step). |

`MemsourceTranslator::defaultSettings()` also seeds `project_template`, `due_date`, `group_jobs`,
`force_new_project` (per-job checkout values, below). The config schema
`tmgmt.translator.settings.memsource` now covers the full set of keys above.
`config/install/tmgmt_memsource.settings.yml` ships only `debug: false` (gates extra
warning/debug logging).

### settings.php config overrides for secrets

`memsource_platform_token` and `memsource_webhook_token` can be supplied per-environment via a
`$config['tmgmt.translator.<id>']['settings'][...]` override in settings.php. An overridden Platform
API Token is resolved only through the config override (`getPlatformApiTokenOverride()`), is never
written back into Drupal `state`, and is never surfaced in the rendered form field.

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
   `assignMemsourceProviders()`. When a Source-entity-URL Custom Field is configured, the entity's
   public URL is written to that job Custom Field.
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
3. API calls go through `sendApiRequest()` → `request()` (Guzzle `http_client`). The token is sent
   as `Authorization: ApiToken <token>` (password method) or `Authorization: Bearer <jwt>`
   (platform_token method) and auto-refreshed on HTTP 401 via `login()`. Token stored in `state`
   key `tmgmt_memsource.token.<translator_id>`. Timeouts: 30s default, 180s for `/targetFile`
   downloads (and a custom per-call timeout is honoured when supplied).

## Routes

| Route | Path | Access | Purpose |
|---|---|---|---|
| `tmgmt_memsource.callback` | `/tmgmt_memsource_callback` | `_access: 'TRUE'` | Inbound webhook. Phrase POSTs a `jobParts[]` status payload. `WebHookController::callback()` first validates the optional webhook security token (see below), then, for each job part, looks up the RemoteMapping by job-part uid, checks the status (and, when a workflow step is configured, the workflow level) and, for a completed part, re-fetches and imports that job part from the Phrase API. Returns 200 (or 207 if some parts failed). |
| `tmgmt_memsource.no_preview` | `/no_preview` | `_access: 'TRUE'` | Static "No preview url available" text. |
| `tmgmt_memsource.pull_all_remote_translations` | `/pull_all_remote_translations` | `administer tmgmt` + `accept translation jobs` | Batch-pull all active/review items across memsource translators. |

### Webhook token validation

`callback()` calls `isWebhookTokenValid()` before any processing. It collects the
`memsource_webhook_token` of every `memsource` translator; if at least one is set, the request must
present a matching value in the `x-memsource-token` header (or an `Authorization` header, with an
optional `Bearer ` prefix stripped), compared with `hash_equals()`. A mismatch returns `403`. If no
translator has a token configured, the check is skipped so existing installs keep working.

The workflow-level check uses `resolveTargetWorkflowLevel()`, which maps the configured
`memsource_export_workflow_step_uid` to a workflow level via
`/api2/v1/projects/{project_uid}/workflowSteps` (cached per project per payload), falling back to
the project's last step.

## Cron

`memsource.cron_task` (`Cron\PullTranslationsTask`) is tagged `cron` and also force-invoked by
`tmgmt_memsource_cron()` (the module found the tag unreliable). It queues `PullTranslationsWorker`
items to pull completed translations, respecting the per-translator active-hours window
(`memsource_cron_start_hour`/`end_hour`), the interval (`memsource_cron_time` minutes, tracked in
`state` key `cron_las_time.<translator_id>`), and item limit (`memsource_cron_limit`).
