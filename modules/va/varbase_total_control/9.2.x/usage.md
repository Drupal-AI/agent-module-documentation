Varbase Total Control Dashboard is an admin-dashboard module (built on the Total Control Admin Dashboard, Panels/Page Manager and Charts) that provides a home page for site administration with enhanced blocks — user info, quick links, create-content shortcuts, and a content/comment overview. Best used with the Varbase distribution but works standalone.

---

The module ships a Page Manager dashboard page (a `panels_variant` in `config/optional`) laid out
in two columns and populated with four custom **block plugins**: `varbase_dashboard_user` (info
about the current user), `varbase_quick_links` (handy admin links), `varbase_create_content` (a
configurable "Create New Content" panel listing selected content types), and
`varbase_content_overview` ("My Site Overview" — counts of chosen content types, optional comment
and spam overview). It also provides a Views block (`control_content_panes`) of recent content and
a **`module_enabled` Condition** plugin for showing panes only when a given module is present.
Access to the dashboard is gated by the **`have total control`** permission (from Total Control),
which its `RouteSubscriber` sets on the dashboard's Page Manager routes; a shipped **recipe**
(`recipes/default`) grants that permission to editor/content_admin/seo_admin/site_admin roles and
enables supporting config. Extra dashboard CSS (`varbase_total_control/vtc`) is attached only on the
dashboard routes. Dependencies: Total Control, Charts (with `charts_c3`), Panels/Page Manager; it
declares no permissions of its own, no config schema, no Drush.

---

- Give administrators a single dashboard landing page for common tasks.
- Show the logged-in user's account summary on the dashboard.
- Provide one-click "Create New Content" shortcuts for selected content types.
- Configure which content types appear in the create-content pane per block instance.
- Display a "My Site Overview" with counts of nodes by content type.
- Include comment counts per content type in the overview.
- Surface a spam/unapproved-comment count on the overview.
- List recent content via the bundled Views block.
- Add quick links to frequent admin destinations.
- Gate the whole dashboard behind the `have total control` permission.
- Grant dashboard access to editor/SEO/content-admin roles via the shipped recipe.
- Restrict a dashboard pane to sites where a specific module is enabled (`module_enabled` condition).
- Lay out dashboard widgets in a two-column Panels variant.
- Customize the dashboard by editing the Page Manager variant or its panes.
- Override the default lists by editing the Total Control views.
- Render charts/metrics on the dashboard using the Charts (c3) integration.
- Provide a consistent admin home across a Varbase-based site.
- Reuse the enhanced blocks on other Panels/Layout pages.
- Theme the dashboard with the module's dedicated CSS library.
- Give a new site a ready-made administration experience without building it from scratch.
