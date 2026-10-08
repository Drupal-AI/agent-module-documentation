<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Lupus Decoupled is an opinionated, ready-to-go decoupled/headless Drupal setup. Instead of exposing raw entity data and rebuilding rendering in the frontend, Drupal keeps rendering — field formatters, text formats, view modes, menus, forms, metatags, access-aware markup — but emits each page as **custom-elements JSON** (`<drupal-…>` component tags) that a JavaScript frontend (Nuxt.js, or any framework) hydrates. It can run fully decoupled with a separate frontend server, or client-side rendered (CSR) where a Lupus CSR theme serves a pre-built SPA directly from Drupal with no separate server.

---

The whole design turns on one small piece of code. `lupus_decoupled_ce_api` registers an HTTP kernel middleware, `BackendApiRequest` (priority 150), that watches for requests under the configurable prefix `/ce-api`. When it sees one it strips the prefix, re-dispatches the request through the same HTTP kernel to the equivalent real path (`/ce-api/node/1` → `/node/1`), and flags the new request so the response is rendered as custom-elements JSON rather than an HTML page. The JSON itself is produced by the required companion project `lupus_ce_renderer` on top of the `custom_elements` module; `lupus_decoupled` supplies the transport, the frontend/backend redirect logic, path processing, previews and CORS. Because the middleware re-runs the genuine route, Drupal's routing, access checks and caching all apply unchanged — this is not a "render any path" proxy, so `/ce-api/admin/…` is denied exactly as `/admin/…` would be, and unpublished or permission-gated content stays gated. The top-level `lupus_decoupled` module is just a meta-package: it pulls in three required submodules (`_ce_api`, `_cors`, `_menu`) and, on install, auto-enables the frontend login forms plus whichever bridge submodules match contrib modules already present (webform, views, layout_builder, schema_metatag, responsive_preview, rest_log). The suite is fifteen submodules in total — the required core three, then bridges for the things that are painful in a decoupled build precisely because they are not plain data: forms (`_form`, `_user_form`, `_contact`, `_webform`), Views (`_views`), blocks (`_block`), Layout Builder (`_layout_builder`), the Canvas page builder (`_canvas`), structured metadata (`_schema_metatag`, `_site_info`), preview tooling (`_responsive_preview`), and request logging (`_api_log`).

Configure it at `/admin/config/system/lupus-decoupled/settings`: set the Frontend Base URL (or the `DRUPAL_FRONTEND_BASE_URL` env var), toggle whether frontend routes redirect to the frontend, choose absolute file URLs, and pick a preview provider and Canvas editor theme. **One integration note found while documenting** (not a security issue): `_ce_api` decorates the `file_url_generator` service with a class that implements `FileUrlGeneratorInterface` rather than extending the concrete core `FileUrlGenerator` class. Any module that type-hints the concrete class will then fatal with a `TypeError` — `complete_webform_exporter` does exactly that and its download route returns HTTP 500 once this suite is installed. If a feature breaks after adopting Lupus Decoupled, a concrete type hint on a decorated service is the first thing to check.

---

- Build a Nuxt.js (or any-framework) frontend against a Drupal backend.
- Serve every Drupal page as custom-elements JSON at `/ce-api/<path>`.
- Keep field formatters, text formats and view modes rendered by Drupal, not the frontend.
- Run fully decoupled with a separate frontend server.
- Run client-side rendered (CSR) with a Lupus CSR theme and no separate frontend server.
- Preserve Drupal's cookie authentication, access control and page caching in a headless build.
- Serve authenticated content previews to the frontend (`?auth=1` credentialed API calls).
- Redirect editors to the frontend after saving/previewing a node.
- Expose Drupal menus as JSON to the frontend (`/api/menu_items/*`).
- Configure CORS (with credentials) for the frontend origin without hand-editing services.yml.
- Submit a Drupal form from the frontend, rendered as a `<drupal-form-…>` custom element.
- Provide decoupled login, registration and password-reset forms.
- Expose a contact form to the frontend as custom elements.
- Handle webform rendering and submission in a decoupled build.
- Render a View (page or block) through the custom-elements API, with pagination.
- Expose blocks to the frontend via a `blocks` key on API responses.
- Support Layout Builder-composed pages in a decoupled site.
- Build pages from components with the Drupal Canvas page builder (`_canvas`).
- Emit schema.org JSON-LD metadata for the frontend (`_schema_metatag`).
- Expose selected site config (name, slogan, …) at `/api/site-info` (`_site_info`).
- Use responsive preview that targets the decoupled frontend URL.
- Log and inspect what the frontend actually requested via rest_log (`_api_log`).
- Change the API prefix from `/ce-api` per project via a services.yml parameter.
- Serve absolute file/image URLs so media keeps working off the Drupal domain.
- Add a node's "View API Output" operation link to inspect its JSON (`use api operation link`).
- Keep the content model as Drupal's concern while the frontend owns presentation.
- Watch for concrete type hints on the decorated `file_url_generator` service when debugging 500s.
