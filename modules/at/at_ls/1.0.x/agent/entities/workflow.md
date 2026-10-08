<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entities, workflow & processing

## Entities (src/Entity/)
### `at_ls_translation_request` (`AtlsTranslationRequest`)
Revisionable content entity. One request = one source entity → one target language. `admin_permission = administer at_ls_translation_request`. Collection `/admin/content/translation-request`. Fields: `origin_url`, `uid` (owner, defaults to anonymous/0 in `preSave`), `entity_type`, `entity_id`, `source_language`, `target_language`, `created`, `changed`, `attempts` (int), `status` (`state`, workflow `translation_request_default`), `translation_type` (sync/async), `content` (`json_native` — the serialized source content). `isProcessable()` is true while `status == INIT_WORKFLOW_STATE` ('review'); `getProcessableState()` returns that. Forms: `edit`, `process` (`Form\ProcessAtlsTranslationRequestForm`, guarded by `Access\AtlsTranslationRequestAccessCheck::checkProcess`).

### `at_ls_string` (`AtlsString`)
Revisionable content entity, one source string. `admin_permission = administer at_ls_string`. Collection `/admin/content/string`. Fields: `status` (`state`, workflow `string_default`), `uid`, `created`, `changed`, `source_language`, `target_language`, `source_text`, `target_text`, `hash`, `translation_request` (ref), `atls_token`, `translation_type`. `getHash($src,$tgt,$text) = hash('sha256', $src.$tgt.$text)` and is set in `preSave` — this is the dedup key. `isReady()` = status 'delivered' AND non-empty `target_text`. `getUrlCallback()` builds the absolute `at_ls.asynchronous_callback` URL (with an empty `code` query param) that is sent to AT-LS as the async callback.

## Workflows (at_ls.workflows.yml, state_machine)
- `string_default` (group `string`): states `review, pending, delivered, removed, error`.
- `translation_request_default` (group `translation_request`): states `pending, processed, refused`; transitions `to_pending`, `to_processed`, `to_refused`. The guard `at_ls.translation_request.processed_guard` (`Guard\ProcessGuard`) blocks the `to_processed` transition unless the request's strings are all `isReady()`; if not, it runs `AtlsTranslationRequestManager::process()` and re-checks.

## Trigger paths
1. **Manual**: `hook_entity_operation` / `hook_entity_type_alter` / `hook_menu_local_tasks_alter` (`at_ls.module`) add an "AT-LS Translate" action + local task on translatable entities that are mapped and language-configured. It opens `at_ls.translation_request` → `Form\CreateAtlsTranslationRequestForm` (confirm form): pick target languages + type, then `createTranslationRequests()` builds content via `AtlsTranslationRequestManager::buildContent()`, creates one `at_ls_translation_request` per target, saves it, and dispatches `AtlsTranslationRequestEvent::INSERT`.
2. **Automatic**: `hook_entity_insert` / `hook_entity_update` dispatch `AtlsTranslatableEntityEvent`. `EventSubscriber\AtlsTranslatableEntityEventSubscriber` — if `automatic_enable` and the entity type/bundle is in `automatic_settings` (and, on update, translatable fields actually changed) — builds content and creates a request per configured target language.

## Processing pipeline
`AtlsTranslationRequestEventSubscriber::insert()` (on INSERT) does two things: `createJob()` enqueues an Advanced Queue `translation_request_job` on queue `translation_requests`, and `createStrings()` creates/updates one `at_ls_string` per source value (deduped by hash; a SYNC string can be upgraded to ASYNC).

`Plugin\AdvancedQueue\JobType\AtlsTranslationRequestJob::process()` (queue runner): skips if the request is no longer `isProcessable()`, else dispatches `AtlsTranslationRequestEvent::PROCESS`. Async failures return `JobResult::failure($msg, 42, 14400)` → retry up to 42× every 4h (~1 week); sync failures fail once.

`AtlsTranslationRequestEventSubscriber::process()` increments `attempts`, applies transition `to_processed` (the guard runs `AtlsTranslationRequestManager::process()` which calls the API — `processSynchronous()` translates inline; `processAsynchronous()` sends `translateAsynchronous` first time (storing the returned `atls_token`) then later `getFileByToken` per token). When the request reaches 'processed', `updateEntity()` → `updateTranslation()` writes the delivered `target_text` back onto the Drupal entity: it adds/loads the target-language translation, recurses into mapped entity-reference / entity-reference-revisions fields (`createEntity()` for referenced entities), sets translatable field values from the matching strings (looked up by hash), and saves as a new revision (`entitySave()`).

## Async delivery callback
AT-LS calls `/atls/asynchronous?code=<atls_token>` → `Controller\AtlsAsyncCallbackResponse::ping()`: it loads the `at_ls_string` whose `atls_token` matches `code`, calls `getFileByToken()`, sets the string's `status` (mapped from the AT-LS numeric code) and, if present, its `target_text` (base64-decoded JSON `text`), then saves. Returns a JSON `{status:'success', …}`.
