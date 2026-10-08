<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Lupus Custom Elements Renderer (lupus_ce_renderer) — agent index

Turns Drupal into an API backend that serves a page's **main content and page metadata as JSON**.
It does **not** add a new entity-view endpoint; instead it registers a `custom_elements` request
`_format` and hooks the normal request pipeline. Append `?_format=custom_elements` to *any* Drupal
URL (e.g. `GET /node/1?_format=custom_elements`) and the same route, access checks, param
converters and render/cache pipeline run as usual — only the *response* changes: the entity is
rendered by the required **`custom_elements`** module into a component tree, then wrapped in a JSON
envelope (`title`, `breadcrumbs`, `metatags`, `content`, `page_layout`, plus late-added
`local_tasks`/`messages`). Because it rides the existing route, **access is enforced by Drupal's
routing/access layer before the controller runs** — an unpublished/forbidden node returns 403 in
`custom_elements` format exactly as in HTML (verified at runtime and by the module's own
`LupusCeRendererAccessTest`).

Mechanism: a service provider swaps core's `request_format_route_filter` so the default format can
become `custom_elements`; a **route subscriber** clones the node preview/revision/latest_version
routes (copying all requirements, changing only `_format`+`_controller`); a **controller subscriber**
swaps the controller for `entity.*.canonical` routes at runtime (keeping the original route name and
access); a **view subscriber** turns `CustomElement`/render-array results into a
`CustomElementsJsonResponse`; and further response subscribers convert redirects into JSON
`{redirect:{url,statusCode,external}}` and append uncacheable `messages`/`local_tasks`. The content
serialization is `markup` (default) or `json`, selectable per request. Every CE response carries an
`X-Drupal-CE: page|redirect` header. There is **no admin UI**; all behaviour is driven by request
params, request attributes (set by middleware), `settings.php` globals and one small config object.

- Depends on: `custom_elements:custom_elements`, `metatag:metatag`. Composer also pulls
  `drunomics/service-utils` (trait-based DI helpers).
- Core: `^9 || ^10 || ^11`. No `package` in info.yml. Version **2.7.0**.
- **No settings form / `configure` route**, no permissions, no drush commands, no plugin types, no
  `.module` file. Provides config schema (`lupus_ce_renderer.settings`) edited via drush/config only.
- One hook for integrators: `hook_lupus_ce_renderer_response_alter`.

## What you'd do → where

- **Request CE output, pick markup vs JSON, select only content; understand routes, the renderer
  service, the JSON envelope and every event subscriber** → [api/renderer.md](api/renderer.md)
- **Enable CE by default per site, change default content format, set redirect base URL, map routes
  to a `page_layout`, toggle messages on redirects** → [configure/settings.md](configure/settings.md)
- **Alter the response data (title, metatags, content_format, page_layout, messages…) from code, or
  override it via a request attribute** → [hooks/response-alter.md](hooks/response-alter.md)

## Key facts (real machine names)

- Request params: `?_format=custom_elements` (enable), `?_content_format=markup|json` (serialization),
  `?_select=content` (return only the content, unwrapped).
- Routes: `lupus_ce_renderer.node` (`/node`, `_format: custom_elements`,
  `_permission: 'access administration pages'`) → `CustomElementsController::node`;
  `custom_elements.entity.node.preview` → `::entityPreview`;
  `custom_elements.entity.node.revision` → `::nodeViewRevision`;
  `custom_elements.entity.node.latest_version` → `::entityView` (all three cloned by
  `CustomElementsRouteSubscriber`). Canonical `entity.*.canonical` routes are **not** cloned — the
  controller is swapped to `CustomElementsController::entityView` at runtime by
  `CustomElementsControllerSubscriber`.
- Services: `lupus_ce_renderer.custom_elements_renderer` (`CustomElementsRenderer`),
  `lupus_ce_renderer.ce_metatags_generator` (`CustomElementsMetatagsGenerator`),
  `cache_context.lupus_ce_renderer_content_format` (`ContentFormatCacheContext`, cache-context id
  `lupus_ce_renderer_content_format`).
- Service provider: `LupusCeRendererServiceProvider` sets `request_format_route_filter`'s class to
  `CustomElementsRequestFormatRouteFilter`.
- Event subscribers: `CustomElementsRequestSubscriber` (REQUEST 40),
  `CustomElementsControllerSubscriber` (CONTROLLER 10),
  `CustomElementsEarlyRenderingControllerWrapperSubscriber` (decorates
  `early_rendering_controller_wrapper_subscriber`), `CustomElementsViewSubscriber` (VIEW 100),
  `CustomElementsFormatSubscriber` (RESPONSE 500), `CustomElementsHttpExceptionSubscriber`
  (extends core `CustomPageExceptionHtmlSubscriber`, handles `custom_elements` format, prio -30),
  `CustomElementsRedirectResponseSubscriber` (RESPONSE -11),
  `CustomElementsDynamicResponseSubscriber` (RESPONSE -10), `CustomElementsRouteSubscriber` (ALTER),
  `RouteLayoutSubscriber` (ALTER -300).
- Controller: `Drupal\lupus_ce_renderer\Controller\CustomElementsController`
  (`entityView`, `entityPreview`, `nodeViewRevision`, `node`).
- Response class: `CustomElementsJsonResponse` (extends `CacheableJsonResponse`), header const
  `CE_HEADER = 'X-Drupal-CE'` (value `page` or `redirect`).
- Response JSON keys: `title`, `breadcrumbs`, `metatags` (`meta`/`link`), `content_format`,
  `content`, `page_layout`; late-added `local_tasks`, `messages`; redirect payload
  `redirect: {external, url, statusCode}`.
- Content-format constants: `CustomElementsRenderer::CONTENT_FORMAT_MARKUP` (`markup`),
  `CONTENT_FORMAT_JSON` (`json`).
- Route option: `_lupus_ce_renderer_layout` (set by `RouteLayoutSubscriber` from config) → emitted as
  `page_layout`.
- Config object `lupus_ce_renderer.settings`: `redirect_response.add_drupal_messages` (bool, default
  `false`), `route_layouts` (map of layout → route-name patterns, single trailing `*` wildcard).
- `settings.php` globals: `lupus_ce_renderer_enable`, `lupus_ce_renderer_default_format`,
  `lupus_ce_renderer_redirect_base_url` (legacy), `blacklisted_metatags` (legacy).
- Request attributes (set by code/middleware, not by clients): `lupus_ce_renderer` (bool),
  `lupus_ce_renderer.content_format`, `lupus_ce_renderer_response_data` (override array).
- Hook: `hook_lupus_ce_renderer_response_alter(array &$data, BubbleableMetadata $bm, Request $req)`.
- Update hook: `lupus_ce_renderer_update_8001` (sets `redirect_response.add_drupal_messages: TRUE`
  for existing installs on update, preserving pre-2.x behaviour).
