<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools — tool model, dispatch, and the authorization model

## Tools are Tool API plugins

MCP tools are Drupal **Tool API** plugins (`Drupal\tool`), discovered by `plugin.manager.tool`. A
plugin is exposed as an MCP tool only when its provider string starts with `mcp_tools` (unless
`includeAllTools` is set). Plugin ids map to MCP tool names by replacing `:` with `___`
(`McpToolsServerFactory::pluginIdToMcpName()`), and back on execute. Every first-party tool extends
`McpToolsToolBase` and implements `executeLegacy(array $input): array` returning
`['success' => bool, 'message'|'error' => …, 'data' => …]`.

## Server construction

`McpToolsServerFactory::create()` (`src/Mcp/McpToolsServerFactory.php`) builds an `Mcp\Server` via
the SDK builder: sets server info, pagination, logger, event dispatcher, optional session store,
resources and prompts. Two modes:
- **Full mode**: registers every eligible tool by name and adds a single
  `ToolApiCallToolHandler` request handler that intercepts `CallToolRequest` and runs the plugin.
- **Gateway mode** (`gatewayMode: true`): registers only the three `ToolApiGateway` tools —
  `mcp_tools/discover-tools`, `mcp_tools/get-tool-info`, `mcp_tools/execute-tool`.

## Dispatch pipeline (`ToolApiCallToolHandler::handle()`)

1. Resolve plugin id from tool name; reject if not a `ToolDefinition` or provider prefix fails
   (`Error::forMethodNotFound`).
2. Dispatch `ToolExecutionStartedEvent` with **sanitized** arguments (`sanitizeArguments()` redacts
   keys containing password/secret/token/key/api_key).
3. Validate input against the tool's input schema (`ToolInputValidator`); unknown/invalid input is
   **rejected**, not dropped.
4. Instantiate the plugin, set input values (with best-effort upcasting).
5. **`if (!$tool->access()) → accessDenied`** — access is checked before execution.
6. `$tool->execute()`, normalize the result into a `CallToolResult`, dispatch
   Succeeded/Failed events.

`ToolApiGateway::executeTool()` funnels through the same `handle()`, so the gateway path is
access-checked identically. (Note: `DrupalToolProvider::execute()` is a thin adapter used for
external discovery integrations and calls the plugin directly; the built-in stdio/remote/gateway
paths all go through `ToolApiCallToolHandler`.)

## The authorization model — who runs, and what gates it

Access is decided by `McpToolsToolBase::checkAccess()` against the **current Drupal user** and the
**AccessManager**. A tool is allowed only if ALL hold:

- **Permission**: `allowedIfHasPermission($account, 'mcp_tools use ' . MCP_CATEGORY)`. Each tool
  declares a category constant (`MCP_CATEGORY`); default `discovery`.
- **Scope** (per operation, from `ToolDefinition::getOperation()`):
  - `Read` → connection must hold scope `read`.
  - `Write` → scope `write` **and not** global read-only mode.
  - `Trigger` → scope `admin` **and not** read-only mode.
- **Write-kind policy** (Write/Trigger only): `AccessManager::isWriteKindAllowed($kind)` — under
  config-only mode, only the allowed write kinds (`config`/`content`/`ops`) pass. `getMcpWriteKind()`
  maps categories (content/users/media/… → content; cache/cron/search_api → ops; else → config).

`AccessManager` (`src/Service/AccessManager.php`) computes scopes in `getCurrentScopes()`:
programmatically set scopes win (`setScopes()`, used by transports); otherwise scopes come from the
`X-MCP-Scope` header, `mcp_scope` query, or `MCP_SCOPE` env — **only when the matching
`access.trust_scopes_via_*` toggle is on** — intersected with `access.allowed_scopes`; falling back
to `access.default_scopes` (default `[read]`). Defaults trust env (server-controlled) but **not**
header/query (client-controlled).

### The current user depends on the transport

Because permissions are checked against `current_user`, the effective identity is set by whichever
transport invokes the tool:
- **STDIO** (`mcp_tools_stdio`, `drush mcp-tools:serve`): runs as the Drush bootstrap user, or the
  `--uid` account if given (via `AccountSwitcher`). Scopes from `--scope`/server profile. No network
  surface — trust boundary is the local shell.
- **HTTP** (`mcp_tools_remote`, `/_mcp_tools`): after API-key auth it **switches to the configured
  execution user** (`accountSwitcher->switchTo()`), so every tool's permission check runs as that
  account with the key's scopes. See that submodule's docs.
- **MCP Server bridge** (`mcp_tools_mcp_server`): tools are served by contrib `mcp_server` under its
  own authentication mode; the sync command sets `authentication_mode` (default `required`).

Net effect: MCP tool execution is never anonymous-by-accident. It always runs as a real Drupal
account and is gated by a Drupal permission **and** an MCP scope **and** the write-kind policy —
three independent layers on top of global read-only mode.

## Extension points

- `hook_mcp_tools_components()` (`mcp_tools.api.php`): return `tools`/`resources`/`prompts` arrays
  (handler + metadata) without writing plugin classes.
- Tagged services `mcp_tools.resource_provider` / `mcp_tools.prompt_provider` feed the registries.
- Any Tool API plugin with a provider starting `mcp_tools` is auto-discovered.
