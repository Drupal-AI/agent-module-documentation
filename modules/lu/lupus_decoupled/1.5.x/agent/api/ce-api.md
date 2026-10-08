<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The /ce-api custom-elements endpoint

## How a request becomes JSON
The endpoint is **not** a controller or a REST resource. It is an HTTP kernel middleware.

`Drupal\lupus_decoupled_ce_api\BackendApiRequest` is registered in
`lupus_decoupled_ce_api.services.yml` as:

```yaml
lupus_decoupled_ce_api.middleware.backendapi:
  class: Drupal\lupus_decoupled_ce_api\BackendApiRequest
  arguments: ['%lupus_decoupled_ce_api.api_prefix%', '%lupus_decoupled_ce_api.content_format%']
  tags:
    - { name: http_middleware, priority: 150 }
```

Parameters (override in a `*.services.yml` to customise per project):
- `lupus_decoupled_ce_api.api_prefix` — default `/ce-api`.
- `lupus_decoupled_ce_api.content_format` — default `json` (also supports `markup`).

In `handle()`:
1. It looks at the request path. If it starts with `/ce-api/` (or is exactly `/ce-api`, treated as
   the front page `/ce-api/`), it strips the prefix from the `REQUEST_URI` and builds a **new
   request** via `$request->duplicate(...)` pointing at the equivalent backend path
   (`/ce-api/node/1` → `/node/1`, `/ce-api/` → `/`), preserving query string and headers.
2. On that new request it sets attributes `lupus_ce_renderer = TRUE` and
   `lupus_ce_renderer.content_format = <format>`, and header `X-Original-Path`.
3. It calls `$this->httpKernel->handle($new_request, …)` — i.e. it **re-enters the full HTTP kernel**
   for the real path.
4. Requests that do not match the prefix are passed straight through untouched.

The `lupus_ce_renderer = TRUE` attribute is what the separate **`lupus_ce_renderer`** module (a
hard dependency, "Lupus Custom Elements Renderer") keys on to render the page's main content as a
custom-elements JSON document instead of an HTML page. The **`custom_elements`** module supplies the
render-array → `<drupal-…>` element transformation. `lupus_decoupled` itself contributes the
transport/redirect/preview plumbing, not the serializer.

## Access control — enforced, not bypassed
Because step 3 re-runs the genuine route, **the target route's access checks execute normally**.
There is no separate "render an arbitrary path" code path: `/ce-api/admin/content`,
`/ce-api/node/{unpublished}`, `/ce-api/user/2/edit` all resolve to their real routes and return the
same 403/404 an anonymous or under-privileged caller would get on the HTML route. The middleware
changes only the URI and the desired response format.

Cloned routes in the bridge submodules (`_form`, `_contact`, `_webform`) are built by
`clone`-ing the core route and setting only `_controller` and `_format: custom_elements` — the
original `_permission` / `_entity_access` requirements are kept, so those CE variants inherit the
same access.

## Request/response shape
- **Request**: any GET/POST to `<backend>/ce-api/<path><?query>`. Authentication is Drupal's normal
  cookie session (CORS in `_cors` adds `supportsCredentials: TRUE` and the `authorization` header so
  a browser frontend can send credentials / a token). `?auth=1` on preview URLs is only a hint that
  tells a static frontend to make a credentialed API call — it is not itself a credential or token.
- **Response**: a `CustomElementsJsonResponse` (from `lupus_ce_renderer`) — a JSON object with the
  page's content rendered as custom elements plus `title`, `metatags`, `settings`, breadcrumb, etc.
  Submodules enrich it: `_block` adds a `blocks` key, `_schema_metatag` adds `metatags.jsonld`,
  `_ce_api`'s `CurrentUserResponseSubscriber` adds a `current_user` block (`id`, `name`, `roles`) —
  always the **current session's own** account, cached per user (runs at RESPONSE priority 6, after
  Dynamic Page Cache at 7, so per-user data is not shared across the cache).
- **Redirects**: core redirects on a ce-api request are converted to a ce-api JSON redirect for the
  frontend to follow (`LupusRedirectSubscriber` + lupus_ce_renderer's redirect subscriber). Frontend
  hosts are whitelisted through `trusted_redirect` via `hook_trusted_redirect_hosts_alter`.

## Discovering a node's API URL
With the `use api operation link` permission, node and webform admin listings show a **"View API
Output"** operation (`hook_entity_operation`) linking to the entity's URL rewritten onto the
`getApiBaseUrl()` base (backend host + `/ce-api`). Useful for eyeballing what the frontend receives.

## Menus and site info (separate endpoints)
- `_menu` enables `rest_menu_items` and exposes menu trees as JSON (e.g. `/api/menu_items/main`).
  On install it grants `restful get rest_menu_item` to anonymous + authenticated and allows all
  menus; the returned tree is still access-filtered per link by the menu tree service.
- `_site_info` (if enabled) exposes a REST resource at **`/api/site-info`** returning a config
  allow-list (`lupus_decoupled_site_info.settings:expose`, default `system.site` name/slogan/mail),
  gated by the `restful get lupus_decoupled_site_info` permission (cookie auth).
