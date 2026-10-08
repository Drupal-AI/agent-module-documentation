<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugins — Tools

Tools are the executable capability MCP clients invoke. Two ways to provide them: a native `#[Tool]`
plugin, or (recommended, no-code) a `mcp_tool_config` entity in the **mcp_server_tool_bridge**
submodule that wraps a `drupal/tool` (Tool API) tool.

## The Tool plugin type

- Manager `plugin.manager.mcp_server.tool` (`ToolPluginManager`); discovery dir `Plugin/Tool`;
  attribute `Drupal\mcp_server\Attribute\Tool`; interface `ToolPluginInterface`; base
  `ToolPluginBase`; alter hook `mcp_server_tool`; cache tag `mcp_server:tools`.
- `#[Tool]` args: `id`, `label` (TranslatableMarkup), `description` (TranslatableMarkup),
  `module_dependencies = []`, `deriver = NULL`.
- `ToolPluginInterface` methods: `getTitle()`, `getDescription()`, `getDependencies()`, `getTools()`,
  `getRegistrations()`, `executeTool(?ToolRegistration $registration, string $toolId, array $arguments,
  ?ClientGateway $gateway)`, `checkAccess(AccountInterface)`, `checkToolAccess(string $toolId,
  AccountInterface)`, `getConfiguration()`, `setConfiguration()`, `isEnabled()`.
- A plugin yields one or more **`ToolRegistration`** objects (readonly:
  `mcpName`, `description`, `inputSchema` (JSON Schema array), `pluginId`, `?configEntity`). The base
  class's `getRegistrations()` derives `mcpName` as `"<plugin_id>:<tool['id']>"` from `getTools()`.

`getTools()` returns tool definition arrays with keys: `id`, `name`, `description`, `inputSchema`,
`outputSchema?`, and the MCP annotations `destructive`, `readOnly`, `idempotent`, `openWorld`.

## Registration and dispatch

- `McpServerFactory::registerTools()` iterates `ToolPluginManager::getRegistrations()` and calls
  `$builder->addTool(handler: fn() => NULL, name: $r->mcpName, description: …, inputSchema: …)` — the
  SDK handler is a **noop**; tools are registered for discovery only.
- `ToolPluginManager::getRegistrations()` instantiates each plugin, skips those where `isEnabled()`
  is false, deduplicates by `mcpName` (first wins; collision logged), and yields registrations.
- Actual execution is intercepted by **`CustomCallToolHandler`** (`src/Handler/`), added to the
  builder in `McpServerFactory::create()`. Its `supports()` matches `CallToolRequest`; `handle()`:
  1. `findRegistration($tool_name)` by `mcpName` (returns a `CallToolResult::error` "Tool not found"
     if none);
  2. `authorize($registration)` — dispatches the `mcp_server.authorize_call` event; a denial throws
     `McpAuthorizationDeniedException` (see [../events/authorize.md](../events/authorize.md));
  3. `createInstance($registration->pluginId)` then `$plugin->executeTool($registration, $tool_name,
     $arguments, $gateway)` (a `ClientGateway` built from the session enables client-side sampling);
  4. wraps a non-`CallToolResult` return in `formatResult()` (arrays → pretty JSON `TextContent`,
     scalars → string). Throwable during execution → `CallToolResult::error('Tool execution failed:
     …')` (the authorize exception is re-thrown so the controller maps it to HTTP status).

## mcp_server_tool_bridge — Tool API → MCP (the shipped tools)

Depends on `mcp_server:mcp_server` and `tool:tool`. Turns Tool API plugins into MCP tools by config,
without writing PHP.

- Config entity **`mcp_tool_config`** (`McpToolConfig`, `config_prefix: mcp_tool_config`,
  `admin_permission: administer mcp tool configurations`). Exported keys: `id`, `mcp_tool_name`
  (the MCP-visible name / entity label), `tool_id` (the Tool API plugin id), `description?`, `status`.
  `preSave()` requires `tool_id` and `mcp_tool_name`; save/delete invalidate `mcp_server:discovery`.
- **`McpToolConfigDeriver`** emits one `tool_api` plugin derivative per **enabled** `mcp_tool_config`,
  carrying `mcp_tool_name`, `tool_id`, `description` into the definition.
- **`ToolApi`** `#[Tool(id: 'tool_api', module_dependencies: ['tool'], deriver: McpToolConfigDeriver)]`
  (`modules/mcp_server_tool_bridge/src/Plugin/Tool/ToolApi.php`):
  - `getTools()` / `getRegistrations()` load the backing `ToolDefinition` via
    `ToolManager::getDefinition()` and build the MCP `inputSchema` with
    `convertToMcpSchema()` (maps Tool API data types + Length/Range/Regex/AllowedValues constraints to
    JSON Schema; entity-typed inputs become a string "artifact token" `{{entity:*}}`). The registration
    carries the `mcp_tool_config` entity in `configEntity`.
  - `executeTool()` resolves the Tool API plugin id (`resolveToolApiId()` strips a legacy `tool_api:`
    prefix and converts `___` → `:`), `createInstance()`s it, upcasts each argument to its
    `InputDefinition` (`upcastArgument()`, incl. handle-token → tempstore entity swap via
    `replaceHandleTokenWithValue()`), **calls `$tool->access()` and returns a failure result if
    denied**, then `$tool->execute()` and returns `success`/`message`/`data`. Entity outputs are
    downcast to handle tokens stored in the `ai_tool_artifacts` private tempstore.
- Admin: routes under `/admin/config/services/mcp-server/tools` (collection/add/edit/delete) + the
  autocomplete route `mcp_server_tool_bridge.tool_autocomplete`
  (`ToolAutocompleteController::handleAutocomplete`, `administer mcp tool configurations`, matches
  `ToolPluginManager::getAllTools()` by id/name/description, caps at 10). The `McpToolConfigForm`
  `tool_id` field autocompletes against that route and validates the id resolves via
  `ToolPluginManager::getTool()`.

Per-tool OAuth policy (with mcp_server_oauth) is stored as third-party settings on `mcp_tool_config`
under the `mcp_server_oauth` namespace (`authentication_mode`, `scopes`) — see
[../events/authorize.md](../events/authorize.md).
