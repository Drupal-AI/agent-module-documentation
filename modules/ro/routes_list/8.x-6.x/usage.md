Routes List adds an admin report at /admin/reports/routes-list that lists every registered route on the site — path, route name, and a human-readable summary of each route's access rule — grouped by the module that provides it.

---

Drupal registers hundreds of routes but offers no single screen that shows them all together with who can reach them. Routes List fills that gap: it iterates the route provider, resolves each route's access requirement into a plain description (a named permission with a link to the permissions page, "Any logged-in user", "Only anonymous users", entity-access control, "Custom rule", or a red "Allowed for anyone" flag), groups the rows under the providing module, and renders a sortable admin table. It is a developer and site-audit aid: install it, grant the dedicated `access routes list` permission to the developers/administrators who need it, read the report, and disable it again when finished. The module has no settings form and stores nothing — the report is computed live on each page load. It also registers minimal Views integration (a `router` base table with Name and Path fields/filters/sorts) for anyone who wants to build a custom routes view.

---

- List every registered route on the site in one screen.
- See the path, route name, and access rule for each route side by side.
- Audit which routes are reachable by anonymous users.
- Spot routes flagged "Allowed for anyone" (`_access: TRUE`) at a glance.
- Review which permission gates a given route.
- Jump from a route's permission to that permission's row on the permissions page.
- Identify routes gated only by login vs. anonymous-only routes.
- Understand entity-access-controlled routes (op + entity type).
- Inspect "Custom rule" routes via the serialized-requirements tooltip.
- Group routes by their providing module for orientation.
- Debug why a route is or isn't accessible.
- Confirm a newly added module's routes registered as expected.
- Find a route's machine name when writing links or tests.
- Cross-check permission configuration during a security review.
- Verify no unintended full-access URLs are exposed.
- Build a custom routes report via the module's Views `router` base table.
- Sort or filter routes by name or path in a Views display.
- Restrict access to the report to trusted developers/admins only.
- Enable the module only while auditing, then uninstall it.
- Onboard developers by showing them the site's routing surface.
- Document a site's URL surface for handover.
- Sanity-check routing after a Drupal core or contrib upgrade.
- Locate reports and diagnostics routes under /admin/reports.
