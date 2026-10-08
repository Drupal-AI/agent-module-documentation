<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Annotations Tool API (annotations_tool) — agent index

Exposes annotation context as drupal/tool Tool plugins for function-calling AI agents. Depends on `annotations`, `annotations_context`, `tool`, `tool_ai_connector`.

## Provides

- **Tool plugins** (`src/Plugin/tool/Tool/`):
  - `GetAnnotations` — `#[Tool(id: 'annotations_read', ToolOperation::Read)]`. Input `target_id` (optional, `entity_type__bundle`); output `content` (markdown). Returns a target's assembled annotation documentation, or all targets when `target_id` is empty. Uses `ContextAssembler` + `ContextRenderer`.
  - `ListAnnotationTargets` — lists configured `annotation_target` entities.
- **Access trait** `AnnotationsToolAccessTrait` — `checkAccess()` allows `view annotations context` OR `administer annotations`; `getCacheContexts()` = `user.permissions` + language contexts.

## Notes for agents

- Both tools are `ToolOperation::Read` — no mutation. Access is enforced by the shared trait, matching the `view annotations context` gate used across the suite's context surfaces.
- Output is the same assembler/markdown used by the MCP endpoint and annotations_export; this is the drupal/tool (function-calling) delivery path.
