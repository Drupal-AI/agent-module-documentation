<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools - Theme (mcp_tools_theme) — agent index

Submodule of **mcp_tools**. Adds Tool API plugins for theme install/uninstall, default/admin theme, and theme settings from an MCP/AI connection.
Package *MCP Tools*. Core `^10.3 || ^11 || ^12`. Depends on **mcp_tools**.
No routes, forms, or config of its own.

- **The 8 tools, inputs, operations and write-kinds** →
  [tools/theme-tools.md](tools/theme-tools.md)

## What it provides

- 8 `tool` plugins in `src/Plugin/tool/Tool/`, all extending `McpToolsToolBase` with `MCP_CATEGORY = 'theme'` (3 Read, 5 Write).
- Service `mcp_tools_theme.theme` (`ThemeService`) in `src/Service/`.
- One permission: **`mcp_tools use theme`** (`restrict access: true`).

## Access model (inherited)

`McpToolsToolBase::checkAccess()` requires **`mcp_tools use theme`** + the operation's scope
(Read → read; Write → write) and, for writes, a non-read-only connection whose write-kind policy
permits this tool's kind. See [tools/theme-tools.md](tools/theme-tools.md).

## Operate

```bash
drush en mcp_tools_theme -y
```

Grant `mcp_tools use theme` to the executor role and give the connection the matching scope.
