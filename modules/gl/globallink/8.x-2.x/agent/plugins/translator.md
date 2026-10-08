<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GlobalLink translator plugin, SOAP adapter & job lifecycle

## Plugin

`GlobalLinkTranslator` — `src/Plugin/tmgmt/Translator/GlobalLinkTranslator.php`,
`@TranslatorPlugin(id = "globallink", ui = GlobalLinkTranslatorUi, logo = "icons/globallink.png")`.
Extends `TranslatorPluginBase`; implements `ContainerFactoryPluginInterface`,
`ContinuousTranslatorInterface`, and `MultipleCheckoutInterface`. Because older TMGMT lacks
`MultipleCheckoutInterface`, the file top-`class_alias`es a BC stub if the interface is missing.

Injected via `create()`: `globallink.gl_exchange_adapter`, `plugin.manager.tmgmt_file.format`,
`logger.factory`→`globallink`. Message-level constants `MSG_STATUS/DEBUG/WARNING/ERROR`. It also
carries a large hard-coded `$globallinkDefaultLangcodeMapping` (langcode → human name) used by
`getSupportedRemoteLanguages()`.

## SOAP adapter — `GlExchangeAdapter` (`src/GlExchangeAdapter.php`)

Service `globallink.gl_exchange_adapter` (args: `entity_type.manager`, `module_handler`,
`extension.list.module`). On construction it loads the translator entity **`globallink`** by machine
name (`@todo` notes it does not handle multiple translators of the same type). Factory methods:
- `getPDConfig($settings)` → `\PDConfig` with `url` (trailing slash stripped via a `strrev`/`ord`
  trick), `username`, `password`, `userAgent` (= `pd_user_agent`).
- `getGlExchange(\PDConfig)` → `\GLExchange`; sets adaptor name `Drupal`, adaptor version
  `\Drupal::VERSION`, client version from the module's `info.yml`. **Constructing `\GLExchange`
  authenticates and creates the SOAP service clients** (from the vendor library).
- `getPdDocument($params)` → `\PDDocument` (fileformat=classifier, name, source/target languages,
  XLIFF data, clientIdentifier).
- `getSubmission(\PDProject, $params)` → `\PDSubmission` (name, submitter, isUrgent, instructions,
  dueDate).
- Const `COMPLETED_BY_PROJECT_MAX_RESULT = 500`.

## Request path (upload)

`requestTranslation()` / `requestTranslationMultiple()` / `requestJobItemsTranslation()` all funnel
into **`doRequestTranslations($job_items, $job)`**:
1. Resolve remote source/target languages and job settings; compute `dueDate` (continuous:
   `+required_by weekday`; discrete: the job's `due` object) as a **millisecond** unix timestamp.
2. If no active session yet: build `\PDConfig`+`\GLExchange`, `getProject($pd_projectid)`, build the
   submission (submitter defaults to `pd_username`, but is replaced by the current Drupal username
   when `isSubmitterValid($projectid, $userName)`), `initSubmission()`.
3. Export XLIFF with `getXliffData()` — `formatManager->createInstance('xlf')->export()`, then a
   SimpleXML pass copies `source`→`target` per trans-unit and adds a `<preview>` child holding each
   job item's absolute source URL. If `pd_combine` is set, one document for all items; else one
   `\PDDocument` per item. Each is `uploadTranslatable()`ed.
4. When `startSubmission` is true (last job in a multiple-checkout batch), `startSubmission()` and
   record a TMGMT **remote mapping** per item (`remote_identifier_1` = submission id,
   `remote_identifier_2` = upload id); items move to `active`.
5. Any exception ⇒ `$job->rejected(...)` + logged error.

## Retrieval path (download)

- `getCompletedTranslations($translator)` → `getProject()->getCompletedTargetsByProject($project,
  500)` returns `\PDTarget[]`.
- `retrieveTranslation($ticket_id, $job)`: `downloadTarget($ticket_id)` → parse XLIFF with
  `simplexml_load_string(..., LIBXML_NOCDATA)`, strip the injected `<preview>` nodes, import via
  `formatManager->createInstance('xlf')->import($data, FALSE)`, `addTranslatedData()`, then
  `sendDownloadConfirmation($ticket_id)`. Parse failures are surfaced via `getLibxmlErrorMessage()`
  and a job error message.
- `fetchJobs($job)`: pulls completed targets and imports those whose `clientIdentifier` equals the
  job uuid (the "Pull translations" button path).
- `abortTranslation($job)`: loads the job's remote mappings, `cancelSubmission(remote_identifier_1,
  'Submission aborted by user')` **once** (all items share one submission), aborts each job item,
  then delegates to the parent.
- `checkAvailable()`: caches per-request; tries to build a `\GLExchange` and returns
  `AvailableResult::yes()`/`no()`.

## Language support

`getSupportedRemoteLanguages()` returns the built-in langcode map. `getSupportedLanguagePairs()`
calls `getProject($pd_projectid)->languageDirections` and returns source/target pairs (empty array on
error). `getSupportedTargetLanguages()` filters those pairs by the mapped remote source language.

## Cron & automatic pull — `globallink_cron()` (`globallink.module`)

Loads all `tmgmt_translator` entities with `plugin = globallink`; for each, if `pd_projectid` is
empty it warns and returns; otherwise fetches completed translations and, for every completed target
whose `clientIdentifier` matches a `tmgmt_job` uuid, calls `retrieveTranslation()`. So completed
translations flow back **on every cron run** without user action.

## Continuous-job exclusion filters — `GloballinkContinuousEvents`

`src/EventSubscriber/GloballinkContinuousEvents.php`, service `globallink.should_create_job`,
subscribes to TMGMT `ContinuousEvents::SHOULD_CREATE_JOB`. For content-plugin continuous jobs it
loads the entity and applies each configured filter: `url` (matches the entity's path alias against a
wildcard pattern via `path.matcher`) or `id` (entity id equals). A match calls
`setShouldCreateItem(FALSE)` so that item is excluded from the continuous job.

## Notification hooks (`globallink.module`)

- `hook_tmgmt_message_insert()`: when a TMGMT message is saved on a `globallink` job and its type is
  in `pd_notify_level` and `pd_notify_emails` is set, sends mail via `plugin.manager.mail`
  (`globallink`/`log`).
- `hook_mail()` key `log`: builds the notification subject/body.
- `hook_theme()`: registers the `globallink_comments` template.
