<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Action link workflow (action_link_workflow) — agent index

**Experimental** submodule of **action_link**. Provides a `workflow` State Action plugin that turns a
core Workflows entity's transitions into action-link directions. Depends on `action_link` and
`workflows`. No permissions, no config schema. `info.yml` sets `experimental: true`.

## What it provides

- **State Action plugin** `workflow` (`src/Plugin/StateAction/Workflow.php`,
  `#[StateAction(id: 'workflow', directions: [], dynamic_parameters: ['entity'], deriver:
  WorkflowActionLinkDeriver::class)]`, extends `StateActionBase`).
  - `getDirections()` loads the workflow (`workflowId` = derivative id) and returns its transitions
    (keyed by transition id, value = label).
  - `getNextStateName($direction, $user, $entity)` reads `$entity->moderation_state->value`, finds the
    transition for the direction, and returns its target state id (or NULL if not available from the
    current state).
  - `getLinkLabel()` returns the transition label.
  - `getActionRoute()` sets the `entity` route parameter type — **hardcoded** to `entity:node`
    (`@todo` to derive from config).
- **Deriver** `src/Plugin/Derivative/WorkflowActionLinkDeriver.php` — one derivative per `workflow`
  config entity, labelled `Workflow: <label>`.

## Status (incomplete)

`advanceState()` is an empty stub, `buildConfigurationForm()` is present only as `XbuildConfiguration
Form()`, and `getMessage()` returns a fixed string. Treat as a reference implementation; the plugin
does not yet perform the moderation-state change itself. The entity route type is node-only.

## Operate

Enable `workflows` and this module; create an action link using the derived `workflow:<workflow_id>`
plugin. See the parent module docs for how links are built and served.

## Solution docs

- `agent/plugins/workflow.md` — the derived plugin, directions, and current limitations.
