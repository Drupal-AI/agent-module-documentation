<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Gate MCP (file_gate_mcp) — agent index

Optional submodule of **File Gate** publishing five governed **Tool API** plugins for AI agents. Version
**1.10.x**, core `^11.4` (MCP Sentinel does not yet declare D12), package Security. Depends on
`file_gate:file_gate`, `mcp_sentinel:mcp_sentinel (>=2.22)`, `tool:tool (>=1.0.0-beta8)`.

## Governance (all tools)
`FileGateToolBase` (`src/Plugin/tool/Tool/FileGateToolBase.php`, extends `McpGovernedToolBase`) enforces:
permission `use file gate mcp tools` (rechecked in `doExecute()` for PHP callers, not just discovery); a resolved
MCP Sentinel policy profile; a per-tool rate limit; and a response-size cap — the smaller of the module ceiling
(128 KiB) and the profile's `effectiveResponseSizeCap`. Refusals are one fixed message; caller input and
exception text never reach a result (only the failure class is logged). No tool returns secret material, file
paths or download URLs.

## Permissions (`file_gate_mcp.permissions.yml`, both restricted)
- `use file gate mcp tools` — the four read tools.
- `revoke file gate grants via mcp` — additionally required by the revoke tool.

## Tools
- **`file_gate_status`** (`StatusTool`, Read) — runtime findings, whether any signing secret is configured, named
  secret ids + whether each is scoped, every gated field with method + storage scheme (`protected` = private).
- **`file_gate_file_gate`** (`FileLookupTool`, Read) — for one `file` **or** `media` UUID: is it gated, which
  field + method, whether `/system/files` serves it. Media resolves only when the acting account may view it.
- **`file_gate_grants_list`** (`GrantsListTool`, Read) — active usage-limited grants for a gated `field` (≤200
  rows): grant id, file UUID, expiry, max uses, `subject_bound` (bool only), minting `secret_id`, created.
- **`file_gate_metrics`** (`MetricsTool`, Read) — `file_gate.metrics` summary for 1–90 `days`.
- **`file_gate_grant_revoke`** (`GrantRevokeTool`, **Write** + extra permission) — revoke one grant by `field` +
  `grant_id`; scoped to the grant's own field (a grant id from another field is refused), acts with site-operator
  reach, writes a kill-mark that outlives the grant, audited.

See [tools/tools.md](tools/tools.md) for input schemas, scoping and the operation rationale.
