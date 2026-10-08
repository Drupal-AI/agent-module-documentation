Dashboard lets site builders create configurable admin dashboards — `dashboard` config entities whose layout you assemble from blocks with Layout Builder — and shows the right one to each user. It is the contrib successor to core's removed Dashboard module.

---

Each dashboard is a `dashboard` config entity (id, label, description, weight, status) whose `layout` is a set of Layout Builder sections; you build it visually with the "Edit layout" action, dropping in any block — the module's own **Dashboard Text**, **Site Status**, **Navigation Dashboard** and **Placeholder** blocks (category "Dashboard"), plus Views blocks, shortcuts, and any core/contrib block. Dashboards are managed at **Admin → Structure → Dashboard** (`/admin/structure/dashboard`, route `entity.dashboard.collection`, the `configure` route) where you add, edit, preview, delete, reorder by weight, and set per-dashboard permissions. Access is governed by a static `administer dashboard` permission plus a dynamically generated `view <id> dashboard` permission for every dashboard, so you grant each role access to the dashboard(s) it should see. The user-facing page lives at `/admin/dashboard`; `DashboardManager::getDefaultDashboard()` returns the first enabled dashboard (ordered by weight ascending) the current user is allowed to view, and `/admin/dashboard/{dashboard}` renders a specific one. After login, a `hook_user_login` handler redirects users to their default dashboard when one is accessible (respecting an explicit `destination` and skipping the password-reset flow), effectively making a dashboard the per-role landing page. It depends on `layout_builder`, `node`, and `views`, integrates with the Gin theme, Navigation, Toolbar, and Coffee, and registers a `dashboard` Layout Builder section-storage plugin (inline blocks disabled) rather than defining its own plugin type.

---

- Create a per-role admin landing dashboard (e.g. one for editors, one for administrators).
- Assemble a dashboard's layout visually with Layout Builder sections and columns.
- Place the built-in **Dashboard Text** block for a welcome message or instructions.
- Show the **Site Status** block (core status report summary) on an admin dashboard.
- Add the **Navigation Dashboard** block to link into the dashboards from navigation.
- Use the **Placeholder** block to reference a block (like a Views block) that may not always exist.
- Drop a Views block (e.g. recent content) onto a dashboard for at-a-glance lists.
- Add the core Shortcuts block so editors reach common tasks from the dashboard.
- Give each role its own dashboard by granting the matching `view <id> dashboard` permission.
- Order which dashboard is the default for a user by setting dashboard weights.
- Redirect users to their dashboard automatically right after they log in.
- Set a dashboard as the effective home screen for content editors.
- Preview a dashboard before enabling it via the Preview tab.
- Disable a dashboard (status off) so no one is redirected to or can view it.
- Deploy dashboards between environments as exported configuration.
- Manage all dashboards from Admin → Structure → Dashboard.
- Restrict who can build/administer dashboards with the `administer dashboard` permission.
- Render a specific dashboard at `/admin/dashboard/{id}` for direct links.
- Replace core's old Dashboard module on a Drupal 11 site.
- Build a support/ops dashboard mixing status blocks and custom text.
- Provide a first-login welcome screen tailored to each staff role.
- Reorganize an existing dashboard by dragging blocks between regions.
- Combine multiple layouts (one-column, two-column) within a single dashboard.
- Gate a sensitive dashboard so only one role can view it.
- Add custom or contrib blocks (formatted text, embeds, reports) to a dashboard.
