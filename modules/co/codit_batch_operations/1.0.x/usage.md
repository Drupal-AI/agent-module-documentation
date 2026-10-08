Codit: Batch Operations is a developer framework for defining named, resumable, fully-logged batch jobs that can be run from update hooks, deploy hooks, cron, Drush, or an optional UI.

---

Instead of writing one-off Drush scripts or throwaway hook_update_N loops, you write a BatchOperation class that implements `BatchScriptInterface` — it gathers items, processes them one at a time, and records every step into a `BatchOpLog` entity. The identical script can then be triggered from `hook_update_N()`, `hook_post_update_NAME()`, `drush deploy` hooks, cron, the `drush codit-batch-operations:run` command, or the optional web UI submodule. Runs keep state, so an interrupted job (error, exception, PHP timeout, ctrl-c, navigating away) resumes where it left off; jobs can either stop on the first error or skip failing items and continue. Entity saves are attributed to a configurable default user, helper traits cover common node and taxonomy operations, and completed runs are auditable through log entities and a Views-based log list.

---

- Backfill or normalize a field across thousands of nodes during a deployment via `hook_post_update_NAME()` without hitting a PHP timeout.
- Turn a recurring content-maintenance task (archive stale nodes, re-save nodes to rebuild derived data) into a named, repeatable operation.
- Run a data migration or cleanup script from `hook_update_N()` so it executes exactly once as part of `drush updb` / `drush deploy` / update.php.
- Schedule a batch job to run on cron using human-readable timings like "every 2 days" or "on the 4th of July after 14:00".
- Give a trusted site editor a UI button to run a pre-written maintenance script without shell access (via the `codit_batch_operations_ui` submodule).
- Execute an ad-hoc content operation from the command line with `drush codit-batch-operations:run MyScript`, optionally skipping errors with `--allow-skip`.
- List all available operations from the CLI with `drush codit-batch-operations:list`.
- Audit "did anyone run the backfill on production, and when?" by reading the BatchOpLog list instead of trawling shell history.
- Keep a durable per-run log (steps, errors, memory use, duration, item counts, who ran it, how) for every batch operation on the site.
- Guarantee a destructive operation can only ever complete once by returning `TRUE` from `getAllowOnlyOneCompleteRun()`.
- Resume a long-running job that timed out or was interrupted, without reprocessing items already handled.
- Mass-create taxonomy terms in a vocabulary using the `saveNewTerms()` helper from `BatchOperationsVocabularyTrait`.
- Iterate node revisions (latest, default, all, or default-and-forward) and re-save them with the helpers in `BatchOperationsNodeTrait`.
- Run a batch operation as a specific user (for correct authorship/attribution on entity saves) by calling `switchUser($uid)` in `preRun()`.
- Do setup before a run and teardown after (enable/disable maintenance mode, pause search indexing) using the optional `preRun()` / `postRun()` hooks.
- Add a completion summary and progress reporting to a long content operation through `getCompletedMessage()` and the log's item counters.
- Run a batch from custom code (event subscriber, submit handler) via `runByCustomCode()` when a true Batch API context is unavailable.
- Clear a stuck "already running" lock after a crashed run with `drush codit-batch-operations:running --reset` or the settings page.
- Purge accumulated run history with the "Delete all batch operation logs" action before uninstalling the module.
- Point the framework at your own module's `src/cbo_scripts/` directory so your scripts live in version control alongside the rest of your code.
- Prototype and learn the framework from the bundled example/test scripts and the `StarterScript.php.txt` template.
- Enable the UI submodule only when maintenance is needed and disable it otherwise, keeping the run surface closed on production the rest of the time.
