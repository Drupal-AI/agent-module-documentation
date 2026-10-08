MCP Sentinel Approval is an optional submodule that queues an AI agent's governed destructive operations for a human to approve or deny before they execute, and manages a time-boxed break-glass admin role.

---

When enabled, MCP Sentinel Approval intercepts destructive operations on the governed agent channel through the internal `mcp.destructive.op` / `mcp.destructive.action` events raised by the base module. If the operation is in the configured `gated_operations` set (default: `delete`, `config_import`, `module_disable`) — or is the always-gated `grant_mcp_admin` — it is not executed. Instead it is sealed into an HMAC-bound immutable action manifest and stored as an `mcp_approval_request` content entity in status `pending`. A human holding `approve mcp sentinel operations` reviews it at `/admin/reports/mcp-sentinel/approvals` and approves or denies it via a confirm form. On approval (`McpApprovalExecutor::approve()`), the manifest is validated and consumed once (idempotency guard), the target is reloaded and re-access-checked against the approver, a UUID guard rejects an id that was reused by a different entity, and the operation is replayed with a correlated evidence receipt; a recoverable block (e.g. the approver lacks delete access) leaves the request pending for retry. It also manages `grant_mcp_admin`: a time-boxed, single-use, HMAC-sealed grant of the non-standing `mcp_admin` break-glass role (`McpBreakGlassManager`), which is never `is_admin`, holds only an enumerated permission allowlist, refuses uid 1 and standing superusers, and — by separation of duties — does not itself hold the approve permission. A cron reaper revokes expired grants.

---

- Require a human to approve before an AI agent may delete content in bulk.
- Require a human to approve before an agent's queued configuration import is written.
- Require a human to approve before an agent disables (uninstalls) a module.
- Always require approval for a privilege-escalation request (`grant_mcp_admin`), regardless of configuration.
- Give reviewers a confirm form that shows the sealed-vs-live action manifest so they see exactly what will run.
- Reload and re-access-check the target against the approver at approval time, not just at request time.
- Guard against entity-id reuse with a sealed UUID check so a stale request cannot delete the wrong entity.
- Prevent double execution of an approved operation with a single-use manifest idempotency key.
- Leave a request pending (not falsely "approved") when execution is recoverably blocked, so an authorized admin can retry.
- Grant an operator a time-boxed `mcp_admin` break-glass role for incident response instead of a standing admin account.
- Enforce separation of duties: the break-glass role cannot approve operations, and a second person must approve elevation.
- Refuse to grant break-glass to uid 1 or any account already holding an is_admin role.
- Audit every approval decision and break-glass grant in the tamper-evident chain with a correlated evidence receipt.
- List who currently holds break-glass and until when at `/admin/reports/mcp-sentinel/grants`.
- Request break-glass elevation from the CLI (`drush mcp-sentinel:break-glass <uid>`), which queues it for approval.
- Let a governed agent see its own pending approval requests through the `mcp_sentinel_my_approvals` Tool.
- Configure which operations are gated and the break-glass grant lifetime from the approval settings form.
