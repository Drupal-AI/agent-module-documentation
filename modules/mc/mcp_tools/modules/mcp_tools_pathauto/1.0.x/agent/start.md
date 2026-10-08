<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools - Pathauto (mcp_tools_pathauto) — agent index

Submodule of **mcp_tools**. Adds Tool API plugins for Pathauto alias patterns and bulk alias generation from an MCP/AI connection.
Package *MCP Tools*. Core `^10.3 || ^11 || ^12`. Depends on **mcp_tools**, **pathauto**.
No routes, forms, or config of its own.

- **The 6 tools, inputs, operations and write-kinds** →
  [tools/pathauto-tools.md](tools/pathauto-tools.md)

## What it provides

- 6 `tool` plugins in `src/Plugin/tool/Tool/`, all extending `McpToolsToolBase` with `MCP_CATEGORY = 'pathauto'` (2 Read, 4 Write).
- Service `mcp_tools_pathauto.pathauto` (`PathautoService`) in `src/Service/`.
- One permission: **`mcp_tools use pathauto`** (`restrict access: true`).

## Access model (inherited)

`McpToolsToolBase::checkAccess()` requires **`mcp_tools use pathauto`** + the operation's scope
(Read → read; Write → write) and, for writes, a non-read-only connection whose write-kind policy
permits this tool's kind. See [tools/pathauto-tools.md](tools/pathauto-tools.md).

## Operate

```bash
drush en mcp_tools_pathauto -y
```

Grant `mcp_tools use pathauto` to the executor role and give the connection the matching scope.
