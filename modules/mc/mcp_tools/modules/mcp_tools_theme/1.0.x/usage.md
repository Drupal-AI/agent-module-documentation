MCP tools for theme settings management.

---

MCP Tools - Theme is a submodule of MCP Tools. It contributes Tool API plugins (under `src/Plugin/tool/Tool/`) that let an MCP/AI connection work with theme install/uninstall, default/admin theme, and theme settings. All plugins extend `McpToolsToolBase`, so access requires the `mcp_tools use theme` permission plus the connection's scope (read for reads; write for mutations), and mutating operations additionally honour the global read-only switch and the config/content/ops write-kind policy. The mutating service methods re-check write access. It depends on `mcp_tools`.

---

- Report the active, default, and admin themes.
- List installed themes with their versions.
- List all on-disk themes including uninstalled ones.
- Read a theme's settings, logo, and favicon config.
- Install (enable) an already-present theme.
- Switch the site's default theme.
- Set a separate admin theme.
- Update a theme's logo path setting.
- Toggle a theme feature (e.g. show/hide the site slogan).
- Uninstall a theme that is no longer used.
- Confirm a theme's regions before placing blocks.
- Scaffold appearance settings during site setup via an AI agent.
- Standardise theme config across environments from MCP.
- Let a read-only connection review theme state safely.
- Drive theme management from Claude Code / Cursor.
- Check base-theme relationships before uninstalling.
- Set the admin theme to a dedicated back-end theme.
- Audit which theme is active as part of a site review.
- Wire theme changes into an ECA workflow via the Tool API.
- Prevent accidental removal of the active theme (guarded by the service).
