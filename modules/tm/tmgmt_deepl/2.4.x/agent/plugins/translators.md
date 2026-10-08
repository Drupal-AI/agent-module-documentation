<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DeepL translator plugin, client factory, batch & queue

## Translator plugin

| Plugin id | Class | Label |
|---|---|---|
| `deepl_api` | `Plugin/tmgmt/Translator/DeeplApiTranslator` | DeepL API |

`DeeplApiTranslator` is a thin `@TranslatorPlugin` (`ui = DeeplTranslatorUi`, `logo = icons/deepl.svg`,
`files = TRUE`) extending the abstract `DeeplTranslator`, which implements TMGMT's
`ContinuousTranslatorInterface` + `DeeplTranslatorInterface`. This module defines **no plugin type of
its own**; it also provides a KeyType plugin `deepl_api_key` (see below). The old `deepl_free` /
`deepl_pro` plugins were removed — `DeeplTranslator::DEEPL_TRANSLATORS = ['deepl_api']`, and
`getTranslators()` lists saved providers using that plugin.

Language mapping is data-driven via `DeeplLanguageSupport` (service `tmgmt_deepl.language_support`):
`getDefaultRemoteLanguagesMappings()` / `getSupportedRemoteLanguages()` come from the DeepL API's
language list (cached), not a hardcoded table. `getSupportedRemoteLanguages()` returns `[]` (a cache
miss, retried) when the language list can't be fetched, so a degraded list is never pinned.

## Escaping

`DeeplTranslator` sets `escapeStart = '<deepl translate="no">'` / `escapeEnd = '</deepl>'` so
`**do not translate**` markers in the TMGMT data are wrapped for DeepL.

## Submit flow (`requestTranslation()` / `requestJobItemsTranslation()`)

1. `checkQuota()` calls `DeeplTranslatorApi::getUsage()` and, if `Usage::anyLimitReached()`, rejects
   the job **before** anything is sent (`$job->rejected(...)`) — no content leaves the site.
2. Otherwise each job item's translatable data is flattened to a `q` array, and translatable files
   collected. `useQueue()` decides:
   - **Queue** (`deepl_translate_worker`) when CLI (`PHP_SAPI === 'cli'`), the `system.cron` route,
     or a continuous job with `tmgmt.settings:submit_job_item_on_cron`.
   - **Batch** (`DeeplTranslatorBatch::buildBatch()`) for manual UI submits.

## Client factory (`DeepLClientFactory`, service `tmgmt_deepl.client_factory`)

Builds `DeepL\DeepLClient` instances (memoized). `createForTranslator()` resolves the key from the
Key entity, sets the app info (`tmgmt_deepl` or, unless `omit_partner_id`,
`deepl-partner-integration-undpaul`) and the module version, and attaches the PSR-3 logger only when
`log_api_requests` is on. `getRequeueDelay()` derives a re-queue delay (300–3600s) from the
library's own backoff window. TLS/HTTP is handled by the deepl-php SDK.

## Batch (`DeeplTranslatorBatch`, service `tmgmt_deepl.batch`)

Runs the translate/document operations, chunking texts by `max_queries`
(`ALLOWED_MAX_QUERIES = [5,10,20,30,40,50]`, `DEFAULT_MAX_QUERIES = 20`, capped at
`MAX_REQUEST_BODY_BYTES = 100 KiB`). Handles text results, document upload/poll/download, billed-
character metrics (`DeeplTranslationMetrics`) and failure classification
(`DeeplFailureClassifier` → `DeeplFailureOutcome`: suspend-queue / transient / permanent).

## Queue worker (`DeeplTranslateWorker`, id `deepl_translate_worker`)

`#[QueueWorker(id: 'deepl_translate_worker', cron: ['time' => 120])]`. Two payload stages: the first
translates texts and uploads documents; a `poll` stage re-queues itself (`DelayedRequeueException`,
clamped 60–900s) to poll DeepL document status until done or the `POLL_DEADLINE` (82800s) passes.
Throws `SuspendQueueException` (1h) on exhausted quota and `DelayedRequeueException` on transient
failure. Run via `drush queue:run deepl_translate_worker` or `drush cron`.

## Document handling

Document translations resolve local file paths through `FileSystem::realpath()`; upload/download
reserve a free destination URI (`getDestinationFilename(..., FileExists::Rename)`). Handles are
persisted by `DeeplDocumentHandleStore` (service `tmgmt_deepl.document_handle_store`) so an
interrupted document can be resumed from the same DeepL document rather than re-uploaded/re-billed.
`hook_cron` garbage-collects abandoned handles and rejects jobs whose translation batch was
orphaned; `hook_file_download` returns the download headers only when the requesting user can
`view` a `tmgmt_job` that uses the file.

## Usage & requirements

`DeeplTranslatorApi::getUsage()` caches the DeepL usage snapshot for 300s (`USAGE_TTL`) but never
caches a failed lookup. `hook_requirements` (runtime) reports per-provider usage, or a warning when
no DeepL provider is configured.

## KeyType plugin

`deepl_api_key` (`Plugin/KeyType/DeepLApiKeyType`, extends `AuthenticationKeyType`,
group `api_credentials`) — the key type selected for the DeepL key; `validateKeyValue()` verifies
the key against DeepL on save.
