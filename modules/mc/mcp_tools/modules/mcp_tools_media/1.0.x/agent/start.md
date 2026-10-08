<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools - Media (mcp_tools_media) — agent index

Submodule of **mcp_tools**. Adds Tool API plugins for media types, media entities, and base64 file uploads from an MCP/AI connection.
Package *MCP Tools*. Core `^10.3 || ^11 || ^12`. Depends on **mcp_tools**, **media**, **file**.
No routes, forms, or config of its own.

- **The 6 tools, inputs, operations and write-kinds** →
  [tools/media-tools.md](tools/media-tools.md)

## What it provides

- 6 `tool` plugins in `src/Plugin/tool/Tool/`, all extending `McpToolsToolBase` with `MCP_CATEGORY = 'media'` (1 Read, 5 Write).
- Service `mcp_tools_media.media` (`MediaService`) in `src/Service/`.
- One permission: **`mcp_tools use media`** (`restrict access: true`).

## Access model (inherited)

`McpToolsToolBase::checkAccess()` requires **`mcp_tools use media`** + the operation's scope
(Read → read; Write → write) and, for writes, a non-read-only connection whose write-kind policy
permits this tool's kind. See [tools/media-tools.md](tools/media-tools.md).

## Operate

```bash
drush en mcp_tools_media -y
```

Grant `mcp_tools use media` to the executor role and give the connection the matching scope.
