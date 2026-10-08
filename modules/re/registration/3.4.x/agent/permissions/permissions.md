<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `registration.permissions.yml` plus dynamic ones from
`RegistrationPermissionProvider::buildPermissions` (per registration type).

| Permission | Gates |
|---|---|
| `access registration overview` | the registrations overview page |
| `administer registration types` | manage registration types, their fields & displays (restricted) |
| `administer registration` | view/edit/delete/manage **all** registrations & settings, any type (restricted); also the global settings form |
| `create registration` | create registrations of any type (self, other users, or by email) |
| `view any registration` | view all registrations, any type |
| `view own registration` | view one's own registrations |
| `view host registration` | view registrations for hosts the user can edit |
| `update host registration` | update registrations for hosts the user can edit |
| `delete host registration` | delete registrations for hosts the user can edit |

Per-type permissions (from the permission callback) mirror these for a single registration type,
e.g. **`create <type> registration`**, `view own <type> registration`,
`update any <type> registration`, `delete own <type> registration`, etc., so you can grant rights on
one registration type without granting them for all. Host-operation access
(view/update/delete/manage/register on a specific host) additionally runs through
`hook_registration_host__access()` and the host access control handler.

Submodules add their own permissions (overrides, cancel-by bypass, change-host, IEF settings,
scheduled actions, workflow transitions) — see each submodule's `permissions` doc.
