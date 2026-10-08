<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The copy engine, LTS storage, and read routes

## Services (`localgov_forms_lts.services.yml`)

- `localgov_forms_lts_db` — a `Drupal\Core\Database\Connection` produced by
  `Database::getConnection` with `$key: localgov_forms_lts`. The handle to the second DB.
- `localgov_forms_lts.query.sql` — a `Drupal\Core\Entity\Query\Sql\QueryFactory` constructed with
  `@localgov_forms_lts_db`, tagged `backend_overridable`. This is the entity-query factory the LTS storage
  uses so entity queries hit the LTS DB, not the default one.

Constants (`src/Constants.php`): `LTS_DB_KEY`/`LTS_KEYVALUE_STORE_ID`/`LTS_LOGGER_CHANNEL_ID` = `localgov_forms_lts`;
`LAST_CHANGE_TIMESTAMP = last_copied_webform_sub_changed_ts`; `LTS_ENTITY_QUERY_SERVICE = localgov_forms_lts.query.sql`;
`COPY_LIMIT = 50`; `LTS_CACHE_ID_PREFIX = lts_values`; `LTS_CONFIG_ID = localgov_forms_lts.settings`;
`PII_REDACTOR_PLUGIN_MANAGER = plugin.manager.pii_redactor` (defined by parent `localgov_forms`).

## `LtsStorageForWebformSubmission` (extends core `WebformSubmissionStorage`)

A bespoke entity storage bound to the LTS DB:
- Constructor calls `parent::__construct(...)` then sets `$this->database = Database::getConnection(key: LTS_DB_KEY)`
  — so all reads/writes go to the LTS database. `setDatabaseConnection()` / `getDatabaseConnection()` expose it.
- `getFromPersistentCache()` returns `[]` and `setPersistentCache()` is a no-op — LTS has no persistent
  entity cache. `buildCacheId()` prefixes ids with `lts_values:` (vs core's `values:`) so static cache keys
  don't collide with the live storage.
- `getQueryServiceName()` returns `localgov_forms_lts.query.sql` (`LTS_ENTITY_QUERY_SERVICE`) so entity
  queries run against the LTS DB.
- Instantiated with `LtsStorageForWebformSubmission::createInstance($container, $webform_submission_entity_type_def)`.

## `LtsCopy` — the copy engine (`ContainerInjectionInterface`)

`LtsCopy::create($container, ?$pii_redaction_plugin)` builds it with `entity_type.manager`, `keyvalue`,
`logger.factory`, and an `LtsStorageForWebformSubmission` instance. Methods:

- `findLatestUpdateTimestamp()` — reads the keyvalue store (`localgov_forms_lts` / `LAST_CHANGE_TIMESTAMP`,
  default 0): when the last-copied submission changed.
- `findCopyTargets(int $count = -1)` — queries the **default** webform_submission storage for submissions
  with `changed > lastTs`, `in_draft = 0`, sorted by `changed`, optionally `range(0, $count)`. `accessCheck(FALSE)`
  (background/admin bulk operation).
- `findLastCopiedSubId()` — `MAX(sid)` aggregate over the **LTS** storage.
- `copy(int $count = COPY_LIMIT)` — for each target: `copySub()`; then `setLatestUpdateTimestamp()` records
  the last copied submission's `getChangedTime()` into the keyvalue store. Returns `[sid => bool]`.
- `copySub(int $sid, bool $is_new)` — loads the submission from the **default** storage; if a PII redactor
  plugin is set, `$plugin->redact($webform_sub)` **mutates the loaded entity in place** before saving;
  opens a transaction on the LTS connection and `LtsStorageForWebformSubmission::resave(...)` — with
  `enforceIsNew()` when the sid is greater than the LTS max (new insert) else a plain resave (update).
  Rolls back and logs an error on exception; returns success bool.

`.module` helpers: `localgov_forms_lts_copy_recently_added_n_updated_subs()` (cron entry, checks
`is_copying_enabled`, builds the redactor, runs `copy()`, logs summary) and
`_localgov_forms_lts_prepare_feedback_msg()` (splits results into copied/failed sid lists for the log line).

**PII redaction** is delegated to whatever plugin id is configured; the plugin comes from the parent module's
`plugin.manager.pii_redactor`. LTS never inspects PII itself — it just calls `redact()` on the entity before
the LTS save when a plugin is selected.

## Read UI

### `WebformSubmissionLtsListBuilder` (extends `WebformSubmissionListBuilder`)
`createInstance()` swaps `$instance->storage` for an `LtsStorageForWebformSubmission`, re-`initialize()`s and
recomputes columns — so the list reads from the LTS DB. `getDefaultOperations()` keeps only **View** and
**Notes** ops, each re-pointed to the LTS routes (`entity.webform_submission.lts_view` / `…lts_notes`).
Rendered by route `entity.webform_submission.lts_collection`.

### `WebformSubmissionLtsViewController` (extends core `WebformSubmissionViewController`)
`create()` attaches an `LtsStorage` instance. `viewFromLts($webform_sid, …)` loads the submission from LTS
(`$this->ltsStorage->load($sid)`) then delegates to `parent::view(...)`. `noteViewFromLts(...)` returns
`['#markup' => '<pre>' . $webform_sub->getNotes() . '</pre>']` (admin notes; `#markup` is admin-xss-filtered
by the renderer). `titleFromLts(...)` delegates to `parent::title(...)`.

### Routes / access (`localgov_forms_lts.routing.yml`, `.links.task.yml`)
- `entity.webform_submission.lts_collection` → `/admin/structure/webform/submissions/lts/{submission_view}`.
- `entity.webform_submission.lts_view` → `/admin/structure/webform/manage/{webform}/submission/{webform_sid}/lts`.
- `entity.webform_submission.lts_notes` → `…/submission/{webform_sid}/notes/lts`.
- All three: `_custom_access: \Drupal\webform\Access\WebformAccountAccess:checkSubmissionAccess`, which allows
  `administer webform` OR `administer webform submission` OR `view any webform submission` — the same
  site-wide "any submission" gate core uses for its own submission views (no lower-privilege path is opened).
- Task links add an "LTS" tab to the submissions collection and View/Notes tabs to the LTS view.

## Install schema (`localgov_forms_lts.install`)
See config/settings.md §2: `hook_install()` recreates the webform_submission storage schema in the LTS DB;
`hook_requirements()` reports LTS DB availability. `_localgov_forms_lts_get_webform_submission_storage_schema()`
uses an anonymous `WebformSubmissionStorageSchema` subclass to reach the protected `getEntitySchema()`.

## Tests
`tests/src/Kernel/LtsStorageForWebformSubmissionTest.php`, `tests/src/Unit/LtsCopyTest.php` cover the storage
and copy logic.
