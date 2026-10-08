Anu LMS Permissions scopes Anu LMS courses and members to organisations using the Group module, giving teacher/student separation per organisation.

---

This submodule wires Anu LMS into the Group ecosystem (`group`, `gnode`, `groupmedia`). It ships an `anu_organization` group type (as feature-exported config) so that courses, media and members can belong to an organisation, and organisation admins manage their own content and users without site-wide access. A `RouteSubscriber` replaces the group canonical controller (`entity.group.canonical`) with `AnulmsGroupViewController::view`, which for `anu_organization` groups renders an admin-style dashboard of Content blocks (view all content, create a course) and Membership blocks (view members, add new or existing user) — each link shown only when the current user passes its route access check. A second route `/organizations` (`OrganizationListController`) lists the organisations the current user can access via an access-checked entity query; if the user belongs to exactly one, it redirects straight to that group. The submodule also makes the base `Normalizer` add the `user.group_permissions` cache context so the decoupled payload varies correctly per group membership.

Enable it with `drush en anu_lms_permissions -y` (it pulls in Group, gnode and groupmedia). Because access is delegated to Group's own permission model, the security boundary for organisation-scoped content is Group's configuration; this submodule adds the routing/UI layer plus the cache-context integration.

---

- Scope Anu LMS courses to organisations so each organisation sees only its own content.
- Give organisation admins a dashboard to manage their content and members.
- Separate teacher and student capabilities per organisation via Group roles.
- Let a user who belongs to one organisation land directly on it via `/organizations`.
- List all organisations a user may access, honouring Group access checks.
- Create a new course within an organisation from the organisation dashboard.
- View and manage an organisation's members (add new or existing users).
- Vary the decoupled Anu LMS payload cache per group membership (`user.group_permissions`).
- Run a multi-tenant LMS where several organisations share one Drupal site.
- Delegate content and membership administration to non-site-admin organisation managers.
