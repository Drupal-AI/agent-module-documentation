<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Lupus Decoupled (lupus_decoupled) — agent index

Opinionated, ready-to-go **decoupled / headless Drupal**. Instead of exposing raw entity data
(JSON:API / GraphQL) and re-implementing rendering in the frontend, Drupal keeps rendering —
field formatters, text formats, view modes, menus, forms, metatags, access-aware markup — but
emits the page as **custom-elements JSON** (`<drupal-…>` components) that a JavaScript frontend
(Nuxt.js, or any framework) hydrates. Version **1.5.1**. Core `^10 || ^11`.

The top-level `lupus_decoupled` module is a **meta-package**: it declares three required submodules
(`lupus_decoupled_ce_api`, `lupus_decoupled_cors`, `lupus_decoupled_menu`) and, via
`hook_modules_installed`, auto-enables `lupus_decoupled_user_form` plus bridge submodules whenever
their target contrib module (`responsive_preview`, `rest_log`, `webform`, `schema_metatag`,
`views`, `layout_builder`) is present (set `LUPUS_DECOUPLED_AUTO_ENABLE` to force all of them, e.g.
for demos). It ships no routes, services or code of its own beyond that install hook.

## The core mechanism (read this first)
See [agent/api/ce-api.md](api/ce-api.md) for full detail. In short:

- `lupus_decoupled_ce_api` registers an **HTTP middleware** `BackendApiRequest` (tag
  `http_middleware`, priority 150). Any request whose path starts with the configurable prefix
  **`/ce-api`** (`lupus_decoupled_ce_api.api_prefix`) has the prefix stripped and is **internally
  re-dispatched through the same HTTP kernel** to the equivalent real path (`/ce-api/node/1` →
  `/node/1`), with request attributes `lupus_ce_renderer = TRUE` and
  `lupus_ce_renderer.content_format = 'json'` set. The actual JSON rendering is done by the separate
  **`lupus_ce_renderer`** ("Lupus Custom Elements Renderer") project, using the **`custom_elements`**
  module to turn render arrays into component tags.
- Because it re-runs the real route, **normal Drupal routing, access checks and caching apply** —
  requesting `/ce-api/admin/...` resolves to the `/admin/...` route and is denied to users lacking
  the permission. The middleware only changes the URI and the render format.
- Two rendering modes: **fully decoupled** (a separate Nuxt server fetches `/ce-api/*`), or
  **client-side rendering (CSR)** where a [Lupus CSR](https://www.drupal.org/project/lupus_csr)
  theme serves a pre-built SPA shell from Drupal itself, no separate frontend server
  (`LupusCsrPageVariantSubscriber` swaps in the lightweight `simple_page` display variant).

## Configuration
- Route: `/admin/config/system/lupus-decoupled/settings` (`administer site configuration`),
  form `LupusDecoupledSettingsForm`, config `lupus_decoupled_ce_api.settings`.
- Keys: `frontend_base_url` (overridable by env `DRUPAL_FRONTEND_BASE_URL`),
  `frontend_routes_redirect` (bool — open frontend routes by redirecting to the frontend),
  `absolute_file_urls` (bool, default TRUE — emit absolute file URLs so they work off-domain),
  `preview_provider` (string, default `markup`), `theme` (string, default `stark` — theme for
  Canvas editor routes).

## Routing / redirect model
- `LupusFrontendRouteSubscriber` marks routes whose path is in the `frontend_paths` parameter
  (`/`, `/node`, `/node/{node}`, node preview) with the route option `_lupus_frontend: TRUE`.
- `LupusRedirectSubscriber`: `_lupus_frontend: TRUE` HTML requests on the backend are redirected
  (via `TrustedRedirectResponse`) to `frontend_base_url + URI` (only when a frontend URL is set and
  `frontend_routes_redirect` is on); `_lupus_frontend: FALSE` routes hit via ce-api are redirected
  back to the backend. `hook_trusted_redirect_hosts_alter` whitelists the frontend host.
- Outbound path processors rewrite frontend-path URLs to the frontend domain
  (`LupusFrontendPathProcessor`), keep `/user`-style paths on the backend
  (`LupusKeepFrontendPathProcessor`), and add `?auth=1` to preview URLs so a static frontend makes a
  cookie-authenticated API call (`LupusPreviewPathProcessor`).
- `file_url_generator` is **decorated** by `Drupal\lupus_decoupled_ce_api\File\FileUrlGenerator`
  (absolute file URLs for the frontend). `CurrentUserResponseSubscriber` adds a `current_user`
  block (`id`, `name`, `roles` of the **current session's own** account) to each ce-api JSON
  response, cached per user.

## Permissions
- `use api operation link` (ce_api) — shows a "View API Output" operation link on node/webform
  admin listings pointing at the entity's `/ce-api` URL. No permissions in the top-level module.

## Submodules (15)
Required: **`_ce_api`** (the middleware + settings + redirect/path/theme plumbing — the heart),
**`_cors`** (container-alters `cors.config`: enables CORS, `supportsCredentials: TRUE`, adds
`authorization`/`cache-control`/`pragma` headers and GET/POST; appends configured frontend origins),
**`_menu`** (enables `rest_menu_items`, exposes menus as JSON at `/api/menu_items/*`).
Bridges (opt-in): **`_form`** (renders Drupal forms as `<drupal-form-…>` custom elements via
`CustomElementsFormController`/`CustomElementsEntityFormController`, cloning core form controllers
so access requirements are preserved), **`_user_form`** (login/register/password forms + a
`LupusSessionConfiguration` returning a NULL cookie domain so the browser uses the exact host),
**`_contact`** (CE variant of contact forms via a `_format: custom_elements` cloned route),
**`_webform`** (webforms as custom elements + block override), **`_views`** (Custom Elements page &
block Views display plugins + a `CustomElements` style plugin), **`_block`** (adds a `blocks` key to
ce-api responses), **`_layout_builder`** (custom-elements-aware Layout Builder preview display),
**`_canvas`** (Drupal Canvas page-builder integration — theme negotiation for editor routes, a
`CanvasRegisterComponents` config action; core `^11` only), **`_schema_metatag`** (adds `jsonld`
to the response via `hook_lupus_ce_renderer_response_alter`), **`_site_info`** (REST resource
`/api/site-info` exposing a configurable allow-list of config keys; default `system.site` name /
slogan / mail), **`_responsive_preview`** (rewrites responsive-preview toolbar to target the
frontend URL), **`_api_log`** (routes ce-api requests into `rest_log` for inspection).

Each submodule has its own doc dir under
`modules/lu/lupus_decoupled/modules/<name>/1.5.x/`.

## Integration gotcha (verified, not security)
`_ce_api` decorates the `file_url_generator` service with a class that **implements**
`FileUrlGeneratorInterface` rather than extending the core `FileUrlGenerator` class. Any module that
type-hints the **concrete** class fatals with a `TypeError` — observed with
`complete_webform_exporter` (download route → HTTP 500). When something breaks after installing this
suite, check for a concrete type hint on a decorated service first.
