<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# mcp_tools_users — tool reference

All tools extend `McpToolsToolBase` (`MCP_CATEGORY = 'users'`), require the `mcp_tools use users`
permission, and delegate to `UserService` (`mcp_tools_users.user`). Every mutating service method
first calls `AccessManager::canWrite()` (enforces `write` scope + not-read-only) and logs to the
audit logger.

| Tool id | Class | Op | Purpose | Key inputs | Notable guards |
|---|---|---|---|---|---|
| `mcp_create_user` | `CreateUser` | Write | Create an account. | `username`*, `email`*, `password`, `roles`, `status` (default active) | Auto-generates a 16-char password when none given and returns it once; roles run through `filterRoles()`; duplicate name/email rejected. |
| `mcp_update_user` | `UpdateUser` | Write | Update an existing user. | `uid`*, `updates`* (map: `email`/`mail`, `status` bool, `roles` array) | Refuses `uid 1`; only `email`, `status`, `roles` are honored (no password field); roles filtered; duplicate email rejected. |
| `mcp_assign_user_roles` | `AssignUserRoles` | Write | Add roles to a user. | `uid`*, `roles`* (array) | Adds only roles that exist and the user lacks; `filterRoles()` drops blocked names; reports `blocked_roles`. |
| `mcp_block_user` | `BlockUser` | Read* | Block an account (cannot log in). | `uid`* | Refuses `uid 1` and any user with an admin-named role; service still requires `canWrite()`. |
| `mcp_activate_user` | `ActivateUser` | Read* | Activate a blocked account. | `uid`* | Idempotent; service still requires `canWrite()`. |

`*` = required input. **Op** is the plugin's declared `ToolOperation`.

## Operation vs. service enforcement

`BlockUser` and `ActivateUser` declare `ToolOperation::Read`, but their `UserService` methods
(`blockUser()`, `activateUser()`) begin with `AccessManager::canWrite()`, which requires the `write`
scope and honors the global read-only mode. So in practice they behave as writes regardless of the
Read declaration. The three `Write` tools are gated by the base `checkAccess()` (write scope +
content write-kind policy) and again by `canWrite()` in the service.

## Role blocklist

`UserService::filterRoles()` removes any requested role whose lowercased name equals `administrator`
or `admin`, or matches `/^admin/i`, `/administrator/i`, or `/^super/i`. `createUser` and
`assignRoles` both apply it; `userHasAdminRole()` reuses it to protect admin users from `blockUser`.
It matches on the role **machine name**, so only name-based admin conventions are covered — pick
role machine names deliberately when relying on this filter.

## Output highlights

`CreateUser` returns `uid`, `uuid`, `username`, `email`, `status`, `roles`, and — only when the
password was auto-generated — `generated_password` plus a `password_note`. `UpdateUser` returns the
post-update state and `changed_fields`. `AssignUserRoles` returns current `roles` and `added_roles`.
`BlockUser`/`ActivateUser` return the new `status` and a `changed` boolean.
