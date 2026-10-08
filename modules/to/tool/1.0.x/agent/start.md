# Tool — agent index

Plugin framework for "well-defined actions": self-describing units of work with typed inputs/outputs,
an operation semantic, access checks, and one execution/result contract, drivable from Drush, an
admin UI, or an AI function-call bridge. **Tool core ships no ready-made tools** — it is the
framework; other modules provide `Plugin/tool/Tool/*` plugins. No configure route, no config schema.

- **Write a tool (`#[Tool]` attribute, `ToolBase`, input/output definitions, refiners, forms)** →
  [plugins/tool.md](plugins/tool.md)
- **Run/execute tools programmatically: `ToolManager`, invokers, `ExecutableResult`, entity handles, events** →
  [api/execute.md](api/execute.md)
- **Drush: `tool:list`, `tool:info`, `tool:run`, `tool:search`** →
  [drush/commands.md](drush/commands.md)

Submodules (own docs):
- `tool_ai_connector` → [../../modules/tool_ai_connector/1.0.x/agent/start.md](../../modules/tool_ai_connector/1.0.x/agent/start.md)
- `tool_explorer` → [../../modules/tool_explorer/1.0.x/agent/start.md](../../modules/tool_explorer/1.0.x/agent/start.md)

Key facts:
- Plugin type `tool`: manager `plugin.manager.tool` (`ToolManager`), dir `Plugin/tool/Tool`, attribute
  `Drupal\tool\Attribute\Tool`, interface `ToolInterface`, alter hook `tool_info`.
- Second plugin type `tool.typed_data_adapter`: manager `plugin.manager.tool.typed_data_adapter`,
  dir `Plugin/tool/TypedData/Adapter` — maps a data type to schema/validation/coercion.
- Operations enum `ToolOperation`: `Explain`, `Read`, `Transform`, `Trigger`, `Write`
  (`isModifying()`, `isIdempotent()`).
- One permission: `administer tool` (NOT `restrict access: true`; consumed by `tool_explorer`).
- Result contract: `ExecutableResult` (raw) vs `FormattedExecutableResult` (invoker-transformed).
- Entity handle system: `tool.handle_store` (private tempstore) downcasts entity outputs → opaque
  handle strings and upcasts them back as inputs.
