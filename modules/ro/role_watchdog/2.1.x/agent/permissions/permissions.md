<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Role Watchdog permissions

## Declared in `role_watchdog.permissions.yml`

| Permission | Gates |
|---|---|
| `administer role_watchdog` | The settings form (`admin/config/people/role_watchdog`). Not `restrict access: true`. |
| `access role_watchdog reports` | Intended to gate the reporting Views / history views. |

## Referenced by the entity access handler but NOT declared by the module

`RoleWatchdogAccessControlHandler` and the `role_watchdog` entity annotation check these permissions,
which the module does **not** define in its `.permissions.yml`:

- `administer role watchdog entities` (the entity `admin_permission`; update/delete, and `view` of
  unpublished entries).
- `view published role watchdog entities` (`view` of published entries).
- `add role watchdog entities` (create access).

Because no module declares them, they are grantable to no one via the UI and effectively resolve only
for user 1. Practical effect: the entity add/edit/delete/collection routes under
`admin/structure/role_watchdog` are super-user-only unless another module (or a custom
`hook_permission`-style provider) supplies those permission strings. This is a functional/UX gap, not a
security exposure — it is *more* restrictive than intended, not less. Automatic logging itself needs no
permission.

## Notes

- The README also mentions "View role history" / "View own role history" permissions; those strings do
  not appear in this release's code path either — treat the two declared permissions above as
  authoritative for what the UI can actually grant.
