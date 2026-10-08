Plausible adds the privacy-friendly [Plausible Analytics](https://plausible.io/) JavaScript tracking snippet to your site's pages, with fine-grained control over which pages, roles, and admin routes are tracked, plus an optional embedded dashboard inside Drupal.

---

The module attaches a tracking `<script>` to every page head via `hook_page_attachments`
(`plausible_page_attachments`), gated by a set of visibility rules stored in the `plausible.settings`
config object. Global on/off is `visibility.enable`; page targeting (`request_path_mode` +
`request_path_pages`) works like core's block visibility ("all except listed" / "listed only"); role
targeting (`user_role_mode` + `user_role_roles`) tracks or excludes selected roles; and
`admin_route_mode` decides whether admin pages are tracked. It supports two snippet generations: the
new **october-2025** script (uses `script.src` plus a `plausible.init()` bootstrap with an optional
`endpoint`) and the legacy snippet (uses `script.src`, `data-domain`, optional `data-api`). Optional
custom-event scripts fire on 403 and 404 responses when `events.403` / `events.404` are enabled. Cache
contexts (`url.path`, `user.roles`, and a custom `route.is_admin` context provided by the module's
`cache_context.route.is_admin` service) are added only when the corresponding visibility mode is
active, and the config is added as a cache tag. Two permissions are defined: `administer plausible
configuration` (the settings form at `/admin/config/services/plausible`) and `view plausible
dashboard` (a reports page at `/admin/reports/plausible` that embeds your Plausible **shared link** in
an iframe, auto-selecting light/dark to match the Gin admin theme when present). The module has no
external library or module dependencies; Gin and Markdown are optional niceties.

---

- Add privacy-friendly, cookieless Plausible analytics tracking to a Drupal site.
- Track page views without Google Analytics and without a cookie-consent banner.
- Point tracking at self-hosted Plausible by overriding the script `src` and API endpoint.
- Set the tracked domain explicitly (legacy snippet) instead of auto-detecting the front-page host.
- Proxy analytics requests through a custom API endpoint to dodge ad blockers.
- Track only a specific set of pages by path (e.g. `/blog/*`).
- Track every page **except** a listed set (e.g. exclude `/user/*`).
- Exclude editors/admins from analytics by role so staff traffic isn't counted.
- Track only selected roles (e.g. anonymous visitors only).
- Include or exclude admin routes from tracking.
- Globally pause all tracking with a single toggle without uninstalling.
- Fire a Plausible custom event on 403 (access denied) pages.
- Fire a Plausible custom event on 404 (not found) pages to find broken links.
- Embed the Plausible dashboard inside Drupal via a shared link at *Reports › Plausible Dashboard*.
- Match the embedded dashboard's light/dark theme to the Gin admin theme automatically.
- Let a non-admin role view the analytics dashboard via the `view plausible dashboard` permission.
- Restrict who can change tracking configuration with `administer plausible configuration`.
- Send custom events from your own JS using the `window.plausible(...)` queue the snippet sets up.
- Keep tracking correctly cached per-path / per-role only when those visibility modes are in use.
- Migrate from the legacy snippet to the october-2025 script by switching `script.version`.
- Comply with privacy/GDPR expectations by using an IP-anonymising, cookieless analytics tool.
