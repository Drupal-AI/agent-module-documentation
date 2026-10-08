<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Lupus Custom Elements Renderer turns Drupal into an API backend that serves a page's main content and page metadata as JSON, so a decoupled front end can render the components itself.

---

Install it with Composer (`composer require drupal/lupus_ce_renderer`) and enable it with its two dependencies, **`custom_elements`** and **`metatag`**; there is no settings page to configure. Once enabled, request any Drupal URL with the `custom_elements` format to get JSON back instead of HTML — the simplest way is to append `?_format=custom_elements` (for example `GET /node/1?_format=custom_elements`). The response is a JSON envelope containing the page `title`, `breadcrumbs`, `metatags`, the rendered `content`, a `page_layout`, and late-added `local_tasks` and `messages`; every response carries an `X-Drupal-CE: page` (or `redirect`) header. The `content` is serialized either as custom-element **markup** (the default) or as a **json** structure — choose per request with `?_content_format=markup|json`, or globally with `$settings['lupus_ce_renderer_default_format']`. Add `?_select=content` to get just the content without the envelope, which is handy for eyeballing the markup. Crucially, the request runs through Drupal's normal routing, so **authentication and access checks still apply** — an unpublished or forbidden node returns 403 just as it would in HTML, and node previews and revisions work too. The module is the API layer of **Lupus Decoupled Drupal** (whose `lupus_decoupled_ce_api` submodule exposes a convenient `/ce-api/…` path prefix), but it works on its own with any front-end technology. Advanced behaviour — enabling the renderer via a request attribute or `settings.php`, mapping routes to a `page_layout` (the `route_layouts` config), toggling messages on redirect responses (`redirect_response.add_drupal_messages`), and altering the response from code — is all documented in the README and the `agent/` topic files.

---

- Serve a Drupal page's main content as JSON custom elements.
- Add `?_format=custom_elements` to any URL to get a CE response.
- Feed a Nuxt or other decoupled front end from Drupal.
- Keep SEO metatags in the decoupled JSON payload.
- Serve the page title, breadcrumbs and canonical URL with the content.
- Choose custom-element markup or a JSON data structure per request.
- Return only the content with `?_select=content` for inspection.
- Set the default content format globally in settings.php.
- Preserve Drupal's access checks in a decoupled site (403 stays 403).
- Serve node previews to a decoupled editor preview.
- Serve node revisions and latest-version (moderated) content as CE.
- Get redirects back as an explicit JSON `redirect` payload.
- Detect CE responses via the `X-Drupal-CE` header.
- Redirect admin routes to the Drupal backend automatically.
- Use the `/ce-api/` prefix via the Lupus Decoupled stack.
- Support progressive decoupling alongside a coupled Drupal site.
- Map specific routes to a frontend `page_layout` via config.
- Include drupal-messages in redirect responses for SSG/CSR.
- Alter response data from code with `hook_lupus_ce_renderer_response_alter`.
- Override response data per request via a request attribute.
- Avoid reimplementing rendering and access control in JavaScript.
- Keep Drupal's render pipeline and caching in a headless setup.
- Enable the renderer per site-directory via settings.php (legacy).
- Add custom CE routes by declaring the `custom_elements` format.
