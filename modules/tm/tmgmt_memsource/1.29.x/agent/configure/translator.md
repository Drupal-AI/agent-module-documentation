<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Phrase TMS provider

`tmgmt_memsource` has no standalone settings page. It adds a TMGMT translator plugin
(`id: memsource`); you configure it as a **Provider** (`tmgmt_translator` config entity).

## Create the provider

- UI: Configuration → Regional and language → Translation Management → **Providers**
  (route `entity.tmgmt_translator.collection`) → *Add Translator*, set *Translator plugin* = "phrase".
- Provider form is built by `Drupal\tmgmt_memsource\MemsourceTranslatorUi`.
- On save, `validateConfigurationForm()` calls `loginToMemsource()`; a bad URL/user/password
  fails validation with "Login incorrect". A successful login hex-encodes the password before it is
  persisted and caches an API token in `state`.

## Settings keys (stored on the translator entity's `settings` map)

| Key | Type | Meaning |
|---|---|---|
| `service_url` | string | Phrase TMS Home URL, e.g. `https://cloud.memsource.com/web` (required). `/web/...` suffixes are trimmed to `/web`. |
| `memsource_user_name` | string | Phrase TMS user name (required). |
| `memsource_password` | password | Stored hex-encoded with prefix `MEMSOURCE_V2___` (reversible; see `encodePassword`/`decodePassword`). |
| `enable_file_translation` | bool | Upload attached Office files with the XLIFF (default TRUE). |
| `memsource_update_job_status` | bool | Set the Phrase job to *Delivered* after import into Drupal. |
| `memsource_cron_use` | bool | Pull completed translations on cron. |
| `memsource_cron_start_hour` / `memsource_cron_end_hour` | select (0–23) | Active window; cron pulls only when `start <= hour < end` (defaults 8 / 18). |
| `memsource_cron_time` | int (min 5) | Minutes between pulls. |
| `memsource_cron_limit` | int | Max job items per cron run (default 100). |
| `memsource_connector_token` | select | Phrase *preview connector* (`localToken` of a `DRUPAL_PLUGIN` connector); only shown once the connection succeeds. |

The declared config schema `tmgmt.translator.settings.memsource` only covers `auto_accept`, `url`,
`client_id`, `client_secret`; the keys above are set by the UI and are the ones that matter in
practice. `config/install/tmgmt_memsource.settings.yml` ships only `debug: false`.

## Per-job (checkout) settings — `checkoutSettingsForm()`

Set when submitting a job to this provider: `project_template` (Phrase template id, `0` = none),
`due_date` (`Y-m-d`, forwarded as EOD UTC), `group_jobs` (one Phrase project for the whole group),
`force_new_project`, and a hidden `batch_id` used to correlate grouped jobs.

## Runtime flow (grounding, not something you call directly)

1. `requestTranslation()` → creates/re-uses a Phrase project (`newTranslationProject`, optionally
   `applyTemplate`), exports each item to XLIFF (`tmgmt_file` `xlf`), uploads job parts, and stores a
   `tmgmt_remote` RemoteMapping per item keyed by project uid + job part uid.
2. Completed work returns via cron, the *Pull translations* button
   (`MemsourceTranslatorUi::submitPullTranslations` → `fetchTranslatedFiles`), or the webhook.
3. API calls go through `sendApiRequest()` → `request()` (Guzzle `http_client`); token auto-refresh
   on HTTP 401 via `loginToMemsource()`. Token stored in `state` key
   `tmgmt_memsource.token.<translator_id>`.

## Routes

| Route | Path | Access | Purpose |
|---|---|---|---|
| `tmgmt_memsource.callback` | `/tmgmt_memsource_callback` | `_access: 'TRUE'` | Inbound webhook; Phrase POSTs job-part status JSON → module pulls/imports that job part. |
| `tmgmt_memsource.no_preview` | `/no_preview` | `_access: 'TRUE'` | Static "No preview url available" text. |
| `tmgmt_memsource.pull_all_remote_translations` | `/pull_all_remote_translations` | `administer tmgmt` + `accept translation jobs` | Batch-pull all active/review items across memsource translators. |

## Cron

`memsource.cron_task` (`Cron\PullTranslationsTask`) is tagged `cron` and also force-invoked by
`tmgmt_memsource_cron()`. It queues `PullTranslationsWorker` items to pull completed translations,
respecting the per-translator active-hours window and item limit.
