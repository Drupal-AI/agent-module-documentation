<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GraphQL Compose Codegen MCP (graphql_compose_codegen_mcp) — agent index

Optional submodule of [graphql_compose_codegen](../../../../1.6.x/agent/start.md). Exposes the codegen
schema operations as **governed, read-only Tool API tools**. Version **1.6.x** (info `1.6.2`).
Core `^10.6 || ^11.3`.

- **Depends on:** `graphql_compose_codegen`, `mcp_sentinel (>=2.22.0)`, `tool (>=1.0.0-beta9)`.
- **No own config, permissions, routes, or Drush commands** — governance and permissions
  (`administer graphql_compose_codegen` + `access mcp sentinel context`) come from the parent + MCP Sentinel.
- Built on the parent's `SchemaPreview` service (`graphql_compose_codegen.schema_preview`) — read-only, no
  file writes, no snapshot recording, no generation hooks.

Tools (`src/Plugin/tool/Tool/`, all `ToolOperation::Read`, base `SchemaToolBase`, with typed
`OutputDefinition`s):
- `graphql_compose_codegen_inspect` — node field descriptors + paragraph alias map (`SchemaInspectTool`).
- `graphql_compose_codegen_diff` — snapshot presence + added/changed/removed paths (`SchemaDiffTool`).
- `graphql_compose_codegen_preview` — generated artefacts keyed by relative path (`SchemaPreviewTool`).

Each takes optional `bundles` (≤64) and `skip_fields` (≤256) string arrays. The three tool classes are thin
(`OPERATION` const only); all inputs, outputs, access, and limits live in `SchemaToolBase`.

- [agent/api/tools.md](api/tools.md) — the three tools, inputs/outputs, access model, and limits.
