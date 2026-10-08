Adds an embedded Acquia Content Hub dashboard (an Angular app) for monitoring syndication, plus an
"automatic publisher discovery" feature that keeps a CORS allow-list of publisher webhook origins
current so the dashboard can communicate with publisher sites.

---

This submodule surfaces a Content Hub dashboard at
`/admin/acquia-contenthub/contenthub-dashboard`, rendered as an iframe around a prebuilt Angular
application shipped in the module's `dashboard/` directory. Access is gated by a dedicated,
restricted permission (`administer ach dashboard`) plus a connected Content Hub client, enforced
by the `ContentHubDashboardAccess` check. It stores two settings in
`acquia_contenthub_dashboard.settings`: `auto_publisher_discovery` (a master toggle exposed as a
checkbox on the base Content Hub admin settings form when the subscriber module is enabled) and
`allowed_origins` (publisher webhook origins). When discovery is on, the module attaches a
`client_publisher_filter` to the site's webhook, seeds allowed origins from the service, updates
them on validated inbound webhooks (`UpdateAllowedOrigins` on the base `HANDLE_WEBHOOK` event), and
extends the site's CORS configuration (headers, methods, origins) by swapping the
`http_middleware.cors` service for `ContentHubCors`. A Drush command
(`acquia:contenthub-dashboard-allowed-origins`, alias `ach-dao`) refreshes the origin list on
demand. A helper route resolves a Content Hub UUID to a local entity's edit form. It depends on
`acquia_contenthub`; discovery/CORS additionally need `acquia_contenthub_subscriber`.

---

- Monitor Content Hub syndication from an admin dashboard.
- View export and import queue counts at a glance.
- Delegate dashboard access via a dedicated restricted permission.
- Require a connected Content Hub client before showing the dashboard.
- Keep a CORS allow-list of publisher webhook origins up to date automatically.
- Toggle automatic publisher discovery from the Content Hub settings form.
- Attach a publisher-discovery filter to the site's webhook.
- Extend CORS headers and methods needed for Content Hub API calls.
- Refresh allowed origins on demand with a Drush command.
- Update allowed origins in response to validated inbound webhooks.
- Jump from a Content Hub UUID to the local entity's edit form.
- Seed allowed origins by querying the service for publisher clients.
- Preserve existing wildcard CORS entries when extending CORS.
- Embed the Angular dashboard app served from the module.
- Give operators visibility into a multi-site syndication network.
