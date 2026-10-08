<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GraphQL Compose Codegen MCP exposes the codegen module's schema inspect, diff, and preview operations as governed, read-only Tool API tools for AI agents and MCP clients.

---

This optional submodule of GraphQL Compose Codegen surfaces three read-only Tool API tools —
`graphql_compose_codegen_inspect`, `graphql_compose_codegen_diff`, and `graphql_compose_codegen_preview` —
built on the parent module's bounded `SchemaPreview` service. All three are declared with
`ToolOperation::Read`; each accepts optional `bundles` and `skip_fields` arrays of machine names and returns
structured schema data or scaffold artefacts. There is no output-path, write, overwrite, or snapshot-update
argument: preview uses the same `buildArtefacts()` pipeline as Drush but never touches the filesystem, records
a snapshot, or fires generation hooks. The tools extend `SchemaToolBase` (a `McpGovernedToolBase`) and are
governed by MCP Sentinel: execution requires the `administer graphql_compose_codegen` permission, an eligible
Sentinel policy with configuration read enabled, and the `mcp_config_read` OAuth scope; anonymous execution is
refused and direct PHP calls repeat the access check. Requests are rate-limited and results are size-capped
(64 bundles, 256 fields per bundle, 262,144 encoded JSON bytes, plus the caller's Sentinel response budget) —
oversized results fail rather than truncate. If a policy denies any schema config dependency family, the whole
operation is refused so a partial view can't produce an incorrect contract. The base codegen module keeps
working without this submodule, Sentinel, or Tool API.

---

- Let an AI agent inspect node and paragraph schema fields without reading content.
- Let an agent preview generated TypeScript/GraphQL scaffold artefacts without writing files.
- Let an agent compare current artefacts against the saved baseline (diff) without changing it.
- Restrict any tool call to specific bundles via the `bundles` argument.
- Omit extra fields from a tool result via the `skip_fields` argument.
- Select all enabled bundles by passing an empty `bundles` array.
- Expose codegen to an MCP client while keeping all file-writing operations Drush-only.
- Enforce read-only access to the content model through MCP Sentinel governance.
- Require the `mcp_config_read` OAuth scope before any schema data is returned.
- Refuse anonymous or under-scoped tool execution.
- Rate-limit schema tool calls per Sentinel policy.
- Cap tool responses so a large schema cannot exfiltrate an oversized payload.
- Refuse the operation when a policy denies a schema config dependency family.
- Reject malformed, duplicate, or oversized bundle/field selectors.
- Keep audit, IP restriction, and DLP checks from MCP Sentinel applied to every call.
- Add governed schema tooling without granting the base codegen module any new web surface.
