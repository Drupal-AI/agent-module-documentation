<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Droost Canvas gives AI agents Drupal Canvas (Experience Builder) support over MCP: component registry, SDC lint, and read/validate/write of component trees.

---

Droost Canvas extends Droost's MCP surface with tools for Drupal Canvas (Experience Builder). An agent can take an orientation snapshot of the Canvas install (`droost_canvas_status`), browse the placeable-component registry (`droost_canvas_components`, the Component config entities whose ids tree items reference, e.g. `sdc.mercury.cta`), lint Single-Directory Components against Canvas requirements (`droost_canvas_component_lint`), and read, validate or replace an entity's `component_tree` field (`droost_canvas_tree_get`, `droost_canvas_tree_validate`, `droost_canvas_tree_set`). It can also map the AI instruments available for orchestration through `canvas_ai` and `ai_agents` (`droost_canvas_orchestration`). A `TreeManager` service centralises tree read/serialize/validate logic. Only the writer changes state: `droost_canvas_tree_set` is gated by `allow_entity_write` and runs CLI-only; everything else is read-only. It depends on the Droost base module and Canvas, and is for local/trusted development only.

---

- Take an orientation snapshot before any Canvas work (version, registry counts, where trees live).
- List placeable Canvas components with ids, labels, source, status and slot names.
- Inspect one component's slot definitions, versions, and prop/settings field definitions.
- Filter the component registry by source (`sdc`/`block`/`js`) or enabled-only.
- Lint a Single-Directory Component against Canvas's requirements.
- Read an entity's `component_tree` field as a structured payload.
- Validate a proposed component tree against a real entity without saving it.
- Catch tree errors early: item keys, uuid integrity, parent/slot pairing, inputs shape.
- Replace an entity's component tree (gated, CLI-only) once validated.
- Discover which entity types/fields/bundles carry component_tree fields.
- Find existing tree-bearing entities to edit.
- Map the AI instruments (canvas_ai / ai_agents) available for orchestration.
- Give an AI agent a safe read → validate → write loop for page building.
