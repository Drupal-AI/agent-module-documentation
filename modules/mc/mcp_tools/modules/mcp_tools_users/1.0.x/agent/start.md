<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools - Users (mcp_tools_users) — agent index

Submodule of **mcp_tools**. Adds five Tool API plugins for Drupal user-account management, callable
by an AI assistant through the parent's MCP server (or any Tool API consumer). Version
**1.0.0-beta8** (dir `1.0.x`). Core `^10.3 || ^11 || ^12`.
Depends on: `mcp_tools:mcp_tools`, `drupal:user`.
Permission: **`mcp_tools use users`** (`restrict access: true`). No routes, no config, no UI.

- **The five tools, their ids, inputs, operations, and service guards** →
  [tools/user-tools.md](tools/user-tools.md)

## What it provides

- Five `#[Tool]` plugins in `src/Plugin/tool/Tool/`, all extending `McpToolsToolBase` with
  `MCP_CATEGORY = 'users'`: `CreateUser` (`mcp_create_user`), `UpdateUser` (`mcp_update_user`),
  `AssignUserRoles` (`mcp_assign_user_roles`), `BlockUser` (`mcp_block_user`),
  `ActivateUser` (`mcp_activate_user`).
- One service, `UserService` (`mcp_tools_users.user`, `src/Service/UserService.php`), holding the
  create/update/block/activate/assign logic, wired to `entity_type.manager`,
  `password_generator`, `mcp_tools.access_manager`, and `mcp_tools.audit_logger`.
- No permissions beyond the one above, no Drush, no config schema, no hooks.

## Access model (from the parent)

`McpToolsToolBase::checkAccess()` = the `mcp_tools use users` permission AND the connection scope
for the tool's declared operation AND the config-only write-kind policy. Category `users` maps to
write-kind **content**. `UserService` re-checks `AccessManager::canWrite()` on every mutating call,
so the global read-only mode and `write` scope are enforced at the service layer too. Each call runs
as the configured execution user and is written to the audit log. See [[mcp_tools]] for the full
model.

## Built-in guards (UserService)

- `uid 1` cannot be updated (`updateUser`) or blocked (`blockUser`).
- Users holding an admin-named role cannot be blocked (`userHasAdminRole()`).
- `filterRoles()` strips role names matching the blocklist (`administrator`, `admin`) and the
  patterns `/^admin/i`, `/administrator/i`, `/^super/i` from `createUser` and `assignRoles`.
- Email is `FILTER_VALIDATE_EMAIL`-checked; username ≤ 60 chars, email ≤ 254; duplicate
  username/email rejected.
