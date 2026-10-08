<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit Chain MCP (audit_chain_mcp) — agent index

Optional submodule of **Audit Chain** (`audit_chain`). Exposes four **governed Tool API** plugins so
an MCP agent can inspect the tamper-evident chain **without reading its contents**. Package
`Security`. Core `^10.6 || ^11.3`. License GPL-2.0-or-later. Version **1.9.x**.

Dependencies (`audit_chain_mcp.info.yml`): **`audit_chain:audit_chain`**,
**`mcp_sentinel:mcp_sentinel` (>=2.22.0)**, **`tool:tool` (>=1.0.0-beta8)**.

- **The four MCP tools, base class, permissions, and what is/ isn't returned** →
  [tools/tools.md](tools/tools.md)
- Parent project index → [../../../../1.9.x/agent/start.md](../../../../1.9.x/agent/start.md)

## What it provides

- **No config, no routes, no services of its own.** Just plugins under
  `src/Plugin/tool/Tool/` and two permissions (`audit_chain_mcp.permissions.yml`).
- **Tool plugins** (all extend `AuditChainToolBase` → `McpGovernedToolBase`):
  - `audit_chain_status` (`StatusTool`, Read) — chain health from stored state.
  - `audit_chain_window_counts` (`WindowCountsTool`, Read) — keyed/unkeyed counts per window.
  - `audit_chain_export_status` (`ExportStatusTool`, Read) — off-system export backlog.
  - `audit_chain_verify_now` (`VerifyNowTool`, **Trigger**) — run verification now.
- **Permissions**: `use audit chain mcp tools` (all four); `run audit chain verification via mcp`
  (additionally required by the verify tool).

## Governance & data-minimization (`AuditChainToolBase`)

Every call: re-checks access for PHP callers, resolves an MCP Sentinel governance profile, applies the
profile rate limit and a response-size cap (`min(128 KiB, profile cap)`), and returns one fixed
refusal message on any failure. Result shapes are rebuilt field by field (`verdictFields()`,
`successorFields()`) so nothing a future version adds leaks; **rows, metadata, IPs, user agents,
hashes, seal MACs, prefix digests, key identifiers and seal reasons never reach a caller** — unknown
verdict/successor reasons are collapsed to `"other"`.
