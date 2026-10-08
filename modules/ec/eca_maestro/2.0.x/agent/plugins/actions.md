<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA Maestro — action plugins

Eight `@Action` plugins in `src/Plugin/Action/`. Seven extend `eca\Plugin\Action\ConfigurableActionBase`;
one (`MaestroGetQueueIdFromQuery`) extends `eca_endpoint\Plugin\Action\RequestActionBase`. All
`use MaestroTrait` (see [../internals.md](../internals.md)) and declare
`externallyAvailable(): FALSE`. Config keys are the `EcaMaestroConstants::ECA_MAESTRO_*` strings;
all field values pass through the ECA token service, so they support tokens. On failure each logs
to the `eca_maestro` channel and returns without throwing.

## eca_maestro_new_process — "Maestro: new process"
`MaestroNewProcess::execute()`. Loads the template via `MaestroEngine::getTemplate($template)`; if
found, `(new MaestroEngine())->newProcess($template, $start ?: 'start')` launches it. On success
optionally writes the new PID into a token (`addTokenData`) and logs "Process started (@pid)".
Config: `eca_maestro_template` (required), `eca_maestro_start` (default `start`),
`eca_maestro_token` (optional PID token name). Invalid template → warning; no PID → error.

## eca_maestro_complete_task — "Maestro: complete task"
`MaestroCompleteTask::execute()`. `MaestroEngine::completeTask($queueId, $this->currentUser->id())`
— completes the task as the **current user**. Config: `eca_maestro_queueid` (required).

## eca_maestro_set_task_status — "Maestro: set task status"
`MaestroSetTaskStatus::execute()`. `MaestroEngine::setTaskStatus($queueId, $status)`. Config:
`eca_maestro_queueid` (required), `eca_maestro_status` (required int: `0`=active, `1`=success,
`2`=cancel, `3`=hold, `4`=aborted).

## eca_maestro_reassign — "Maestro: reassign task"
`MaestroReassign::execute()`. Loads the `maestro_production_assignments` entity by ID via
`entityTypeManager`, sets `assign_id` to the assignee, forces `by_variable` to `'0'` (fixed value),
and saves. Config: `eca_maestro_type` (required, default `user`; "user" or "role"),
`eca_maestro_assignee` (required — user display name or role name), `eca_maestro_id` (required,
the assignment record ID, `#type number`). Missing assignee / record not found → error.

## eca_maestro_get_process_variable — "Maestro: get process variable"
`MaestroGetProcessVariable::execute()`. `MaestroEngine::getProcessVariable($varName, $processId)`,
then `addTokenData($tokenName, $value)`. Config (all required): `eca_maestro_token` (target token),
`eca_maestro_varname` (Maestro variable), `eca_maestro_processid`.

## eca_maestro_set_process_variable — "Maestro: set process variable"
`MaestroSetProcessVariable::execute()`. `MaestroEngine::setProcessVariable($name, $value, $processId)`.
The variable must already exist in the Maestro template. Config (all required):
`eca_maestro_varname`, `eca_maestro_value`, `eca_maestro_processid`.

## eca_maestro_process_id_from_queue_id — "Maestro: set process id from queue id"
`MaestroProcessIdFromQueueId::execute()`. `MaestroEngine::getProcessIdFromQueueId($queueId)` →
`addTokenData($tokenName, $processId)`. Config (both required): `eca_maestro_token` (target token),
`eca_maestro_queueid` (`#type textarea`).

## eca_maestro_get_queueid_from_query — "Maestro: Get the queue Id form the request query"
`MaestroGetQueueIdFromQuery` extends `RequestActionBase`; overrides `getRequestValue()`. Reads the
current request query: `queueid` (returned as int if numeric), else `queueid_or_token` resolved via
`MaestroEngine::getQueueIdFromToken()`. Returns `NULL` when absent. The base class stores the
result in the configured token. No custom config keys of its own. Used for ECA endpoint flows where
a request carries a Maestro queue reference. Still `externallyAvailable(): FALSE`.

Config-value resolution (`getQueueId`, `getProcessId`, `getTemplateMachineName`, `getTokenName`,
`getTaskStatus`, `getType`, `getAssignee`, `getId`, `getVariableName`) lives in `MaestroTrait` —
see [../internals.md](../internals.md).
