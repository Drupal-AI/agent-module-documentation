<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Admin UI Only stops a Drupal site from serving its themed front-end: non-admin HTML pages return 403/404, so the site is usable as an admin UI plus a machine API (JSON:API, GraphQL, REST).

---

Admin UI Only limits a Drupal site to its administration UI over HTML. A single event subscriber
(`Drupal\admin_ui_only\EventSubscriber`) inspects each main request's response: if it is a `200`
response with a `text/html` content type on a route that is not an admin route (and not the front
page), the subscriber throws a `403` (Access denied) or `404` (Not found) instead. Requests whose
format is not `html` — JSON:API, GraphQL, REST, and other serialized responses — are left untouched,
which is the point: it lets a decoupled/headless backend expose its API while not serving themed
front-end pages. Admin routes (anything flagged `_admin_route`), a built-in list of user
account/login/logout/password-reset routes, the front page (`/`), and any route names you add on the
settings form all stay reachable as HTML. It provides a settings form at
`/admin/config/admin_ui_only` (permission `administer site configuration`) to choose the error code
(403 vs 404) and to promote extra route names to admin routes. On install, if `node` is enabled it
sets `node.settings:use_admin_theme` to TRUE so content editing keeps working. Requires PHP 8.0;
package Web services; no dependencies beyond core.

---

- Run a decoupled/headless Drupal that serves only JSON:API or GraphQL to visitors.
- Keep the Drupal admin UI usable while hiding the public themed site.
- Return `404` on blocked front-end routes to disclose less about the site.
- Return `403` on blocked front-end routes for clearer "access denied" feedback.
- Let anonymous API traffic (JSON:API/GraphQL/REST) through untouched.
- Stop themed node/taxonomy/view pages from rendering to end users.
- Keep `/user/login`, `/user/logout`, and password-reset flows reachable.
- Keep the user registration page reachable for account signup.
- Add a custom route to the allow-list so a specific HTML page stays public.
- Set the front page to `/user/login` for the cleanest editor entry point.
- Serve a media oEmbed iframe endpoint that must stay reachable.
- Preserve the batch API HTML page so long-running admin batches still run.
- Convert an app-specific route to an admin route without editing code.
- Redirect editors to the content list after saving a node.
- Ensure node editing uses the admin theme automatically on install.
- Toggle the blocked-request error code without a deployment.
- Reduce the number of themed pages a headless site exposes.
- Pair with JSON:API/GraphQL modules to build an API-first Drupal.
- Validate that added route names exist before saving the settings form.
- Rebuild the router automatically when the allow-list changes.
