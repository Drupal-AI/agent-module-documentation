# Fast Permissions Administration (fpa)

Fast Permissions Administration replaces Drupal core's permissions page (`/admin/people/permissions`) with an enhanced, filterable version, so managing permissions on sites with many modules and roles stays fast and usable.

---

Drupal core renders every permission for every role on a single, enormous HTML table. On a real site with dozens of modules and several roles that table becomes thousands of rows and checkboxes that are slow to load and painful to scan. FPA takes over the core `user.admin_permissions` route (via a route subscriber) and re-renders the same permission grid with a live, client-side filter box, a per-module list you can jump to, a role filter, and a permission-status filter (checked / not-checked), plus a togglable column showing each permission's machine (system) name. You filter by typing `permission@module` — e.g. `admin@system` matches permissions containing "admin" in modules containing "system". Because everything is filtered in the browser, no page reloads are needed. The module adds a small settings form at `/admin/config/people/fpa-settings` where an administrator can disable individual UI sections (help text, module listing, role filter, status filter). It depends only on the `js_cookie` contrib module (used to remember toggle state) and stores its one config object in `fpa.settings`. There are no plugins, entities, or Drush commands — it is purely a UI enhancement of an existing core page.

---

- Make the permissions page usable on a large site with many contrib modules
- Filter permissions instantly by typing part of a permission name
- Filter permissions by module using the `permission@module` syntax
- Jump to a specific module's permissions from a module listing sidebar
- Show only the permissions for a single role using the role filter
- Show only permissions that are checked (granted) for the current filter
- Show only permissions that are NOT checked (not yet granted)
- Reveal each permission's machine/system name via a togglable column
- Search permissions by their system (machine) name instead of the human label
- Speed up permission audits when reviewing what a role can do
- Reduce browser strain (fewer keyboards and mice harmed) on huge permission tables
- Avoid PHP memory-limit blowups warning when trying to render all roles at once
- Disable the on-page help text section for a cleaner interface
- Disable the module listing sidebar if you don't need it
- Disable the role filter section via settings
- Disable the permission status filter section via settings
- Grant a dedicated permission (`manage fast permissions administration settings`) to let non-admins tune the FPA UI
- Remember the user's column/toggle preferences between visits using a cookie
- Provide a drop-in replacement for the core permissions UI with no content migration
- Quickly locate a specific permission across hundreds of modules before assigning it
- Compare which roles have a given permission side by side after filtering
- Keep the same core save behavior (the underlying form still writes role permissions)
