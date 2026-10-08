# Tool → AI function-call bridge

This module is automatic: enable it (with the contrib `ai` module present) and every Tool plugin
becomes an AI function call. There is nothing to configure per tool.

## What gets generated

`Plugin/AiFunctionCall/Derivative/ToolPluginDeriver` iterates `plugin.manager.tool->getDefinitions()`
and derives one AI function per tool:

- id `tool:<tool_id>`, `function_name` `tool__<tool_id>` (`:` → `__`), `group` `tool`.
- `name`/`description` from the tool definition; `context_definitions` from the tool's input
  definitions; `module_dependencies` include the tool's provider module.

All functions live in the `tool` function group `ToolsApi` (`Plugin/AiFunctionGroup/ToolsApi`,
"Tools API").

## Call lifecycle (`Plugin/AiFunctionCall/ToolPluginBase`)

1. The AI module sets LLM arguments via `setContextValue()` (stored in `$values`).
2. `execute()`:
   - for each declared input present in `$values`, calls the wrapped tool's `setInputValue()`
     (after `unescapePropertyKeys()` restores `:` from `__colon__` in nested keys), and mirrors the
     transformed value back into the AI context;
   - checks the wrapped tool's `access()`; if denied, records `errorMessage` and a failure result on
     the tool;
   - otherwise `execute()`s the tool and materializes `getFormattedResult()` immediately (so entity
     → handle output transforms run at execute time, before later calls in the same batch).
3. `getStructuredOutput()` returns `['success','message','outputs', (input_schema on failure)]`; hints
   (e.g. handle metadata) are appended to `message` because the AI module shows `message` to the LLM.
   `getReadableOutput()` renders the same for text UIs.

The wrapped tool is created lazily with the invoker `ToolAiConnectorInvoker::ID`
(`'tool_ai_connector'`) so invoker-scoped event subscribers activate for AI calls.

## Entity handles

`ToolAiConnectorEntityHandleTransformSubscriber` (constructed with `tool.entity_handle_transformer`)
subscribes to the Tool module's transform events. Entity **outputs** are downcast to opaque handle
strings stored in the private tempstore; handle strings supplied as **inputs** are upcast back to
entities. Net effect: the LLM sees a handle, not raw entity data it may not be allowed to view, and
can reference the same entity in a later tool call.

## Schema conversion

- `tool.definition_serializer` produces the tool's input JSON Schema (via
  `normalizeInputSchema()` / the normalize events).
- `SchemaToolsPropertyConverter::convert($name, $schema, $required)` turns each JSON-Schema property
  into the AI module's `ToolsPropertyInput`.
- `AiToolsPropertyHooks::aiToolsPropertyAlter()` (`hook_ai_tools_property_alter`, bridged for
  pre-11.1 cores via the `#[LegacyHook]` function in `tool_ai_connector.module`) adjusts advertised
  properties. Property names use `__colon__` in place of `:` because the AI module requires
  alphanumeric property names; they are unescaped again before reaching the tool.

## Overrides

`ToolPluginBase::getContextDefinitions()` merges AI context-definition overrides on top of the tool's
input definitions (overrides win), and `applyContextDefinitionOverridesToInputSchema()` lets an agent
pin a value or change a field's required status without altering the tool itself.

## Consuming

Nothing to call directly — use the AI module's agent/chat/MCP tooling and the functions appear under
the "Tools API" group. To add a capability, write a normal `#[Tool]` plugin
(see the parent module's `agent/plugins/tool.md`); it is exposed automatically on the next plugin
cache clear.
