# LocalGov Admin Role — agent index

Submodule of **localgov_core**. Install-only: creates the `localgov_admin` ("LocalGov Admin") role
with `is_admin => TRUE`, so core grants it all permissions automatically. Depends on `localgov_roles`.
No permissions, no config route, no services.

Key facts:
- `localgov_admin_role_install()` loads/creates `Role` id `localgov_admin` (`RolesHelper::ADMIN_ROLE`), label "LocalGov Admin", `is_admin => TRUE`. Idempotent; skipped during config sync.
- `is_admin` roles inherit every permission in core — no explicit permission list is stored.
- This is a by-design distribution admin role (assign only to trusted staff); not the reserved uid 1.
