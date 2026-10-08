# Maestro — engine API, entities & constants

`Drupal\maestro\Engine\MaestroEngine` is the static façade for everything (instantiate `new
MaestroEngine()` only for the few instance methods: `newProcess`, `cleanQueue`, debug/dev-mode
toggles). Selected methods (all `public static` unless noted):

## Processes
- `newProcess($templateName, $startTask='start')` *(instance)* — create + kick off a process from a
  **validated** template; returns the new process id or FALSE. Seeds process variables (incl.
  `initiator`, `workflow_timeline_stage_count`, `workflow_current_stage`).
- `endProcess($processID)`, `abortProcess($processID)`, `deleteProcess($processID)`.
- `setProcessLabel($processID, $label)`, `getProcessEntryById($processID)`,
  `getTemplateIdFromProcessId($processID)`.
- `cleanQueue()` *(instance)* — the orchestrator body: execute runnable tasks, provision assignments.

## Templates
- `getTemplates()`, `getTemplate($machineName)`, `getTemplateTaskByID($tpl,$taskID)`,
  `getTemplateTaskByQueueID($queueID)`, `getTemplateVariables($tpl)`.
- `saveTemplateTask($tpl,$taskMachineName,array $task)`, `removeTemplateTask($tpl,$task)`.
- Pointer helpers: `getTaskPointersFromTemplate`, `getTaskTruePointersFromTemplate`,
  `getTaskFalsePointersFromTemplate`.
- `performTemplateValidityCheck($tpl)`, `setTemplateToUnvalidated($tpl)`.

## Queue / tasks
- `completeTask($queueID, $userID=0)`, `setTaskStatus($queueID, $status=TASK_STATUS_SUCCESS)`,
  `archiveTask($queueID,$archiveStatus=TASK_ARCHIVE_NORMAL)`, `unArchiveTask($queueID)`.
- `getQueueEntryById($queueID)`, `getQueueItemTaskData($queueID,$key=NULL)`,
  `setQueueItemTaskData($queueID,$key,$value,$configKey=NULL)`, `setProductionTaskLabel($queueID,$label)`.
- `getTaskIdFromQueueId`, `getProcessIdFromQueueId`, `getTokenFromQueueId($queueID)`,
  `getQueueIdFromToken($token)`.
- Suspension/regen: `setSuspensionFlag`, `getSuspensionFlag`, `getRegenCount`, `setRegenCount`,
  `getAncestryInformation`, `setAncestryInformation`.

## Assignment / access
- `getAssignedTaskQueueIds($userID)`, `getAssignedNamesOfQueueItem($queueID,$assoc=FALSE)`,
  `canUserExecuteTask($queueID,$userID)` (true only if the task is assigned to that user; alterable
  via `hook_maestro_can_user_execute_task_alter`).
- `getPluginTask($taskClassName,$processID=0,$queueID=0)` — instantiate a task plugin.

## Process variables
- `getProcessVariable($name,$processID)`, `setProcessVariable($name,$value,$processID)`
  (fires `hook_maestro_post_variable_save`), `getProcessVariableID($name,$processID)`.

## Entity identifiers (link created entities to a process step)
- `createEntityIdentifier($processID,$entityType,$entityBundle,$taskUniqueID,$entityID)`,
  `updateEntityIdentifierByEntityTableID(...)`,
  `getEntityIdentiferByUniqueID($processID,$taskUniqueID)`,
  `getEntityIdentiferFieldsByUniqueID(...)`, `getAllEntityIdentifiersForProcess($processID)`.

## Entities & base tables
| Entity type | Base table | Kind |
|---|---|---|
| `maestro_template` | (config) | Config entity — the task graph (`config_export` keys per `maestro.schema.yml`). |
| `maestro_process` | `maestro_process` | Content — a running/finished process. |
| `maestro_queue` | `maestro_queue` | Content — a task instance in a process. |
| `maestro_process_variables` | `maestro_process_variables` | Content — process variable values. |
| `maestro_production_assignments` | `maestro_production_assignments` | Content — who a task is assigned to. |
| `maestro_process_status` | `maestro_process_status` | Content — status/stage messages. |
| `maestro_entity_identifiers` | `maestro_entity_identifiers` | Content — entity ↔ process-step links. |

## Constants (`maestro.module`)
- Task status: `TASK_STATUS_ACTIVE=0`, `_SUCCESS=1`, `_CANCEL=2`, `_HOLD=3`, `_ABORTED=4`,
  `_FALSE_BRANCH=5`.
- Archive: `TASK_ARCHIVE_ACTIVE=0`, `_NORMAL=1`, `_REGEN=2`.
- Process: `PROCESS_STATUS_COMPLETED=1`, `PROCESS_STATUS_ABORTED=2`.
- Completion: `MAESTRO_TASK_COMPLETION_NORMAL=0`, `_USE_FALSE_BRANCH=1`.
- Suspension: `MAESTRO_UNSUSPENDED=0`, `MAESTRO_SUSPEND=1`, `MAESTRO_ALLOW_SUSPENDED_COMPLETION=2`.
