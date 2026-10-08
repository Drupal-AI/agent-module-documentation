<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions (top-level module)

From `mcp_sentinel.permissions.yml`:

- **`administer mcp sentinel`** (`restrict access: true`) — configure settings, policy profiles, audit and webhook
  behavior; run the dashboard verify action; view/replay/prune webhook deliveries. Also the `admin_permission` of the
  `mcp_policy_profile` config entity.
- **`view mcp sentinel audit log`** — view the governance dashboard, audit log, and audit export; see the site-wide
  critical urgent banner.
- **`access mcp sentinel context`** (`restrict access: true`) — access `/drupal-mcp/context` and `/drupal-mcp/readiness`
  and execute the governed Tool plugins. **Grant to the MCP API user (the `mcp_api` role) only.** Even if this is
  granted to the anonymous role, `/drupal-mcp/readiness` still fail-closes uid 0 and the Tool base still requires the
  full readiness/scope/IP contract, so a hostile grant does not open a governed path.

The approval submodule adds `approve mcp sentinel operations` (see its own permissions doc). `hook_install` seeds an
`mcp_api` role with `access content`, `access user profiles`, `view media`, and `access mcp sentinel context` — assign
it to the agent account, then constrain the agent through its policy profile rather than through role permissions
(escape-hatch permissions on a governed role are flagged by `mcp-sentinel:role-audit`).
