<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA Maestro (eca_maestro) — agent index

Integrates the **ECA** rules engine with the **Maestro** workflow module by providing ECA
**action** and **condition** plugins that call Maestro's `MaestroEngine`. Package `ECA`.
Version 2.0.0. Core `^9.5 || ^10 || ^11`. License GPL-2.0-or-later.

- **Dependencies:** info.yml declares `eca:eca` and `eca:eca_endpoint`. Maestro is required via
  `composer.json` (`drupal/maestro:^3||^4`) but is **not** listed in info.yml — install/enable it
  yourself or the actions fatal on `Drupal\maestro\Engine\MaestroEngine`. ECA requirement
  `drupal/eca:^1||^2`.
- **No** routes, permissions, services, config objects, config schema, hooks (beyond
  `hook_help`), events, or submodules. Only plugins. Nothing to configure at a settings page —
  you use it inside ECA models.

## What it provides

- **8 action plugins** (7 `ConfigurableActionBase`, 1 `RequestActionBase`) →
  [plugins/actions.md](plugins/actions.md)
- **1 condition plugin** (`ConditionBase`, `@EcaCondition`) →
  [plugins/conditions.md](plugins/conditions.md)
- **Shared internals** — `MaestroTrait`, `EcaMaestroConstants`, token/logging helpers,
  `hook_help` → [internals.md](internals.md)

## Plugin IDs at a glance

Actions: `eca_maestro_new_process`, `eca_maestro_complete_task`, `eca_maestro_set_task_status`,
`eca_maestro_reassign`, `eca_maestro_get_process_variable`, `eca_maestro_set_process_variable`,
`eca_maestro_process_id_from_queue_id`, `eca_maestro_get_queueid_from_query`.
Condition: `eca_maestro_can_user_execute_task`.

All action plugins declare `externallyAvailable(): FALSE` — they run only inside ECA models,
not as directly-callable ECA endpoints. Every config field is resolved through ECA's token
service, so all fields support tokens.
