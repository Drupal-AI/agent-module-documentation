<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The BatchOperation framework — writing and running scripts

Source: `src/BatchOperations.php`, `src/BatchScriptInterface.php`, `src/BatchOperationsFilesTrait.php`,
`src/BatchOperationsNodeTrait.php`, `src/BatchOperationsVocabularyTrait.php`, `codit_batch_operations.module`.

## What a script is

A "BatchOperation" is a PHP class that **extends `Drupal\codit_batch_operations\BatchOperations`**
(so it inherits the runner) and **implements `BatchScriptInterface`** (the methods you fill in). It
lives at `<your_module>/src/cbo_scripts/<ScriptName>.php`, namespace
`Drupal\<your_module>\cbo_scripts`. Copy `StarterScript.php.txt` (module root) as a starting point;
bundled examples are in `src/cbo_scripts/` (e.g. `TestDo10Things.php`,
`Example-ArchiveOldNodes.php.txt`).

Scripts are **not** an annotated plugin type. Discovery is filename-based: `getBatchOperations()`
(`BatchOperationsFilesTrait`) does `scandir(<script_location>/src/cbo_scripts/)` and returns the
`.php` basenames; `getNamespacedClassName()` builds the FQCN from config `script_location` (names
starting with `Test` are resolved inside `codit_batch_operations` itself); `getBatchOperationClass()`
instantiates via `\Drupal::classResolver()`. `<script_location>` comes from the settings config
object (see [../config/settings.md](../config/settings.md)); if unset, only the bundled `Test*`
scripts are shown.

## Interface methods (`BatchScriptInterface`)

Required to implement:
- `getTitle(): string` — human name (used in the UI list).
- `getCompletedMessage(): string` — final message; may contain `@completed` / `@total` tokens.
- `getAllowOnlyOneCompleteRun(): bool` — `TRUE` = may only ever complete once (see resume/lock).
- `gatherItemsToProcess(): array` — the set of items (e.g. `nid => nid` or `nid => node`).
- `processOne(string $key, mixed $item, array &$sandbox): string` — do the work for one item; return
  a log message. Throwing here triggers the error path (skip or fail).

Optional (base class supplies defaults):
- `getDescription(): string` (default `''`), `getItemType(): string` (default `'item'`, used to
  prefix keys), `getTotalItemCount(): int`.
- `preRun(&$sandbox): string` / `postRun(&$sandbox): string` — setup/teardown run once each
  (maintenance mode, indexing…). (`preBatchMethod`/`postBatchMethod` are the deprecated pre-1.0.1
  names, removed in 2.0.0.)
- `getCronTiming(): string|array` — human-readable cron pattern(s), default `''`. Examples:
  `'every 10 minutes'`, `'every 2 days'`, `'on the 4th of July after 14:00'`, or an array of these.
- Extra base hooks: `canBatchRun(): bool` (skip the whole run if `FALSE`), `getBatchSize(): int`
  (framework returns `1`; larger sizes are not currently wired up).

## How a run executes (`BatchOperations::run()`)

`run(array &$sandbox, string $executor, bool $allow_skip = FALSE): string`:
1. `setExecutor($executor)` — one of `UI`, `drush`, `cron`, `hook_update`, `post_update`, `deploy`
   (also stamped on the log's `executor` field).
2. `initSandbox()` (first pass only): calls `checkAndSetCanRun()` (the lock, below), then
   `gatherItemsToProcess()` → keys are stringified (`getItemType()_<id>`), `preRun()` is called,
   `total_items` recorded, `switchUser()` applied. If a resume state exists in
   `state('cbo_<ScriptClass>')`, `items_to_process` is sliced so processing continues past the last
   completed item.
3. Processes a slice (`getBatchSize()`, default 1) by calling `processOne()`, appending each result
   to the log and advancing `last_item_processed`.
4. Error handling per item: on a `\Throwable`, if `$allow_skip` is `FALSE` it logs the error, runs
   `postRun()`, clears the run lock, switches the user back, saves the log, and **rethrows**; if
   `TRUE` it records the item under `skipped_items`, logs, and continues.
5. `completeSandbox()` updates counts, writes the resume position to state, and when
   `#finished === 1` writes `getCompletedMessage()`, marks the log completed, runs `postRun()`,
   switches back the user, and deletes both the resume-state key and the run lock. (Cron runs with
   zero items delete their log to avoid empty entries.)

Idempotence and "no undo" are the author's responsibility: `processOne()` runs arbitrary code that
mutates content at scale. Make scripts re-runnable and test against a copy.

## The run lock and "run once" (`checkAndSetCanRun()`)

- A single global lock is stored in `state('cbo_running_script')` = the running script's FQCN. Only
  the `drush` and `UI` executors are blocked from starting concurrently (hooks can't overlap). If a
  lock is stale, clear it with `drush codit-batch-operations:running --reset` or the settings page.
  A blocked start throws `\RuntimeException` (code `409`).
- If `getAllowOnlyOneCompleteRun()` is `TRUE` and the most recent `BatchOpLog` for this script is
  `completed`, the run is refused with `\RuntimeException` code `423`. To allow a re-run, delete that
  completed log entity.

## Executors — how to invoke the same script

- **hook_update_N** (`.install`): `$script = \Drupal::classResolver('\Drupal\MODULE\cbo_scripts\NAME');
  return $script->run($sandbox, 'hook_update');`
- **hook_post_update_NAME** (`.post_update.php`) and **drush deploy hooks** (`.deploy.php`): same
  pattern with `'post_update'` / `'deploy'`.
- **Cron**: implement `getCronTiming()` and enable cron processing in settings.
  `codit_batch_operations_cron()` finds every non-test script with a cron timing
  (`getBatchOperationsWithCron()`, cached), evaluates it via `Cron\CronManager`, and runs it in a
  `do…while` loop; last-run times live in the `codit_batch_operations_cron` table.
- **Drush**: `drush codit-batch-operations:run <ScriptName> [--allow-skip]` (see
  [../config/settings.md](../config/settings.md)).
- **UI**: enable `codit_batch_operations_ui` (its own tree). It calls the static Batch API callbacks
  `BatchOperations::runBatchByUi()` / `finishedBatchByUi()`, running as the current operator's user.
- **Custom code** (not a real Batch API context, so risks PHP timeout but still resumes):
  `$script->runByCustomCode('MyExecutorName', $allow_skip = TRUE);`

## User attribution

`getUser()` returns config `default_user` (falls back to UID 1). `switchUser($uid)` uses core's
`account_switcher` to act as a user during the run (log it once, or from `preRun()`); the UI path
sets the user to the current operator. `switchBackToOriginalUser()` unwinds the switch stack on
completion or fatal error (except cron).

## Content helper traits (available inside any script)

- `BatchOperationsNodeTrait`: `getNodeStorage()`, `getNidsOfType($bundle, $published_only)`,
  revision helpers `getNodeLatestRevision()` / `getNodeDefaultRevision()` / `getNodeAllRevisions()` /
  `getNodeDefaultAndForwardRevisions()`, and `saveNodeRevision()` /
  `saveNodeExistingRevisionWithoutLog()`.
- `BatchOperationsVocabularyTrait`: `getTermStorage()`, `saveNewTerms($vocabulary_id, array $terms)`.
- Utility: `mapToValue()` (key→value lookup with optional default/strict), `stringify()`.
