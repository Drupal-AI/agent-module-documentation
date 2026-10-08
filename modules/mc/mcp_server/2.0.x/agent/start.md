<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Server (mcp_server) — agent index

Integrates the official **Model Context Protocol** PHP SDK (`mcp/sdk`) into Drupal, exposing Drupal
**tools**, **resources** and **prompts** to AI/MCP clients over two transports: an **HTTP** endpoint
at **`/_mcp`** (route `mcp_server.handle`, `methods: [GET, POST]`, controller
`McpServerController::handle`, `_auth: ['cookie']`, `no_cache: TRUE`) and **STDIO** via the drush
command **`mcp:server`** (alias `mcps`). The `mcp_server.server.factory` service (`McpServerFactory`)
builds a per-request `Mcp\Server` (`mcp_server.server`, `shared: false`): it registers tools for
discovery only, then a `CustomCallToolHandler` intercepts every `CallToolRequest` before the SDK
dispatches it, runs an authorization event, and executes the matching tool plugin. Prompts are loaded
from `mcp_prompt_config` config entities; resource templates and completion providers are Drupal
plugins. Sessions persist in two DB tables (`mcp_session_metadata`, `mcp_session_queue`) via
`DatabaseSessionStore`.

The parent module ships **no executable tools** by itself — tools come from plugins tagged with the
`#[Tool]` attribute. The bundled **`mcp_server_tool_bridge`** submodule provides the one real tool
plugin (`tool_api`), which turns any `drupal/tool` (Tool API) tool into an MCP tool through a
`mcp_tool_config` config entity. Access is layered: the `/_mcp` route requires the **`access mcp
server`** permission (`restrict access: true`, **ungranted by default**), every request runs as a
specific Drupal account (cookie or, with the OAuth submodule, an `oauth2` Bearer token), and each
tool call fires the deny-only `mcp_server.authorize_call` event. Bridge tools additionally run the
wrapped Tool API tool's own `->access()` check.

- Depends on (parent): none (no Drupal module deps). Composer: `php ^8.3`, `mcp/sdk ^0.1.0`.
- Core: `^10 || ^11`. Package: `Custom`. License: GPL-2.0-or-later. Version: 2.0.x (dev checkout).
- Configure route: **`mcp_server_ui.settings`** (`/admin/config/services/mcp-server/settings`,
  provided by the `mcp_server_ui` submodule).
- Permissions: `access mcp server`, `access mcp server prompts` (parent); `administer mcp server`,
  `administer mcp prompt configurations` (mcp_server_ui); `administer mcp tool configurations`
  (mcp_server_tool_bridge).
- Drush: `mcp:server` (STDIO transport). Provides config schema. **Four plugin types.**
- Submodules: **mcp_server_ui** (admin forms), **mcp_server_tool_bridge** (Tool API → MCP),
  **mcp_server_oauth** (OAuth2 scope authz), **mcp_server_examples** (reference plugins).

## Submodules (all documented here — no separate dirs)

- **mcp_server_ui** — admin UI (the parent has runtime only, like `views`/`views_ui`). Forms:
  server settings (`mcp_server_ui_settings` → `mcp_server.settings`), resource-plugin settings
  (`mcp_server_resource_plugin_settings` → `mcp_server.resource_plugins`), and `mcp_prompt_config`
  CRUD. See [configure/settings.md](configure/settings.md).
- **mcp_server_tool_bridge** — exposes `drupal/tool` tools as MCP tools. `McpToolConfig`
  (`mcp_tool_config`) entity + `McpToolConfigDeriver` + the `tool_api` `#[Tool]` plugin. Depends on
  `tool:tool`. See [plugins/tools.md](plugins/tools.md).
- **mcp_server_oauth** — opt-in per-tool OAuth2 authorization via `McpAuthorizeOAuthSubscriber`
  (subscribes to `mcp_server.authorize_call`); appends `oauth2` to the `/_mcp` route; enriches the
  RFC 9728 `/.well-known/oauth-protected-resource` metadata. Depends on `simple_oauth`,
  `simple_oauth_21`. See [events/authorize.md](events/authorize.md).
- **mcp_server_examples** — reference plugins: `content_entity` resource template (JSON:API entity
  exposure), `entity_query` and `static_list` completion providers. Depends on `jsonapi`.

## What you'd do → where

- **Turn the HTTP endpoint on / grant access / configure server name, version, pagination, session
  TTL** → [configure/settings.md](configure/settings.md)
