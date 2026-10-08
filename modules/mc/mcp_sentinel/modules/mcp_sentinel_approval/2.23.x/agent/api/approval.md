<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Approval entities, services, events & workflow

## Entities
- **`mcp_approval_request`** (`McpApprovalRequest`, content entity, base table `mcp_approval_request`). Base fields:
  `requested_by` (user ref), `operation` (string, e.g. `delete`), `entity_type`, `entity_id`, `payload` (JSON replay
  data), `manifest` (HMAC-sealed immutable action manifest), `status` (`pending`/`approved`/`denied`), plus decision
  fields. Collection `/admin/reports/mcp-sentinel/approvals`; list builder `McpApprovalRequestListBuilder`.
- **`mcp_admin_grant`** (`McpAdminGrant`, content entity, base table `mcp_admin_grant`). Fields: `uid`, `granted`,
  `expires`, `revoked`, `manifest` (HMAC-sealed single-use grant). Collection `/admin/reports/mcp-sentinel/grants`;
  list builder `McpAdminGrantListBuilder`. A cron reaper revokes the role once `expires` passes.

Both use `admin_permission = "approve mcp sentinel operations"`.

## How an operation gets queued
The base module raises internal destructive events; `McpDestructiveOpSubscriber` and `McpDestructiveActionSubscriber`
consult `McpApprovalGate::requiresApproval()`. A gated op is sealed via `mcp_sentinel.action_manifest_sealer` and
stored as a pending `mcp_approval_request` rather than executing. `grant_mcp_admin` is always gated.

## Deciding — `McpApprovalDecisionForm` + `McpApprovalExecutor`
`McpApprovalDecisionForm` (a `ConfirmFormBase`, routes `.approve` / `.deny`, perm `approve mcp sentinel operations`)
shows the sealed-vs-live diff from `McpReviewerContext` and hides submit when the reviewer context is not visible.
On submit it calls `McpApprovalExecutor::approve()` / `deny()`. `approve()`:
1. `LogicException` if the request is not pending (prevents a replayed/double decision).
2. `McpManifestBinder::validate()` binds the decision to exactly one sealed manifest (rejects `manifest_expired`,
   tampering, etc.).
3. For `delete`: reject unknown/uninstalled entity types; treat an already-gone target as approved-not-executed;
   reject a **UUID mismatch** (id reused by a different entity, `TargetStale`); **re-check `$entity->access('delete',
   $approver)`** — a recoverable failure leaves the request PENDING for retry; then `binder->consume()` (single-use
   idempotency) and delete.
4. For `config_import`: re-validate the queued values with `McpConfigWriteValidator` against current config
   (schema-less names only if the sealed manifest recorded the profile allowed it), then write.
5. For `module_disable`: uninstall the target module. For `grant_mcp_admin`: `McpBreakGlassManager::grant()`.
6. Write a correlated evidence receipt (`McpEvidenceGuard::receipt()` with observed vs expected postconditions) BEFORE
   persisting `approved`, so a postcondition discrepancy refuses rather than leaving a durable false success.
`deny()` marks the request denied and audits `approval_decision` without touching the target.

## Self-approval / IDOR model
The requester is always a governed agent account (e.g. `mcp_api`); the approver is a human holding
`approve mcp sentinel operations`, which the governed role does not (and must not) hold — separation of duties by
permission, reinforced by the break-glass role deliberately lacking the approve permission. Approval routes take the
request as an `entity:mcp_approval_request` route parameter gated by that permission, and every approval re-checks the
target against the approver, so there is no self-approval or approval-id-substitution path for the agent.

## Break-glass — `McpBreakGlassManager`
Grants the time-boxed `mcp_admin` role: refuses a missing/`is_admin`/over-permissioned role, refuses uid 1 and
standing superusers, HMAC-seals the grant single-use, refuses a missing signing key, and sets `expires = now + ttl`.
`McpBreakGlassConductSubscriber` monitors conduct while a break-glass session is active.

## Tool plugin
`McpMyApprovalsTool` (`mcp_sentinel_my_approvals`, `ToolOperation::Read` → scope `mcp_read`) lets a governed agent
list its own pending approval requests through the governed Tool base.
