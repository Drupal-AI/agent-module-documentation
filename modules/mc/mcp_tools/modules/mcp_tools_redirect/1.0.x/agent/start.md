<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools - Redirect (mcp_tools_redirect) — agent index

Submodule of **mcp_tools**. Adds Tool API plugins for redirect entities (source path to destination) from an MCP/AI connection.
Package *MCP Tools*. Core `^10.3 || ^11 || ^12`. Depends on **mcp_tools**, **redirect**.
No routes, forms, or config of its own.

- **The 7 tools, inputs, operations and write-kinds** →
  [tools/redirect-tools.md](tools/redirect-tools.md)

## What it provides

- 7 `tool` plugins in `src/Plugin/tool/Tool/`, all extending `McpToolsToolBase` with `MCP_CATEGORY = 'redirect'` (3 Read, 4 Write).
- Service `mcp_tools_redirect.redirect` (`RedirectService`) in `src/Service/`.
- One permission: **`mcp_tools use redirect`** (`restrict access: true`).

## Access model (inherited)

`McpToolsToolBase::checkAccess()` requires **`mcp_tools use redirect`** + the operation's scope
(Read → read; Write → write) and, for writes, a non-read-only connection whose write-kind policy
permits this tool's kind. See [tools/redirect-tools.md](tools/redirect-tools.md).

## Operate

```bash
drush en mcp_tools_redirect -y
```

Grant `mcp_tools use redirect` to the executor role and give the connection the matching scope.
