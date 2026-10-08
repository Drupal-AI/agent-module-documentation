Tool - AI Connector (experimental) exposes every Tool-module plugin to the AI module's function-calling system automatically, so tools become callable functions for LLMs, AI agents, and MCP — with no per-tool wiring.

---

The submodule provides a single AI `FunctionCall` plugin (`ToolPluginBase`) with a deriver (`ToolPluginDeriver`) that walks `plugin.manager.tool` and creates one AI function per tool, id `tool:<tool_id>`, grouped under the `tool` function group ("Tools API", `ToolsApi`). At call time the wrapper receives the LLM's arguments as context values, forwards each matching one to the wrapped tool via `setInputValue()` (triggering the Tool module's input-transform events), checks the tool's own `access()`, executes, and returns the invoker-formatted result as a structured/readable response; on input failure or access denial it records a failure result and returns the input JSON Schema so the model can self-correct. It sets the invoker id `tool_ai_connector` on each tool so the entity-handle system activates: an `EventSubscriber` (`ToolAiConnectorEntityHandleTransformSubscriber`, wired to `tool.entity_handle_transformer`) downcasts entity outputs to opaque handle strings the LLM can pass back as inputs, keeping raw/unviewable entity data out of the model context. `SchemaToolsPropertyConverter` and a `ToolsProperty` alter hook translate the tool's JSON-Schema input definitions into the AI module's property objects (escaping reserved characters like `:` for provider compatibility). Requires the contrib `ai` module (and `serialization`); it adds no routes, permissions, config, or Drush of its own — it is pure glue between Tool and AI.

---

- Make all installed tools available to an LLM as callable functions with zero per-tool code.
- Let an AI agent (ai_agents) invoke Drupal tools as part of a task.
- Expose tools over MCP / any AI-module function-calling consumer.
- Preserve each tool's own `checkAccess()` when the model calls it (access is enforced per current user).
- Return machine-readable structured output (success, message, outputs) to the model.
- Give the model the tool's input JSON Schema on failure so it can retry with corrected arguments.
- Group all tool functions under a single "Tools API" function group for discovery.
- Downcast entity outputs to opaque handles so the LLM never receives unviewable entity fields.
- Let the model pass a returned entity handle back as the input to a later tool call.
- Convert tool input definitions to provider-safe property schemas automatically.
- Pin or override specific tool inputs per agent via the AI module's context-definition overrides.
- Advertise a tool's operation semantics/description to the model through the function description.
- Add a new AI-callable capability simply by writing a normal Tool plugin (it appears automatically).
- Reuse the exact same tool from Drush, an admin UI, and an AI agent without divergence.
- Serialize tool definitions to JSON Schema for prompt/tool-spec generation.
- Keep entity handle state per user/session so concurrent agent runs don't leak references.
