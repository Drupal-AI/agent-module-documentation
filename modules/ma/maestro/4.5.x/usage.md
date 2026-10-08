Maestro is a business-process / workflow engine for Drupal: you draw a workflow "template" of connected tasks (start, interactive, if/and/or, content-type, batch, set-variable, sub-flow, end), launch "processes" from it, and an orchestrator advances each running process through its task queue, assigning interactive tasks to users/roles/groups.

---

The base Maestro module provides the engine, the data model, and the task plugin system; the visual template editor, task console, and integrations ship as submodules. A **template** (`maestro_template` config entity) stores the task graph and per-task settings; **processes**, **queue** items, **process variables**, **production assignments**, **process status**, and **entity identifiers** are content entities (base tables `maestro_process`, `maestro_queue`, `maestro_process_variables`, `maestro_production_assignments`, `maestro_process_status`, `maestro_entity_identifiers`). Tasks are `MaestroEngineTaskInterface` plugins discovered from `Plugin/EngineTasks` (ids `MaestroStart`, `MaestroEnd`, `MaestroIf`, `MaestroAnd`, `MaestroOr`, `MaestroInteractive`, `MaestroContentType`, `MaestroManualWeb`, `MaestroBatchFunction`, `MaestroSetProcessVariable`, `MaestroSpawnSubFlow`); a second plugin type, `MaestroSetProcessVariablePlugin` (`Plugin/MaestroSetProcessVariablePlugins`), computes values for the Set-Process-Variable task. `MaestroEngine` is the static API façade (create/advance processes, complete/archive tasks, read/write process variables, manage entity identifiers). The **orchestrator** (`/orchestrator/{token}`, protected by a random per-site token generated at install, or Drush `maestro:orchestrate`, or Task-Console refreshes) runs `cleanQueue()` under a lock to execute non-interactive tasks and provision assignments. Processes start via `/maestro/start/process/{template}` (permission `start maestro process`), Drush `maestro:start-process`, or the `MaestroEngine::newProcess()` API. Interactive tasks are executed from a task console via `/maestro/execute/task/{queueid_or_token}` where access is enforced by task assignment (`canUserExecuteTask`). Notifications, tokens, dynamic per-template "start" permissions, and Views integration for the queue/process entities round it out. Depends on core Views.

---

- Model a multi-step content-approval workflow (draft → review → publish) as a Maestro template.
- Route an interactive review task to a specific user, role, or group and track completion.
- Branch a workflow conditionally with an If task based on a process variable.
- Converge parallel branches with And/Or join tasks.
- Have a Content Type task create/edit a node as a step in the flow (with accept/reject branches).
- Compute and store process variables mid-flow with the Set Process Variable task and its plugins.
- Pull a content-type field value into a process variable (GetContentTypeFieldValue plugin).
- Spawn a sub-workflow (SpawnSubFlow) and continue the parent when it completes.
- Run background/batch logic at a workflow step with the Batch Function task.
- Launch a process programmatically with `MaestroEngine::newProcess('template')`.
- Start a process from a URL (`/maestro/start/process/<template>`) gated by `start maestro process`.
- Advance running processes on a schedule by hitting `/orchestrator/<token>` from cron/curl.
- Advance the engine via Drush (`drush maestro:orchestrate`) instead of a web request.
- Run the orchestrator automatically whenever a Task Console refreshes.
- Complete a task in code with `MaestroEngine::completeTask($queueID, $uid)`.
- Read/write process state with `getProcessVariable()` / `setProcessVariable()`.
- Reassign an in-flight task to another assignee (`/maestro/reassign/task/{assignmentID}`).
- Trace / debug a running process and delete stuck tasks or processes (admin trace UI).
- Abort or end a process programmatically (`abortProcess()` / `endProcess()`).
- Associate created entities with a process step via entity identifiers for later lookup.
- Grant per-template "start" rights using the dynamically generated `start template <id>` permission.
- Expose queue/process/assignment data in Views (custom fields, filters, argument defaults).
- Send assignment/reminder/escalation notifications for tasks (configurable per task).
- Add a custom task type by implementing a `MaestroEngineTaskInterface` plugin.
- Add a custom value provider for Set-Process-Variable tasks via a `MaestroSetProcessVariablePlugin`.
- Alter engine behavior with hooks (assignment fetch, execute-access, template validation, notifications).
- Show process status/progress to users via the Maestro process-status block.
