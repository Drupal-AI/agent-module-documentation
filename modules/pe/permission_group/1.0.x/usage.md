<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Permission Group lets administrators define a named group of permissions and then grant that whole group to a role with a single checkbox on the standard permissions form. It simplifies managing large permission sets: instead of ticking dozens of individual permissions per role, you tick one group, and the underlying permissions are kept in sync automatically.

---

Permission groups are a `permission_group` config entity managed at `/admin/people/permission_groups` (route `entity.permission_group.collection`, gated by `administer permissions`), with add/edit/delete forms and dedicated permission-selection forms. The module alters `user_admin_permissions` (`hook_form_user_admin_permissions_alter`) to inject group checkboxes at the top of the permissions table and to disable the individual permissions that a group manages (showing a tooltip). Group membership per role is stored as a role third-party setting (`permission_group.groups`); `hook_user_role_presave()` reconciles the role's actual granted permissions — adding the group's permissions when a group is enabled and revoking them when it is removed. A separate, restricted permission `assign permission group to role` (with the `/admin/people/permission_groups/assign_to_role` form) allows delegating group-to-role assignment; because groups can contain security-sensitive permissions, that delegated permission is flagged `restrict access: true` and admin roles are protected. Requires PHP 7.1+.

---

- Grant a bundle of related permissions to a role with a single checkbox.
- Simplify onboarding a new "Editor" or "Shop manager" role.
- Keep a role's permissions in sync when a group's contents change.
- Reduce mistakes from manually ticking dozens of permissions.
- Define reusable permission bundles as exportable config entities.
- Show which group manages a permission via tooltips on the permissions form.
- Prevent double-management by disabling group-controlled individual checkboxes.
- Delegate role assignment via a scoped `assign permission group to role` permission.
- Warn admins when a group carries security-sensitive permissions.
- Protect admin roles from being modified through group checkboxes.
- Standardize permission sets across multiple sites via config export.
- Revoke a whole capability set from a role by unchecking one group.
- Maintain consistent access profiles for common job functions.
- Audit access more easily by reviewing groups instead of raw permissions.
- Reconcile permissions automatically on role save (no manual re-sync).
- Build install-profile/recipe permission presets as permission groups.
