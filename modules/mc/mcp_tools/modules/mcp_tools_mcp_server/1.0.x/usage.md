An optional bridge that registers MCP Tools' Tool API plugins with the contrib drupal/mcp_server module, so the same tool library is served through MCP Server's transport instead of the built-in stdio/HTTP transports.

---

`mcp_tools_mcp_server` is an interoperability submodule of MCP Tools. It ships a single Drush command, `mcp-tools:mcp-server-sync` (in `McpToolsMcpServerCommands`), that iterates the Tool API plugin definitions whose provider starts with `mcp_tools` and creates or updates a corresponding `mcp_tool_config` entity in the contrib `mcp_server` module, pointing at MCP Server's generic `tool_api` tool plugin (`tool_api:<mcp_name>`). This lets a site that already runs `mcp_server` (`< 2.0` era) expose the full MCP Tools library through that server, with MCP Server handling the transport and its own authentication. The command supports enabling all synced configs, enabling only read tools, setting the authentication mode for new configs (`required`/`optional`/`disabled`, default `required`), updating existing configs' tool id/label, and a dry run. It has no routes, permissions, or config of its own and simply writes `mcp_tool_config` entities; the parent module's per-tool permission + scope checks still apply when the tools execute.

---

- Serve the MCP Tools library through an existing `drupal/mcp_server` installation.
- Sync all MCP Tools Tool API plugins into `mcp_tool_config` entities: `drush mcp-tools:mcp-server-sync`.
- Create and immediately enable every synced tool config with `--enable`.
- Enable only read tools (leaving writes disabled) with `--enable-read`.
- Set the authentication mode for newly created configs with `--auth-mode=required|optional|disabled`.
- Refresh tool ids/labels on existing configs after upgrades with `--update-existing`.
- Preview changes without writing config using `--dry-run`.
- Keep a single source of truth (Tool API plugins) while offering multiple MCP servers.
- Migrate from the built-in transports to MCP Server without rewriting tools.
- Roll out MCP Tools gradually by enabling read tools first, then selected writes.
- Audit which MCP Tools plugins are exposed through MCP Server by inspecting synced configs.
- Combine with `mcp_tools_observability` so tool executions are logged regardless of server.
- Use MCP Server's own scopes/auth alongside the parent module's scope + permission model.
