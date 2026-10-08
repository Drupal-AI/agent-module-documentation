<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GraphQL Compose Codegen MCP (graphql_compose_codegen_mcp) — agent index

Optional submodule of [graphql_compose_codegen](../../../../1.4.x/agent/start.md). Exposes the codegen
schema operations as **governed, read-only Tool API tools**. Version **1.4.x** (info `1.4.1`).
Core `^10.6 || ^11.3`.

- **Depends on:** `graphql_compose_codegen`, `mcp_sentinel (>=2.22.0)`, `tool (>=1.0.0-beta8)`.
- **No own config, permissions, routes, or Drush commands** — governance and permission
  (`administer graphql_compose_codegen`) come from the parent + MCP Sentinel.
- Built on the parent's `SchemaPreview` service (`graphql_compose_codegen.schema_preview`) — read-only, no
  file writes, no snapshot recording, no generation hooks.

Tools (`src/Plugin/tool/Tool/`, all `ToolOperation::Read`, base `SchemaToolBase`):
- `graphql_compose_codegen_inspect` — node field descriptors + paragraph alias map (`SchemaInspectTool`).
- `graphql_compose_codegen_diff` — snapshot presence + added/changed/removed paths (`SchemaDiffTool`).
- `graphql_compose_codegen_preview` — generated artefacts keyed by relative path (`SchemaPreviewTool`).

Each takes optional `bundles` (≤64) and `skip_fields` (≤256) string arrays.

- [agent/api/tools.md](api/tools.md) — the three tools, inputs, access model, and limits.
