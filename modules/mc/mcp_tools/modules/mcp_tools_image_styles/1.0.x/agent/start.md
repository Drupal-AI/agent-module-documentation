<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools - Image Styles (mcp_tools_image_styles) — agent index

Submodule of **mcp_tools**. Adds Tool API plugins for image styles and their effects from an MCP/AI connection.
Package *MCP Tools*. Core `^10.3 || ^11 || ^12`. Depends on **mcp_tools**, **image**.
No routes, forms, or config of its own.

- **The 7 tools, inputs, operations and write-kinds** →
  [tools/image-style-tools.md](tools/image-style-tools.md)

## What it provides

- 7 `tool` plugins in `src/Plugin/tool/Tool/`, all extending `McpToolsToolBase` with `MCP_CATEGORY = 'image_styles'` (3 Read, 4 Write).
- Service `mcp_tools_image_styles.image_style_service` (`ImageStyleService`) in `src/Service/`.
- One permission: **`mcp_tools use image_styles`** (`restrict access: true`).

## Access model (inherited)

`McpToolsToolBase::checkAccess()` requires **`mcp_tools use image_styles`** + the operation's scope
(Read → read; Write → write) and, for writes, a non-read-only connection whose write-kind policy
permits this tool's kind. See [tools/image-style-tools.md](tools/image-style-tools.md).

## Operate

```bash
drush en mcp_tools_image_styles -y
```

Grant `mcp_tools use image_styles` to the executor role and give the connection the matching scope.
