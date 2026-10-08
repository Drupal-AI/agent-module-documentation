<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions (approval submodule)

From `mcp_sentinel_approval.permissions.yml`:

- **`approve mcp sentinel operations`** (`restrict access: true`) — approve or deny governed destructive operations
  queued for human approval, and view the `mcp_approval_request` / `mcp_admin_grant` collections (it is the
  `admin_permission` of both entities).

Separation of duties: grant this to a human reviewer, **not** to the governed agent role, and **not** to the
`mcp_admin` break-glass role (that role deliberately omits it so break-glass cannot approve its own elevation). A
standing second person should hold it so a break-glass grant always needs an independent approver.
