<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Lupus Decoupled CE API (lupus_decoupled_ce_api) — agent index

Submodule of **lupus_decoupled** and a **hard dependency of the top-level module** — this is the
heart of the suite. Provides the **custom-elements API at `/ce-api`**. Version **1.5.1**. Core
`^10 || ^11`. Depends on `trusted_redirect`, `lupus_ce_renderer`, `custom_elements`, `path_alias`.

## Mechanism
The endpoint is an **HTTP kernel middleware**, not a controller or REST resource.
`Drupal\lupus_decoupled_ce_api\BackendApiRequest` (service tag `http_middleware`, priority 150,
args `%…api_prefix%` = `/ce-api`, `%…content_format%` = `json`) intercepts any request under the
prefix, strips it, and **re-dispatches the request through the same HTTP kernel** to the equivalent
real path (`/ce-api/node/1` → `/node/1`), setting request attributes `lupus_ce_renderer = TRUE` and
`lupus_ce_renderer.content_format = 'json'`. The companion project **`lupus_ce_renderer`** keys on
that attribute to render the page's main content as custom-elements JSON (via the `custom_elements`
module). Because the middleware re-runs the genuine route, **normal Drupal routing, access checks
and caching all apply** — there is no arbitrary-path render bypass.

Drupal keeps rendering — formatters, text formats, view modes, access-aware markup — and emits
`<drupal-…>` elements; the frontend hydrates them. Adding a field or changing a formatter needs
**no** frontend work.

## What this submodule adds
- **Settings** at `/admin/config/system/lupus-decoupled/settings` (`administer site configuration`),
  config `lupus_decoupled_ce_api.settings`: `frontend_base_url` (env `DRUPAL_FRONTEND_BASE_URL`
  overrides), `frontend_routes_redirect`, `absolute_file_urls` (default TRUE), `preview_provider`
  (default `markup`), `theme` (default `stark`, for Canvas editor routes).
- **Redirect logic** — `LupusFrontendRouteSubscriber` marks `frontend_paths` routes with
  `_lupus_frontend: TRUE`; `LupusRedirectSubscriber` redirects those HTML backend hits to
  `frontend_base_url` (TrustedRedirectResponse; frontend host whitelisted via
  `hook_trusted_redirect_hosts_alter`) and sends `_lupus_frontend: FALSE` ce-api hits back to the
  backend.
- **Outbound path processors** — `LupusFrontendPathProcessor` (rewrite frontend-path URLs to the
  frontend domain), `LupusKeepFrontendPathProcessor` (keep `/user*` on the backend),
  `LupusPreviewPathProcessor` (add `?auth=1` to preview URLs so a static frontend makes a
  cookie-authenticated call).
- **`current_user` response data** — `CurrentUserResponseSubscriber` adds the current session's own
  account (`id`, `name`, `roles`) to each ce-api JSON response, cached per user (RESPONSE priority 6,
  after Dynamic Page Cache).
- **Theme negotiation** — `RouteThemeNegotiator` applies the configured `theme` to routes marked
  `_lupus_decoupled_theme` (used by `_canvas`); `LupusCsrPageVariantSubscriber` selects the
  lightweight `simple_page` display variant when a `lupus_csr` (CSR) theme is active.
- **Service decoration** — the `file_url_generator` service is **decorated** by
  `Drupal\lupus_decoupled_ce_api\File\FileUrlGenerator` to emit absolute file URLs for the frontend.
- **Preview provider** factory selects a `custom_elements` preview provider (frontend base URL or a
  detected CSR theme's dist dir as base).

## Permissions
- `use api operation link` — adds a "View API Output" operation link (→ the entity's `/ce-api` URL)
  on node/webform admin listings (`hook_entity_operation`).

## Integration gotcha (not security)
The `file_url_generator` decorator **implements** `FileUrlGeneratorInterface` rather than extending
the concrete core `FileUrlGenerator` class. Any module type-hinting the **concrete** class fatals —
verified against `complete_webform_exporter`, whose download route returns HTTP 500 with a
`TypeError`.
