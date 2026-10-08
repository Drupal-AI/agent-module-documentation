<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA Maestro — condition plugin

One `@EcaCondition` plugin in `src/Plugin/ECA/Condition/`.

## eca_maestro_can_user_execute_task — "Maestro: can user execute task"
`MaestroCanUserExecuteTask` extends `eca\Plugin\ECA\Condition\ConditionBase` and `use MaestroTrait`.

`evaluate()`: reads `eca_maestro_queueid` and `eca_maestro_userid` from configuration (both via the
token service), then returns `MaestroEngine::canUserExecuteTask($queueId, $userId)` passed through
`$this->negationCheck()` (so the ECA "negate" flag is honored). If either value is missing it logs
an error to the `eca_maestro` channel and returns `FALSE`.

Config keys (both required, token-aware): `eca_maestro_queueid` (Maestro queue ID),
`eca_maestro_userid` (user ID to check). See [../internals.md](../internals.md) for the shared
`getQueueId()` / `getUserId()` helpers.

Typical use: gate a "Maestro: complete task" or "reassign" action behind this condition so a model
only acts when the intended user actually has permission on the task.
