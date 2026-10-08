# Tool - AI Connector — agent index

Experimental glue that exposes every `tool` plugin to the AI module as a function call, with no
per-tool wiring. Depends on `tool`, `ai` (contrib), `serialization`. No routes/permissions/config/Drush.

- **How the bridge works and how to consume/extend it** → [api/function-call.md](api/function-call.md)

Key facts:
- One AI `FunctionCall` plugin `ToolPluginBase` + deriver `ToolPluginDeriver` → one function per tool,
  id `tool:<tool_id>`, group `tool` (function group `ToolsApi`, "Tools API").
- Sets invoker `tool_ai_connector` (`ToolAiConnectorInvoker::ID`) on each wrapped tool, activating the
  entity-handle transforms (`ToolAiConnectorEntityHandleTransformSubscriber` → `tool.entity_handle_transformer`).
- Enforces the wrapped tool's `access()`; on input failure/denial returns a failure result plus the
  input JSON Schema for model self-correction.
- `SchemaToolsPropertyConverter` + `AiToolsPropertyHooks` (`hook_ai_tools_property_alter`) convert
  tool input definitions to AI property objects (escaping `:` as `__colon__`).
- To add an AI-callable capability, just write a normal Tool plugin — it appears automatically.
