# Maestro — engine settings, the orchestrator & starting processes

## Settings form
Route `maestro.maestro_admin_settings` at `/admin/config/workflow/maestro`, permission
`administer site configuration`. Config object `maestro.settings` (`MaestroEngineSettingsForm`):

| Key | Type | Meaning |
|---|---|---|
| `maestro_redirect_location` | string | URI used in notification links to send recipients to. |
| `maestro_send_notifications` | bool | Master switch for assignment/reminder/escalation emails. |
| `maestro_orchestrator_task_console` | bool | Run the orchestrator on every Task Console refresh. |
| `maestro_orchestrator_token` | string | Secret appended to `/orchestrator/<token>`. Randomly generated at install (`Crypt::randomBytesBase64()`); editable here. |
| `maestro_orchestrator_lock_execution_time` | int (s) | Lock duration for an orchestrator run (defaults to 30 if ≤ 0). |
| `maestro_orchestrator_development_mode` | bool | Cache-reset entities during orchestration (debugging). |
| `maestro_sitewide_token` | string | The **query-key name** used when task URLs carry a token (default `maestro-token`); an obfuscation key name, not an access secret. |
| `maestro_token_zero_user` | bool | Enable the "zero-user" notification mechanism (only settable when the sitewide token is set). |

## The orchestrator (advances running processes)
Route `maestro.orchestrator` → `/orchestrator/{token}`, requirement `access content`, but the
controller (`MaestroOrchestrator::orchestrate`) returns **500** unless `token` equals
`maestro.settings:maestro_orchestrator_token`. It acquires the `maestro_orchestrator` lock and runs
`MaestroEngine::cleanQueue()`, which executes all runnable non-interactive tasks and provisions
assignments. Returns HTTP 204 on success. Run it by:
- **Cron/curl:** `curl https://site/orchestrator/<token>` (schedule externally — Maestro does not
  self-schedule).
- **Drush:** `drush maestro:orchestrate` (see [../drush/drush.md](../drush/drush.md)).
- **Task Console refresh:** when `maestro_orchestrator_task_console` is on.
- Kicking off a process also runs the orchestrator once (`startProcess`).

## Starting a process
- **URL:** `maestro.start_process` → `/maestro/start/process/{templateMachineName}/{redirect}`,
  permission `start maestro process` (restrict access). Only **validated** templates start.
- **Drush:** `drush maestro:start-process <template_machine_name>`.
- **API:** `(new MaestroEngine())->newProcess('<template>')` returns the new process id (or FALSE if
  the template is not validated). See [../api/engine.md](../api/engine.md).

## Executing interactive tasks
Route `maestro.execute` → `/maestro/execute/task/{queueid_or_token}/{modal}`, permission
`access content`. `MaestroInteractiveFormBase` resolves a numeric arg as a queue id or a non-numeric
arg as a per-task token, then **enforces access with `MaestroEngine::canUserExecuteTask()`** (the
task must be assigned to the current user); the token alone does not grant execution.
