# Maestro — permissions & entity access

## Static permissions (`maestro.permissions.yml`)
| Permission | restrict access | Gates |
|---|---|---|
| `administer maestro templates` | **TRUE** | Template editor, template list/add/edit/delete, trace/delete tools, process-entity settings. |
| `start maestro process` | **TRUE** | Starting a process via `/maestro/start/process/*`. |
| `administer maestro queue entities` | **TRUE** | Queue admin form; task reassignment; toolbar orchestrator/monitoring links. |
| `add/edit/delete/view maestro queue entities` | — | CRUD on `maestro_queue` (mostly for Views listings). |
| `add/edit/delete/view maestro process entities` | — | CRUD on `maestro_process`. |
| `administer maestro production assignment entities` | **TRUE** | Reassignment admin form. |
| `add/edit/delete/view maestro production assignment entities` | — | CRUD on `maestro_production_assignments`. |
| `add/edit/delete/view maestro entity identifiers entities` | — | CRUD on `maestro_entity_identifiers`. |
| `administer maestro entity identifiers entities` | **TRUE** | Entity-identifier admin. |

The non-restricted `*_entities` CRUD permissions exist mainly so the shipped Views can list
process/queue/assignment data; they operate on Maestro's own bookkeeping entities.

## Dynamic permissions (`MaestroEnginePermissions::permissions`)
One permission per template: `start template <template_id>` — "Put the *<label>* template into
production" (only validated templates can be started). Grant this to let a role start a specific
workflow without the blanket `start maestro process`… (note: the start-process route itself still
requires `start maestro process`; the per-template perms are surfaced for assignment/checks).

## Task-console view permission
`view maestro task console` gates the AJAX process-status endpoints
(`/maestro/ajax/status/*`); the Task Console UI ships in the `maestro_taskconsole` submodule.

## Entity access handlers
`MaestroProcessAccessControlHandler`, `MaestroQueueAccessControlHandler`,
`MaestroProductionAssignmentsAccessControlHandler`, `MaestroEntityIdentifiersAccessControlHandler`,
and `MaestroTemplateAccessController` map the CRUD permissions above onto their entities.

## Runtime task-execution access
Independent of the entity CRUD perms: executing an interactive task requires the task to be
**assigned** to the current user (`MaestroEngine::canUserExecuteTask()`), alterable via
`hook_maestro_can_user_execute_task_alter`.
