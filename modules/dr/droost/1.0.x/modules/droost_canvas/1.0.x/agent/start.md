<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Droost Canvas (droost_canvas) — agent index

Submodule of **Droost**: Drupal Canvas (Experience Builder) tools for AI agents, over MCP. Version
1.0.0-rc1 (dir `1.0.x`). Core `^10.3 || ^11 || ^12`, PHP `^8.3`. Depends on `droost` and `canvas`.
Local development only.

## MCP tools (`src/Plugin/Tool/`)

Read-only (extend `DroostToolBase`):
- **`droost_canvas_status`** — orientation snapshot (Canvas version, registry counts, where
  component_tree fields live, tree-bearing entities, whether canvas_ai/ai_agents are installed).
- **`droost_canvas_components`** — the placeable-component registry (Component config entities); ids
  like `sdc.mercury.cta` that tree items reference. Filter by `source` / `enabled_only`; pass
  `component` for full slot/version/settings detail.
- **`droost_canvas_component_lint`** — lints an SDC against Canvas requirements.
- **`droost_canvas_tree_get`** — reads an entity's `component_tree` field.
- **`droost_canvas_tree_validate`** — validates a proposed tree against a real entity **without
  saving** (Droost structural checks + Canvas validation).
- **`droost_canvas_orchestration`** — maps the AI instruments available via canvas_ai / ai_agents.

Write (extends `DestructiveToolBase`):
- **`droost_canvas_tree_set`** — replaces an entity's component tree. **Gated** by `allow_entity_write`
  (or master `allow_destructive`), **CLI-only** (`requireCliTransport() ?? gate('allow_entity_write')`).

## Service

- `droost_canvas.tree_manager` (`TreeManager`) — centralises tree read/serialize/validate logic;
  used by the tree tools. See `docs/component-tree-contract.md` in the source.

## Solution doc

- The seven tools, the read→validate→write loop and gating → [tools/canvas.md](tools/canvas.md)
