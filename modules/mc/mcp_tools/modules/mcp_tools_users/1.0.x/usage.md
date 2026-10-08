MCP Tools - Users adds five Tool API plugins that let an AI assistant create, update, block, activate, and role-assign Drupal user accounts through the parent MCP Tools server.

---

This is one of MCP Tools' domain submodules. Enabling it registers five `tool` plugins (`mcp_create_user`, `mcp_update_user`, `mcp_assign_user_roles`, `mcp_block_user`, `mcp_activate_user`), each backed by `UserService` (service `mcp_tools_users.user`). It exposes no routes, no config, and no UI of its own — the tools are only reachable through a connected MCP client (STDIO or HTTP transport) or any Tool API consumer (ECA, AI Agents). Every call is governed by the parent's access model: the tool appears only when this submodule is enabled, the caller needs the `mcp_tools use users` permission, the connection scope must permit the operation, the global read-only and config-only modes can block writes, and the call runs as the configured execution user and is audit-logged. `UserService` adds its own guards: `uid 1` cannot be updated or blocked, users holding an admin-named role cannot be blocked, and a role blocklist (`filterRoles()`) strips `administrator`/`admin`/`super*`-style names from create and assign operations.

Turn this submodule on only when an assistant genuinely needs to manage accounts, and prefer a least-privilege execution user plus a narrow scope. See the tool reference in `agent/tools/user-tools.md` and the parent module for the shared access model.

---
- Ask the assistant to create a new active editor account with an auto-generated password.
- Create a blocked account to be activated later.
- Create an account with a chosen username, email, and specific non-admin roles.
- Update a user's email address.
- Change a user's active/blocked status via `mcp_update_user`.
- Replace a user's role set in a single update call.
- Add extra roles to an existing user with `mcp_assign_user_roles`.
- Block a spammy or compromised account so it can no longer log in.
- Re-activate a previously blocked account.
- Have the assistant look up a uid (via the parent's user-read tools) then update that user.
- Onboard several new team members from a plain-English description.
- Bulk-block a list of accounts flagged during moderation.
- Rotate a user off elevated roles by updating their role list.
- Auto-generate and return a one-time password when provisioning an account.
- Keep the tools hidden entirely by leaving this submodule disabled.
- Restrict a connection to `read` scope so none of these write tools can mutate accounts.
- Require `write` scope before an assistant may create or change users.
- Gate the whole domain behind the `mcp_tools use users` permission.
- Block all account writes site-wide with the server's global read-only mode.
- Run the tools as a dedicated, non-admin execution account for least privilege.
- Audit which account tools are exposed on the MCP status page.
