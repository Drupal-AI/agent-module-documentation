<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools (mcp_tools) — agent index

The framework module that exposes Drupal operations to AI assistants via the **Model Context
Protocol**. It registers Drupal **Tool API** plugins (`drupal/tool`) as MCP tools and provides the
discovery, validation, access-control and dispatch pipeline around them. Package `AI`. Depends on
`tool`, `dblog`, `update`. Requires `mcp/sdk ^0.2.2`, several `code-wheel/mcp-*` libs and
`enshrined/svg-sanitize` (Composer). Core `^10.3 || ^11 || ^12`, PHP 8.3+. License GPL-2.0-or-later.
Version dir 1.0.x (installed 1.0.0-beta8). Configure: `/admin/config/services/mcp-tools`.

This module has **no network endpoint of its own** — transports are separate submodules:
- STDIO (drush) → `modules/mcp_tools_stdio`
- HTTP → `modules/mcp_tools_remote`
- via contrib MCP Server → `modules/mcp_tools_mcp_server`

## Solution docs

- **Tool model, discovery/dispatch, and the cross-transport authorization model** →
  [architecture/dispatch-and-access.md](architecture/dispatch-and-access.md)
- **Settings: config objects, scopes, modes, rate limits, webhooks, presets** →
  [config/settings.md](config/settings.md)

## What it provides (from source)

- **Tool base class** `Drupal\mcp_tools\Tool\McpToolsToolBase` (`src/Tool/`): wraps a legacy
  array-result tool into a Tool API `ExecutableResult` and enforces access in `checkAccess()` —
  permission `mcp_tools use <category>` **AND** an MCP scope (Read→read, Write→write, Trigger→admin)
  **AND** the config-only write-kind policy. Write tools may also use `Trait/WriteAccessTrait`.
- **~25 read-only core tools** in `src/Plugin/tool/Tool/*` (GetSiteStatus, GetSystemStatus,
  CheckSecurityUpdates, CheckCronStatus, AnalyzeWatchdog, GetQueueStatus, GetFileSystemStatus,
  ListContentTypes, GetRecentContent, SearchContent, GetVocabularies, GetTerms, GetFiles,
  FindOrphanedFiles, GetConfigStatus, GetConfig, ListConfig, ListTextFormats, GetTextFormat,
  GetRoles, GetUsers, GetPermissions, GetMenus, GetMenuTree, ListAvailableTools).
- **MCP plumbing** in `src/Mcp/`: `McpToolsServerFactory` (builds `Mcp\Server`),
  `ToolApiCallToolHandler` (executes Tool API plugins from `CallToolRequest`),
  `DrupalToolProvider` + `ToolApiGateway` (discover/info/execute), `ToolApiSchemaConverter`,
  `ToolInputValidator`, `ServerConfigRepository` (server profiles), resource & prompt registries.
- **Services** (`mcp_tools.services.yml`): `mcp_tools.access_manager` (`Service/AccessManager`),
  `mcp_tools.rate_limiter`, `mcp_tools.audit_logger`, `mcp_tools.tool_call_context`,
  `mcp_tools.webhook_notifier` (signed, SSRF-guarded), plus site-health/content/config/user
  analysis services and `mcp_tools.tool_error_handler`.
- **Permissions** (`mcp_tools.permissions.yml`): one `mcp_tools use <domain>` per category (content,
  config, users, structure, media, …), `mcp_tools use discovery`, and `mcp_tools administer`. All
  `restrict access: true`.
- **Routes** (`mcp_tools.routing.yml`): `mcp_tools.settings` (SettingsForm) and `mcp_tools.status`
  (StatusController), both `_permission: administer site configuration`.
- **Config**: object `mcp_tools.settings` (+ `mcp_tools_servers.settings`), schema in
  `config/schema/`, defaults in `config/install/`.
- **Extension points**: `hook_mcp_tools_components()` (`mcp_tools.api.php`); tagged services
  `mcp_tools.resource_provider` and `mcp_tools.prompt_provider`; any Tool API plugin whose provider
  starts with `mcp_tools` is auto-exposed.
- **Drush**: `src/Commands/McpToolsCommands.php` (client-config generation, etc.).
