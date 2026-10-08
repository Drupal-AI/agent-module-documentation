<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Droost Canvas — tools & the read → validate → write loop

Seven MCP tools in `src/Plugin/Tool/`, backed by the `droost_canvas.tree_manager` (`TreeManager`)
service. The intended workflow is: **status → components → tree_get → tree_validate → tree_set**.

## Read-only tools (extend `DroostToolBase`, ungated)

- **`droost_canvas_status`** (`CanvasStatus.php`) — call first. Canvas version, placeable-component
  counts (by source/status), where `component_tree` fields live (entity type / field / bundles),
  existing tree-bearing entities, and whether `canvas_ai` / `ai_agents` are installed.
- **`droost_canvas_components`** (`CanvasComponents.php`) — the placeable-component registry (Component
  config entities). Tree items reference these ids (e.g. `sdc.mercury.cta`), not raw SDC ids. No args:
  list; `component`: full detail (slots, versions, settings incl. prop field definitions); filter by
  `source` (`sdc`/`block`/`js`) or `enabled_only`.
- **`droost_canvas_component_lint`** (`ComponentLint.php`) — lints Single-Directory Components against
  Canvas's requirements.
- **`droost_canvas_tree_get`** (`TreeGet.php`) — reads an entity's `component_tree` field as a payload.
- **`droost_canvas_tree_validate`** (`TreeValidate.php`) — validates a proposed tree against a real
  entity **without saving**: Droost structural checks (item keys, uuid integrity, parent/slot pairing,
  inputs shape) plus Canvas's own validation.
- **`droost_canvas_orchestration`** (`CanvasOrchestration.php`) — maps the AI instruments available
  for orchestration via `canvas_ai` / `ai_agents`.

## Write tool (extends `DestructiveToolBase`)

- **`droost_canvas_tree_set`** (`TreeSet.php`) — replaces an entity's component tree. `execute()` opens
  with `requireCliTransport() ?? gate('allow_entity_write')`, so it is **disabled by default**, needs
  `allow_entity_write` (or master `allow_destructive`), and runs **CLI-only**. Persists through the
  entity API and returns the read-back payload of the saved tree (via `TreeManager::toPayload()`).

## `TreeManager` (`src/TreeManager.php`)

Central service (`droost_canvas.tree_manager`) for reading, serializing and validating a
`component_tree` value, shared by the tree tools so read, validate and write agree on the tree shape.
The contract is documented in the source at `docs/component-tree-contract.md`.
