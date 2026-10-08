<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides a restricted permissions form so non-admin roles can grant/revoke permissions for lower-weight roles without the sweeping "administer permissions" permission.

---

A role hierarchy is derived from core role **weights** (higher = more permissive). Users holding the `allow delegate permissions` permission get a form at `/admin/people/delegate-permissions` that shows only (a) roles weighted below their own highest role (`DelegatePermissionsHelper::getLowerRoles()`) and (b) permissions they personally hold (`getRestrictedPerms()`), minus any admin-marked "not delegable" permissions. Saving calls core `user_role_change_permissions()` for each lower role. A `hook_form_user_admin_permissions_alter` adds a "Not Delegable" column on the core permissions page (for real admins) to blocklist specific permissions; by default `allow delegate permissions` itself is not delegable. A `config_filter` plugin (`DelegatePermissionsFilter`) reconciles delegated permissions on config import/export so a partial delegate edit does not wipe permissions the delegate could not see.

Security posture (reviewed): the assignable set is constrained to a **safe subset** — a delegate can only grant permissions they already have, and only to roles below theirs, so there is no escalation to `administer permissions` or to any permission the delegate lacks. Two nuances to be aware of when hardening: (1) the "bypassed provider" map (`getBypassedProvidersMap()`: node→`bypass node access`, taxonomy→`administer taxonomy`) makes ALL node/taxonomy permissions delegable to a user who holds the bypass permission even if they do not hold each individual permission — a bounded widening within those providers (DelegatePermissionsHelper.php:160-166); mark sensitive ones "not delegable" if undesired. (2) The submit handler applies `user_role_change_permissions()` using the built form values; the security boundary is enforced at form-build time (only safe roles/permissions are rendered), matching core's UserPermissionsForm pattern. Add any permission you never want sub-delegated to the not_delegable list.

---
- Let a manager role edit permissions of lower roles
- Avoid granting the sweeping "administer permissions"
- Delegate only permissions the delegating user already holds
- Restrict delegation to roles below the user's role weight
- Define the role hierarchy via role weights
- Grant "allow delegate permissions" to trusted roles
- Blocklist tricky permissions via "Not Delegable"
- Keep "allow delegate permissions" itself non-delegable (default)
- Manage a multi-tier editorial permission structure
- Delegate node CRUD perms to users with bypass node access
- Delegate taxonomy perms to users with administer taxonomy
- Reconcile delegated permissions on config import (config_filter)
- Prevent a partial delegate edit from wiping unseen permissions
- Provide a scoped permissions UI at /admin/people/delegate-permissions
- Warn admins to use the core form when they hold administer permissions
- Extend the bypassed-provider map via hook_bypassed_provider_map_alter
- Audit which permissions a role can sub-delegate
- Enforce least privilege for site-section managers
