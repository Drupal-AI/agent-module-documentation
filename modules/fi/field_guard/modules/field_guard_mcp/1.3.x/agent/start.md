<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Guard MCP (field_guard_mcp) — agent index

Optional submodule of **Field Guard**. Two **read-only** Tool API plugins, governed by
**MCP Sentinel**, that report which fields Field Guard protects and the guard's verdict for
the acting account. **Names only, never field values.** Version **1.3.x**. Core
`^10.6 || ^11.3` (narrower than the base module: MCP Sentinel does not declare Drupal 12).
Package `Security`.

Dependencies: `field_guard:field_guard`, `mcp_sentinel:mcp_sentinel (>=2.22.0)`,
`tool:tool (>=1.0.0-beta8)`. Enable with `drush en field_guard_mcp`. Installing it publishes
nothing — enable the tools in your site's MCP tool bridge configuration.

- **The two tools, their inputs/outputs, the shared base class, governance, permission, and
  limits** → [tools/mcp-tools.md](tools/mcp-tools.md).
- **Parent module** (the guard the tools report on) → [../../../../1.3.x/agent/start.md](../../../../1.3.x/agent/start.md).

## Tools (both `ToolOperation::Read`)

- **`field_guard_list_guarded`** (`ListGuardedTool`) — lists an entity type's guarded fields
  (optionally one bundle): per field, the guarded operations, the permission each requires, and
  the own-subject flag. At most 500 fields, with a `truncated` marker.
- **`field_guard_check_access`** (`CheckAccessTool`) — for the acting account only, reports the
  guard's verdict (`guarded`, `allowed`, `permission`, `own_subject_exempt`) on 1–50 named fields
  of one bundle, for `view` or `edit`. `allowed: true` means Field Guard does not deny; a field it
  does not guard returns `guarded: false`, `allowed: null`.

## Guarantees (from source)

- Permission `use field guard mcp tools` (`field_guard_mcp.permissions.yml`, `restrict access: true`),
  required by every tool (`FieldGuardToolBase::checkGovernedAccess()`).
- Verdict uses `field_guard.explicit_permission_checker` — the same rule as the access hook — so
  uid 1 and `is_admin` roles are reported as denied unless a non-admin role holds the permission.
- Acting account only: `CheckAccessTool` uses `$this->currentUser`; there is no input naming
  another account. No tool loads an entity or returns a field value. No write, cross-user, or
  own-subject-resolution tool exists, by design.
- MCP Sentinel gates first (profile resolve, rate limit, response-size cap); `doExecute()`
  rechecks access for PHP callers; output is capped at `MAX_RESULT_BYTES = 131072` (or the
  profile's smaller cap). Refusals are one fixed message; the log records only exception class,
  file and line — never caller input.
