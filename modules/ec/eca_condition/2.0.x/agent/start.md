<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA Condition (eca_condition) — agent index

Bridges Drupal's **Condition plugin** API and **ECA**. Ships one core Condition plugin (id
`eca_condition`) whose TRUE/FALSE verdict is **decided by an ECA model** — not by the underlying
Drupal conditions. You author condition logic once in ECA and reuse it wherever core evaluates
conditions (block visibility, etc.). Package `ECA`. Depends on **`eca:eca ^2`**. Core
`^10.3 || ^11`. License GPL-2.0-or-later. Version 2.0.0-beta2 (version-dir 2.0.x).

- **The core Condition plugin, its `eca_conditions` setting, and the evaluate flow** →
  [plugins/condition.md](plugins/condition.md)
- **The ECA side: event, action, deriver, service, subscriber, token** →
  [api/eca-integration.md](api/eca-integration.md)

## What it actually provides (from source)

- **Condition plugin** `ECACondition` (id **`eca_condition`**, label "ECA Condition"),
  `src/Plugin/Condition/ECACondition.php`, extends core `ConditionPluginBase`. One config key
  `eca_conditions` (a textarea of condition IDs, one per line). `evaluate()` dispatches an ECA
  event per ID and returns TRUE only if **all** resolve TRUE. The `negate` checkbox is hidden.
- **ECA Event** `ECAConditionEvent` (id `eca_condition`, deriver `ECAConditionEventDeriver`) →
  the runtime event `eca_condition:condition_event` (`ConditionEvent::CONDITION_EVENT` =
  `eca_condition.condition_event`), provides token `[condition_id]`.
- **ECA Action** `SetConditionResultAction` (id **`eca_condition_result`**, label "ECA Condition:
  set result") — sets the event's result to True/False from inside a model.
- **Service** `eca_condition.hook_handler` (`Service\HookHandler`) — dispatches the condition event
  via `eca.trigger_event`; **EventSubscriber** `eca_condition.subscriber` adds the `condition_id`
  token before execution; event class `Events\ConditionEvent`.
- No routes, no permissions, no config forms/objects, no config schema, no Drush, no libraries.
  The `.module` file only exposes helper `_eca_condition_hook_handler()`.

## Data-flow (one evaluation)

`ECACondition::evaluate()` → splits `eca_conditions` on newlines → per line
`_eca_condition_hook_handler()->condition($id)` → `HookHandler` dispatches
`eca_condition:condition_event` (a `ConditionEvent` carrying `$id`) → the subscriber exposes
`[condition_id]` → your ECA model runs and calls the `eca_condition_result` action
(`$event->setResult(bool)`) → `getResult()` returns to `evaluate()`. Any FALSE → whole condition
FALSE. Empty textarea → FALSE.
