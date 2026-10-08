<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `crowdin` TMGMT translator plugin

`CrowdinTranslator` — `src/Plugin/tmgmt/Translator/CrowdinTranslator.php`. Annotation
`@TranslatorPlugin(id = "crowdin", label = "Crowdin", ui = "Drupal\tmgmt_crowdin\CrowdinTranslatorUi")`.
Extends `TranslatorPluginBase`, implements `ContainerFactoryPluginInterface` and
`ContinuousTranslatorInterface`. Injects `http_client` (Guzzle), `plugin.manager.tmgmt_file.format`,
`config.factory`, and a `logger.factory` channel `tmgmt_crowdin`.

## Install / enable / configure

1. `composer require drupal/tmgmt_crowdin`; enable `tmgmt`, `tmgmt_file`, `tmgmt_crowdin`.
2. In TMGMT (Translation → Providers), add/select the **Crowdin** provider. The plugin UI
   (`CrowdinTranslatorUi::buildConfigurationForm()`) shows three fields: **Personal Access Token**
   (`personal_token`, required), **Project Id** (`project_id`, required), and **Enterprise Domain**
   (`domain`, optional — only for Crowdin Enterprise). A "Connect" button (`addConnectButton()`) plus
   `validateConfigurationForm()` verify the token by calling `getUser()` — an invalid token blocks
   saving.
3. `checkAvailable()` returns "yes" only when `personal_token` is set. `defaultSettings()` adds
   `xliff_cdata = TRUE`.

Settings are stored on the translator config entity `tmgmt.translator.crowdin`
(see [../config/settings.md](../config/settings.md)).

## API client — `request()`

- `request(TranslatorInterface $translator, string $path, array $params = [], string $method = 'GET')`
  builds a **new** `GuzzleHttp\Client` with `base_uri` from `getApiUrl($translator->getSetting('domain'))`.
- `getApiUrl()` returns `https://api.crowdin.com/api/v2/`, or `https://<domain>.api.crowdin.com/api/v2/`
  when an Enterprise domain is set (constants `PRIMARY_PROJECT_PROTOCOL = 'https'`,
  `PRIMARY_PROJECT_DOMAIN = 'api.crowdin.com/api/v2/'`). Always HTTPS; Guzzle default TLS
  verification.
- Auth header: `Authorization: Bearer <personal_token>` + `Content-Type: application/json`. GET params
  go to `query`; other methods merge `$params` (e.g. `json`, `body`, extra `headers`) via
  `array_replace_recursive`.
- Errors: a Guzzle `BadResponseException` or any HTTP ≥ 400 is rethrown as a `TMGMTException` with the
  status code/reason. Success returns `Json::decode($response->getBody())`.

## Submit workflow (Drupal → Crowdin)

`requestTranslation(JobInterface $job)` → `requestJobItemsTranslation(array $job_items)`:

1. Instantiate the `webxml` format plugin; get the job's translator; `getProject()` and verify the
   job's remote target language is in `project.data.targetLanguageIds` (else `TMGMTException`).
2. `createRootDirectory()` — find or create a Crowdin directory named **`Drupal Connector`**
   (`ROOT_DIRECTORY_NAME`) via `projects/{id}/directories`.
3. `createJobDirectory()` — create a per-job subfolder named `"<job label> (<job id>)"`, first
   sanitized by `sanitizeFolderName()` (strips `\ / : * ? " < > |`, collapses whitespace). On a 400
   (already exists) it looks the folder up by filter.
4. For each job item: `WebXML::export()` → XML; filename via `FORMAT_FILE_NAME =
   'Job_%d_JobItem_%d_%s_%s.xml'` (job id, item id, source lang, target lang). `addOrUpdateFile()`
   uploads the XML to the Crowdin **storages** endpoint (`Content-Type: octet-stream`,
   `Crowdin-API-FileName` header, raw `body`), then creates or (if a same-named file exists) PUT-updates
   a `projects/{id}/files` entry of type `webxml`, with `excludedTargetLanguages` = all project target
   languages except this job's. Marks the job item `active()` and records a `RemoteMapping`
   (`remote_identifier_1` = file id, `_2` = job folder id, `_3` = project id).
5. `requestFileWebhook()` — see [../api/webhook.md](../api/webhook.md).

`updateSourceData()` (UI submit) re-runs `requestJobItemsTranslation()` to push edited source texts.

## Retrieve workflow (Crowdin → Drupal)

- **Manual:** `submitFetchTranslations()` (UI button "Fetch translations") → `fetchTranslations($job)`:
  loads `RemoteMapping::loadByLocalData($job->id())`, and for each calls `updateTranslation()`.
- **`updateTranslation(JobItem, $project, $file_id, $target_language)`:** reads
  `getFileProgress()`; imports only when the target language's `translationProgress` is 100 (or
  `approvalProgress` 100 when the project's `exportApprovedOnly` / `exportWithMinApprovalsCount` is
  set). Calls `importTranslation()`.
- **`importTranslation()`:** `getFile()` builds/downloads the translated file
  (`projects/{id}/translations/builds/files/{file_id}`, POST); `WebXML::validateImport($url)` verifies
  the file's `job-id`, `source-language` and `target-language` match the job before
  `WebXML::import($url)` and `$job_item->getJob()->addTranslatedData(...)`. Mismatched job id → error.

## Abort

`abortTranslation($job)` sets each job item to `STATE_ABORTED`, then `removeJobDirectory()` deletes the
Crowdin job folder (`DELETE projects/{id}/directories/{folder_id}`; ignores 404), and sets the job to
`STATE_ABORTED`.

## Helpers

- `getSupportedRemoteLanguages()` — `GET languages?limit=500`, id → name.
- `getProject()` / `getUser()` — `GET projects/{id}` / `GET user`.
- `getCrowdinData()` / `setCrowdinData($key, $value)` — read/write keys on the
  `tmgmt_crowdin.settings` config object (used for `webhook_id_by_project_id`).
- `getProjectId()` — reads `settings.project_id` from `tmgmt.translator.crowdin`.

## Checkout UI (`CrowdinTranslatorUi`)

- `checkoutSettingsForm()` adds a per-job **Job Description** textarea
  (`settings.templates_wrapper.description`), passed to Crowdin translators for context; echoed
  read-only in `checkoutInfo()`.
- `checkoutInfo()` on an active job shows **"Fetch translations"** and **"Update Source Texts"**
  submit buttons.
