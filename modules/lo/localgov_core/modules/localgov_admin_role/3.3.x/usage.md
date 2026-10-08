LocalGov Admin Role creates a single "LocalGov Admin" role (`localgov_admin`) flagged as an admin role, so Drupal automatically grants it every permission on the site — a distribution-standard administrator role separate from user 1.

---

On install (`localgov_admin_role_install`), the submodule loads or creates the role whose machine name is `RolesHelper::ADMIN_ROLE` (`localgov_admin`) with label "LocalGov Admin" and `is_admin => TRUE`. Because Drupal core treats an `is_admin` role as having all permissions, this role always holds every current and future permission without listing them, and is excluded from per-permission grants. It depends only on `localgov_roles` (for the `RolesHelper` constant). There is no config UI and no permissions defined here; the role is created idempotently (skipped if it already exists or during config sync). Assign this role to trusted staff who need full administrative access.

---

- Provide a full-access administrator role for LocalGov staff without using user 1.
- Get an `is_admin` role that automatically inherits every module's permissions.
- Keep the admin role permission-complete as new modules add permissions over time.
- Standardize the administrator role machine name (`localgov_admin`) across LocalGov sites.
- Assign trusted administrators a single all-permissions role.
- Avoid maintaining a long explicit permission list for site admins.
- Pair with role_delegation so site admins can grant/revoke other roles.
- Create the role idempotently as part of a distribution install.
- Target the admin role from code via `RolesHelper::ADMIN_ROLE`.
- Separate day-to-day admin access from the reserved super-user (uid 1) account.
- Give multiple administrators equivalent full access via one shared role.
- Ensure new contrib module permissions are immediately available to admins.
- Provide a consistent admin role for automated provisioning/scripts.
- Recover full admin access by assigning the role to a rescue account.
- Standardize administrator capabilities across a LocalGov distribution.
- Reduce the risk of missing a permission when configuring an admin manually.
