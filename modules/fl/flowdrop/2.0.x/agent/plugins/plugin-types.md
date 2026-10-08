<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Other FlowDrop plugin types

Besides `FlowDropNodeProcessor` and `ExpressionEvaluator` (both defined in the base module — see
node-processors.md), FlowDrop defines these plugin types in submodules.

## Orchestrator (`flowdrop_orchestration`)

The execution engine is pluggable. An orchestrator decides *how* a workflow's node graph is run.

- Attribute: `Drupal\flowdrop_orchestration\Attribute\Orchestrator`.
- Interfaces: `Plugin/Orchestrator/OrchestratorPluginInterface`, plus service-layer
  `OrchestratorInterface` / `OrchestratorHelperInterface`; manager
  `OrchestratorPluginManager`.
- Default choice is set in `flowdrop.settings` (`execution.default_orchestrator`,
  default `flowdrop_runtime:synchronous`).
- Shipped orchestrators:
  - `flowdrop_runtime:synchronous` — run in-request.
  - `flowdrop_runtime:asynchronous` — queue-based background execution.
  - `flowdrop_stategraph:*` — checkpointed, resumable execution (reducers, human-in-the-loop
    approval gates, `state_checkpoint` entities).
- Also defines a **ConfirmationGate** contract (`Gate/ConfirmationGateInterface`) and interrupt
  DTOs (`ResolvedInterruptInterface`, `PersistedInterruptInterface`) — the boundary the interrupt
  submodule plugs into.

## FlowDropEventType (triggers — `flowdrop_trigger` / `flowdrop_orchestration_connector`)

An event type is a source that can fire a workflow.

- Namespace: `Plugin/FlowDropEventType`; managed by `flowdrop_trigger`'s
  `EventTypePluginManager`.
- Built-in: entity create/update/delete, user login/logout, form events, cron (via
  `dragonmantank/cron-expression`).
- `flowdrop_orchestration_connector` adds `OrchestrationInvoke` (event id
  `orchestration.invoke`) so external automation platforms can invoke a workflow through the
  Orchestration module. Invocation is bridged by `InvokeTriggerService`; a poll event subscriber
  scopes which terminal pipelines are visible back to the external platform (keyed on an
  input_data `source` marker, deliberately not on `trigger_config_id`).

## DashboardCard (base module `flowdrop`)

Declarative dashboard extension so any module can contribute cards/sections/pages without the base
module knowing about them.

- Manager: `flowdrop.dashboard_card_plugin_manager` (`Dashboard\DashboardCardManager`).
- Cards are usually declared in `MODULE.flowdrop_dashboard_cards.yml` (no PHP); a card whose route
  is missing or inaccessible simply is not rendered. `EntityCollectionCard` counts an entity type;
  `StaticCard` is a static link. Sections/pages declared in `MODULE.flowdrop_dashboard.yml`.
- Alter hooks: `hook_flowdrop_dashboard_cards_alter()`, `hook_flowdrop_dashboard_layout_alter()`
  (see `flowdrop.api.php`). Cacheability (tags/contexts) is part of the card contract.

## Memory backends (`flowdrop_memory`)

Scoped, swappable memory storage (static, cached, entity-backed via `memory_record`). Overrides
the base `flowdrop.execution_ledger` with a pipeline-scoped, persisted implementation so
tool-invoke gets at-most-once semantics.
