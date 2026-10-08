Lets a site administrator define custom 403 (access denied) and 404 (page not found) pages — with configurable title, HTML body, and theme — plus regex-based redirects for 404s, without creating nodes.

---

Custom Error registers a public route `/customerror/{code}` (default code 404) that renders a themed error page from module config. You point Drupal's core error pages (*Basic site settings → Error pages*) at `/customerror/403` and `/customerror/404`; the module's controller then returns the configured `title` and `body` for that code and sends the matching HTTP status header. The settings form (`/admin/config/system/customerror`, gated by the core `access site administration` permission) stores, per code, a `title`, a `body` (a textarea intended for HTML), a `theme` override (any installed theme, default = admin theme), and an `enable_login` flag; plus a global `redirect` textarea of `"<regex> <destination>"` pairs (one per line) applied to 404 request URIs. When `enable_login` is set and the visitor is anonymous, the error page also embeds the core user login form and, via a login submit handler, honors the `destination` so the user returns to the page they were denied. Config is `customerror.settings` (schema provided); the page output is themed by `customerror.html.twig` with per-code template suggestions `customerror__403` / `customerror__404`. There are no permissions, plugins, or Drush commands of its own. (Note some rough edges: `customerror_get_theme()` reads a mismatched config name/key so the per-code theme override is effectively inert, and `enable_login` is used by the code but absent from the config schema.)

---

- Show a branded, friendly "Page not found" (404) page instead of the plain Drupal default.
- Show a custom "Access denied" (403) page with your own wording and HTML.
- Return the correct 403/404 HTTP status while serving a custom page (so robots don't index errors).
- Put HTML (links to the FAQ, search, contact) into the error page body.
- Embed the login form on the 403 page so anonymous users can log in and continue.
- Redirect a logged-in user back to the originally requested page after they authenticate.
- Set up regex-based redirects for old/removed 404 URLs to new destinations.
- Redirect matched 404 paths to the site front page using the `<front>` keyword.
- Give each error page its own template via `customerror--404.html.twig` / `customerror--403.html.twig`.
- Localize error page title/body through configuration translation.
- Avoid creating real nodes/content types just to host error pages.
- Point multiple old URLs at consolidated new pages with one redirect pair per line.
- Configure a title separate from the body for each error code.
- Preview the error pages by visiting `/customerror/403` and `/customerror/404` directly.
- Keep error content out of node listings and search results (it is not a node).
- Use a consistent error experience managed entirely from a single admin form.
