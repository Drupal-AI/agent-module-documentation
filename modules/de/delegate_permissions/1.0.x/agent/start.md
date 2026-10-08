<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Delegate Permissions (delegate_permissions) — agent index

**Restricted permissions form letting non-admin roles manage lower-weight roles' permissions, limited to the delegate's own held permissions.**

- **Version:** 1.0.x
- **Core:** ^8 || ^9 || ^10 || ^11
- **Requires:** config_filter
- **Route:** `/admin/people/delegate-permissions` (`_permission: 'allow delegate permissions'`, `DelegatePermissionsAdminPermsForm`)
- **Permission:** `allow delegate permissions` (restrict access: true)
- **Service:** `delegate_permissions.helper` → `DelegatePermissionsHelper`
- **Config:** `delegate_permissions.settings` (`not_delegable`, default `['allow delegate permissions']`)
- **Config filter:** `DelegatePermissionsFilter` (reconciles perms on sync)

**Security:** Assignable set is a SAFE SUBSET — only permissions the delegate holds, only roles below their weight; no escalation to `administer permissions` or unheld perms. Nuance: bypassed-provider map makes ALL node/taxonomy perms delegable to holders of `bypass node access` / `administer taxonomy` even if they lack the individual perm (DelegatePermissionsHelper.php:160-166) — bounded widening; use `not_delegable` to blocklist. Boundary is enforced at form-build (core UserPermissionsForm pattern). See [configure/delegation.md](configure/delegation.md).
