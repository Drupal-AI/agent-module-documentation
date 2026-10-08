MCP Tools turns a Drupal site into a Model Context Protocol (MCP) server, exposing Drupal operations to AI assistants as access-controlled, discoverable tools.

---

MCP Tools is the framework module of the `mcp_tools` project. It registers Drupal Tool API plugins (`Drupal\tool`) as MCP tools and provides the machinery that discovers, validates, access-checks and dispatches them: a server factory (`McpToolsServerFactory`) that builds an `Mcp\Server` from the SDK, a custom call handler (`ToolApiCallToolHandler`) that executes Tool API plugins directly, an optional gateway (`ToolApiGateway`, discover/info/execute), MCP resources and prompts, and a layered `AccessManager` (module availability, global read-only mode, config-only mode, per-connection scopes read/write/admin, and a per-domain `mcp_tools use <category>` permission). The base class `McpToolsToolBase` enforces permission + scope + write-kind policy on every tool. The framework ships ~25 read-only core tools (site health, content, config, users, structure, discovery) and is extended by 30+ optional submodules for writes. It does not, by itself, expose a network endpoint — transports are separate submodules (`mcp_tools_stdio`, `mcp_tools_remote`, `mcp_tools_mcp_server`). Settings live at `/admin/config/services/mcp-tools`; a status page at `/admin/config/services/mcp-tools/status`.

---

- Connect a local AI client (Claude Code, Cursor, Windsurf) to a Drupal site over MCP.
- Let an AI assistant read site health: status, requirements, security updates, cron, watchdog, queues, file system.
- Ask an assistant to list content types, search content, list recent nodes, taxonomies, files.
- Expose configuration read tools (config status, single config, config list, text formats) to an agent.
- Give an agent visibility into users, roles and permissions.
- Provide menu structure/tree read tools for navigation-aware assistants.
- Run in read-only mode so an assistant can inspect but never mutate a site.
- Use config-only mode on staging/production to allow configuration changes but block content/ops writes.
- Grant an MCP connection least-privilege access with read/write/admin scopes.
- Gate each tool domain behind a distinct Drupal permission (`mcp_tools use content`, `mcp_tools use config`, …).
- Rate-limit expensive read scans and write operations to prevent abuse.
- Audit every MCP operation via the shared AuditLogger and the observability submodule.
- Discover available tools at runtime with `mcp_tools/discover-tools` and fetch a tool's schema with `mcp_tools/get-tool-info`.
- Run in gateway mode to expose only discover/info/execute (a compact three-tool surface) instead of the full tool list.
- Serve MCP resources (site health/status/blueprint) and prompts to clients that support them.
- Extend the tool library by adding Tool API plugins in a custom or contrib submodule (provider prefixed `mcp_tools`).
- Declare MCP components (tools/resources/prompts) via `hook_mcp_tools_components()` without writing plugin classes.
- Notify external systems (Slack, audit sinks) of MCP write operations via signed webhooks.
- Apply development/staging/production presets to switch access posture in one setting.
- Build content-as-code workflows: mutate config locally, export or generate a Recipe for review.
- Reuse the tool library outside MCP entirely — as plain Tool API plugins for ECA or AI Agents.
