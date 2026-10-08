<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools - Sitemap (mcp_tools_sitemap) — agent index

Submodule of **mcp_tools**. Adds Tool API plugins for Simple XML Sitemap variants, settings, entity inclusion, and regeneration from an MCP/AI connection.
Package *MCP Tools*. Core `^10.3 || ^11 || ^12`. Depends on **mcp_tools**, **simple_sitemap**.
No routes, forms, or config of its own.

- **The 7 tools, inputs, operations and write-kinds** →
  [tools/sitemap-tools.md](tools/sitemap-tools.md)

## What it provides

- 7 `tool` plugins in `src/Plugin/tool/Tool/`, all extending `McpToolsToolBase` with `MCP_CATEGORY = 'sitemap'` (4 Read, 3 Write).
- Service `mcp_tools_sitemap.sitemap` (`SitemapService`) in `src/Service/`.
- One permission: **`mcp_tools use sitemap`** (`restrict access: true`).

## Access model (inherited)

`McpToolsToolBase::checkAccess()` requires **`mcp_tools use sitemap`** + the operation's scope
(Read → read; Write → write) and, for writes, a non-read-only connection whose write-kind policy
permits this tool's kind. See [tools/sitemap-tools.md](tools/sitemap-tools.md).

## Operate

```bash
drush en mcp_tools_sitemap -y
```

Grant `mcp_tools use sitemap` to the executor role and give the connection the matching scope.
