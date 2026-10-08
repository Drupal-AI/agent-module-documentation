<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# rules_scheduler submodule (work in progress)

A partial port of the Drupal 7 Rules Scheduler. It is shipped enabled-on-demand (`rules_scheduler/`), depends on `tr_rulez:^2.0`, and is **not enabled by default** on the reference site. Intended purpose: schedule a Rules **component** (an action set) to be evaluated at a future time via cron.

## Important: incomplete in 2.0.0
Several critical pieces are stubbed, so end-to-end scheduling does not actually run yet. Treat this as scaffolding, not a working feature.
- `Plugin/RulesAction/ScheduleTask.php` — the `rules_scheduler_schedule` action's `doExecute($component, $date, $identifier)` is an **empty method body**. The class also still carries un-ported D7 methods (`rules_scheduler_action_schedule`, `*_info_alter`, `validate`, `help`, `*_form_alter`) that reference functions/classes that do not exist in D8+ (`rules_get_cache()`, `RulesState`, `rules_scheduler_schedule_task()`, `RulesPlugin`, `element_children()`), i.e. dead code.
- `DefaultTaskHandler::runTask()` — body is `/* @todo Implement! */`; it fetches the task data and does nothing. So even when a task reaches the queue worker, the component is never evaluated.
- `Form/ScheduleTaskForm::buildForm()` — begins with `return;` (returns nothing); the code beneath is un-ported D7 and unreachable. The manual "Schedule component" form is non-functional.
- `Form/DeleteTaskConfirmForm` uses a hardcoded `'temporary-label'` in its description (`@todo Fix label`).

## What IS implemented
- **`ScheduleDelete`** action (`rules_scheduler_delete`, category "Rules scheduler"): `doExecute($component_name, $task_identifier)` runs a real `DELETE` on the `rules_scheduler` table filtered by `config` and/or `identifier`. `validate()` requires at least one of component/task.
- **`Task`** object (`src/Entity/Task.php`) — NOT a Drupal entity; a plain object backed by the custom `rules_scheduler` DB table (schema in `rules_scheduler.install`: `tid, config, date, data (serialized blob), identifier, handler`). Provides `create/load/loadReadyToRun/schedule/delete`. `schedule()` upserts (delete-by-identifier then `merge`); `load()` `unserialize()`s the stored `data` blob.
- **`SchedulerManager`** service (`rules_scheduler.manager`, arg `@queue`): `queueTasks()` loads ready-to-run tasks (`date <= now`) and moves each into the reliable `rules_scheduler_tasks` queue, deleting it from the table.
- **`TaskWorker`** queue worker (`@QueueWorker id=rules_scheduler_tasks`, `cron time=15`): pops `Task` objects, instantiates `$task->getHandler()` (a class name) and calls `runTask()` (which the default handler leaves unimplemented); non-Task items are re-queued.
- **cron**: `rules_scheduler_cron()` calls `SchedulerManager::queueTasks()`.
- **UI**: `rules_scheduler_entity_operation_alter()` adds a "Schedule" operation to Rules components; routes (`rules_scheduler.routing.yml`) provide the admin schedule page (`/admin/config/workflow/rules/schedule`, embeds the `rules_scheduler` View + a delete form), a per-component schedule form, and a delete-task confirm form — all gated by `administer rules` (the schedule/delete-component routes also require `administer rules components`).
- **Drush**: `rules:scheduler-tasks` (aliases `rusch`, `rules-scheduler-tasks`) forces `queueTasks()` and, with `--claim[=SECONDS]`, claims and processes items from the queue (`RulesSchedulerDrushCommands.php`).
- **View**: `config/optional/views.view.rules_scheduler.yml` lists scheduled tasks; a Views filter `ComponentInOperator` and options provider `RulesComponentOptions` (lists `rules.component.*` config) support it.

## Security notes for agents
- All scheduler routes are admin-gated (`administer rules` [+ `administer rules components`]); there is no anonymous surface.
- `Task::load()` calls `unserialize()` on the `data` blob from the `rules_scheduler` table. In principle PHP object injection, but (a) the table is only written by `Task::schedule()` via `serialize()`, and that write path is not reachable in 2.0.0 because the schedule action is stubbed; (b) writing to it requires DB access or the (broken) admin scheduling flow. Not exploitable in the shipped state — noted as defense-in-depth only.
- `ScheduleDelete` uses parameterized `->condition()` calls — no SQL injection.