- **Connect an MCP client over HTTP (`/_mcp`) or STDIO (`drush mcp:server`); understand transports,
  auth, sessions, JSON-RPC error mapping** → [api/http-endpoint.md](api/http-endpoint.md)
- **Expose a tool: write a `#[Tool]` plugin, or map a Tool API tool via `mcp_tool_config` in the
  bridge; understand how a tool call is dispatched and executed** →
  [plugins/tools.md](plugins/tools.md)
- **Expose Drupal data as an MCP resource (ResourceTemplate plugin / the `content_entity` example)**
  → [plugins/resources.md](plugins/resources.md)
- **Author prompts (`mcp_prompt_config`) with typed messages and completion providers** →
  [plugins/prompts.md](plugins/prompts.md)
- **Add or customise authorization for tool/resource/prompt calls (the `mcp_server.authorize_call`
  event); require OAuth2 scopes per tool** → [events/authorize.md](events/authorize.md)

## Key facts (real machine names)

- Route: `mcp_server.handle` → `/_mcp` (`methods: [GET, POST]`, `_permission: 'access mcp server'`,
  `_auth: ['cookie']` + `oauth2` when mcp_server_oauth is on, `no_cache: TRUE`). Controller
  `Drupal\mcp_server\Controller\McpServerController::handle`; transport
  `Mcp\Server\Transport\StreamableHttpTransport`.
- Services: `mcp_server.server.factory` (`McpServerFactory`), `mcp_server.server` (`Mcp\Server`,
  `shared: false`), `mcp_server.database_session_store` (`DatabaseSessionStore`),
  `mcp_server.db_session_manager` (`DbSessionManager`), `mcp_server.psr17_factory`
  (`Http\Discovery\Psr17Factory`), `mcp_server.commands`, `logger.channel.mcp_server`.
- Plugin managers / types (4): `plugin.manager.mcp_server.tool` (`ToolPluginManager`; dir
  `Plugin/Tool`; attribute `Drupal\mcp_server\Attribute\Tool`; interface `ToolPluginInterface`; base
  `ToolPluginBase`; alter `mcp_server_tool`), `plugin.manager.mcp_server.resource_template`
  (`ResourceTemplateManager`; `Plugin/ResourceTemplate`; `#[ResourceTemplate]`;
  `ResourceTemplateInterface`/`Base`; alter `mcp_server_resource_template`),
  `plugin.manager.mcp_server.prompt_argument_completion_provider`
  (`PromptArgumentCompletionProviderManager`; `Plugin/PromptArgumentCompletionProvider`;
  `#[PromptArgumentCompletionProvider]`), `plugin.manager.mcp_server.notification`
  (`NotificationProviderManager`; `Plugin/Notification`; `#[Notification]`; contract-only stub, no
  providers in core).
- Config entities: `mcp_prompt_config` (`McpPromptConfig`, parent), `mcp_tool_config`
  (`McpToolConfig`, mcp_server_tool_bridge). Config objects: `mcp_server.settings`,
  `mcp_server.resource_plugins`.
- Event: `mcp_server.authorize_call` (`McpAuthorizeCallEvent::EVENT_NAME`) — carries a
  `McpOperationDescriptor` (type `tool`/`resource`/`prompt`); deny-only (`deny($reason, $httpStatus)`);
  denial → `McpAuthorizationDeniedException` → JSON-RPC error (`-32001` for 401, `-32003`/`-32002` for
  403) + `WWW-Authenticate` header.
- Tool execution: `CustomCallToolHandler` (in `McpServerFactory`) intercepts `CallToolRequest`;
  `ToolPluginManager::getRegistrations()` yields `ToolRegistration` objects (`mcpName`, `description`,
  `inputSchema`, `pluginId`, `configEntity`). Bridge: `tool_api` plugin + `McpToolConfigDeriver` (one
  derivative per enabled `mcp_tool_config`); autocomplete route
  `mcp_server_tool_bridge.tool_autocomplete`.
- DB tables: `mcp_session_metadata`, `mcp_session_queue` (`hook_schema()` in `mcp_server.install`;
  update `mcp_server_update_10002` drops obsolete `mcp_pending_request`).
- Cache tags: `mcp_server:discovery`, `mcp_server:tools`, `mcp_server:resource_templates`,
  `mcp_server:notifications`.
- Drush: `mcp:server` / `mcps` (`McpServerCommands::server`, STDIO).
