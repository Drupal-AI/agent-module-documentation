Custom Permissions (config_perms) lets an administrator define brand-new permissions — each tied to one or more Drupal routes — through an admin form, then assign those permissions to roles like any core permission.

---

The module defines a `custom_perms_entity` config entity: each entity is one custom permission, holding a machine `id`, a human `label` (which becomes the permission title on the People → Permissions page), a `route` value (one or more route machine names, newline-separated), and a `status` flag. A dynamic permission callback (`CustomPermissions::permissions`) turns every enabled entity's label into a real, grantable permission. A route subscriber (`RouteSubscriber`) rewrites the access requirements of each named route so the only access check left is the module's own `ConfigPermsAccessCheck`, which grants access when the current user holds the permission named by the entity's label. This effectively lets you carve a single admin route (e.g. "Site information settings") out from under the broad `administer site configuration` permission and hand it to a role that otherwise has no site-config access. Custom permissions only support **routes** (not arbitrary paths — an older `path` field was migrated to `route` in update 8201). User 1 always retains full access, and removing `administer site configuration` from a role is what makes the finer-grained custom permissions meaningful. Manage entries at `/admin/people/custom-permissions/list` (route `custom_perms_select_list_form`, gated by the `administer config permissions` permission). The module ships four example permissions out of the box (account settings, date/time, error logs, file system).

---

- Give a "Content editor" role access to the site information settings form without granting full `administer site configuration`.
- Delegate the cron/logging settings page to an ops role while keeping other config locked down.
- Let a marketing role manage only the site name and slogan (`system.site_information_settings`).
- Expose the date and time format admin page (`entity.date_format.collection`) to a localization team.
- Grant a support role access to the file system settings page (`system.file_system_settings`) only.
- Allow a role to view the recent log messages / error report pages without other admin rights.
- Restrict a custom module's admin route to a bespoke permission you name yourself.
- Bundle several related admin routes under a single custom permission by listing multiple route names.
- Create a "Junior admin" permission that unlocks a curated set of settings forms.
- Hand a contractor temporary access to exactly one configuration route via a role.
- Replace a sprawling `administer site configuration` grant with a handful of scoped custom permissions.
- Gate a third-party module's settings page that only exposes `administer site configuration` by default.
- Provide read/write access to the regional settings page for a specific role.
- Split a monolithic admin permission into role-appropriate slices for a multi-team site.
- Give a role access to the performance/caching settings page without full config access.
- Let editors reach the maintenance-mode toggle page during launches, nothing else.
- Manage which routes a permission covers over time by editing one config entity.
- Export the custom permissions as configuration and deploy them across environments.
- Enable or disable a custom permission (via its `status` flag) without deleting it.
- Seed default scoped permissions in a distribution/install profile via `config/install` YAML.
- Audit exactly which routes each delegated permission unlocks by reading the config entities.
- Grant access to the account settings form (`entity.user.admin_form`) to a user-management role.
- Temporarily lock down a route by disabling its custom permission entity.
- Provide granular admin access in a client site so non-technical admins see only what they need.
