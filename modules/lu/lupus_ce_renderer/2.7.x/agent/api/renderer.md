# Renderer, routes, request params and response envelope (API)

## Requesting custom-elements output

The renderer is not a dedicated endpoint — it is a **request format** applied to existing routes.
Three ways to turn it on (see also [../configure/settings.md](../configure/settings.md)):

- **Per request (recommended):** append `?_format=custom_elements` to any Drupal path, e.g.
  `GET /node/1?_format=custom_elements`.
- **Programmatically per request:** set `$request->attributes->set('lupus_ce_renderer', TRUE)` early
  in bootstrap (an HTTP middleware). This is what `lupus_decoupled_ce_api`'s `/ce-api/…` prefix does.
- **Per site (legacy):** `$settings['lupus_ce_renderer_enable'] = TRUE;` in `settings.php`.

Because the request rides the **original route**, all routing, param conversion, authentication and
**access checks run first, unchanged**. A forbidden/unpublished entity yields the same 403/404 it
would in HTML — the renderer only shapes the response body of an already-authorized request.

Two query params tune the output:

| Param | Values | Effect |
|---|---|---|
| `_content_format` | `markup` (default) \| `json` | How the component tree is serialized inside `content`. `markup` = custom-element markup string; `json` = nested data structure. |
| `_select` | `content` | Return **only** the content (no wrapping envelope). With `json` → a JSON body of the content; with `markup` → `text/plain` markup. Any other value → `LogicException`. |

Defaults also come from `$settings['lupus_ce_renderer_default_format']` and the request attribute
`lupus_ce_renderer.content_format`; the effective value is computed by
`ContentFormatCacheContext::getContentFormat()` (query param wins over attribute wins over settings).
The response varies by the `lupus_ce_renderer_content_format` cache context and
`url.query_args:_select`.

## Routes and controller

Controller: `Drupal\lupus_ce_renderer\Controller\CustomElementsController`.

| Route | Path | Method | Access | How it is created |
|---|---|---|---|---|
| `lupus_ce_renderer.node` | `/node` | `node()` | `_permission: 'access administration pages'` | Declared in `lupus_ce_renderer.routing.yml`; static "welcome" markup, a demo. |
| *(canonical)* `entity.<type>.canonical` | e.g. `/node/{node}` | `entityView($view_mode='full')` | original route's `_entity_access` | **Not cloned.** `CustomElementsControllerSubscriber` swaps the controller at runtime when `_route` matches `^entity\.([a-z_]*)\.canonical$` and the type exists. Route name + access unchanged. |
| `custom_elements.entity.node.preview` | `/node/preview/{node_preview}/{view_mode_id}` | `entityPreview()` | cloned from `entity.node.preview` (`_access_node_preview`) | `CustomElementsRouteSubscriber` clones, sets `_format`+`_controller` only. Caching disabled (`mergeCacheMaxAge(0)`). |
| `custom_elements.entity.node.revision` | `/node/{node}/revisions/{node_revision}/view` | `nodeViewRevision()` | cloned: `_entity_access: node_revision.view revision` | same clone mechanism. |
| `custom_elements.entity.node.latest_version` | `/node/{node}/latest` | `entityView()` | cloned from the content_moderation route | same; `_entity_view` default is unset so the CE controller runs. |

`entityView()` reads the entity from the current route match's raw parameters (first param =
entity type), generates the component tree with `custom_elements`' `CustomElementGeneratorTrait`,
adds a `<type>_view` cache tag, and returns a `CustomElement`. Any module can opt a custom route in
by adding `_format: custom_elements` (see README "Development") — access is whatever that route
declares.

## The renderer service — `lupus_ce_renderer.custom_elements_renderer`

`Drupal\lupus_ce_renderer\CustomElementsRenderer`. `CustomElementsViewSubscriber` (VIEW prio 100)
catches a controller result and calls `renderResponse($custom_element, $content_format, $select)`:

1. Adds `renderer.config['required_cache_contexts']` to the element.
2. Serializes via `renderCustomElement()` → `[content, BubbleableMetadata]`.
3. If `_select=content`, returns just the content (`CacheableJsonResponse` or `text/plain`
   `CacheableResponse`).
4. Otherwise builds the envelope: `title` (via `title_resolver`), `breadcrumbs` (from
   `system_breadcrumb_block`), `metatags` (via `lupus_ce_renderer.ce_metatags_generator`),
   `content_format`, `content`, `page_layout` (route option `_lupus_ce_renderer_layout` ?? `default`).
5. Applies overrides from the `lupus_ce_renderer_response_data` request attribute, then fires
   `hook_lupus_ce_renderer_response_alter` (see [../hooks/response-alter.md](../hooks/response-alter.md)).
6. Returns a `CustomElementsJsonResponse` with the bubbled cache metadata attached.

Late, uncacheable data is appended by `CustomElementsDynamicResponseSubscriber` (RESPONSE -10, after
Dynamic Page Cache): `getDynamicContent()` adds `local_tasks` and `messages`. `local_tasks` are
filtered by each link's `#access` (only allowed links emitted); reading `messages` triggers the
page-cache kill switch and drains the messenger.

If a `custom_elements`-format request hits a route that returns HTML/an array it can't render, the
view subscriber throws `NotAcceptableHttpException` (406). `CustomElementsFormatSubscriber` (RESPONSE
500) also blocks stray `HtmlResponse`/html-format responses while the renderer is active.

## Error and redirect handling

- `CustomElementsHttpExceptionSubscriber` (extends core `CustomPageExceptionHtmlSubscriber`, only
  handles the `custom_elements` format): renders 403/404/406 as CE responses. **406 on an admin
  route** (`_admin_route: TRUE`, or the admin theme would render it and admin≠default theme) issues a
  `TrustedRedirectResponse` to the *same* request URI so the Drupal backend serves it; non-admin 406
  gets a descriptive CE error page. The redirect target is the request's own URI — not an open
  redirect.
- `CustomElementsRedirectResponseSubscriber` (RESPONSE -11): converts any `RedirectResponse` under
  the renderer into an envelope `{redirect: {external, url, statusCode}, messages: […]}`. Messages
  are included only when `redirect_response.add_drupal_messages` is `TRUE`.

## Response identification

Every `CustomElementsJsonResponse::setData()` sets header `X-Drupal-CE` (const
`CustomElementsJsonResponse::CE_HEADER`) to `page` for normal responses or `redirect` when the data
has a `redirect` key — lets consumers tell CE-API responses apart from other JSON (e.g. REST).

## Metatags — `lupus_ce_renderer.ce_metatags_generator`

`CustomElementsMetatagsGenerator::getMetatags($route_match)` runs `metatag`'s
`metatag_generate_entity_all_tags()` for a `node` route param and returns `{meta:[…], link:[…]}`.
When `content_translation` is on it adds `rel=alternate` hreflang links, but **only for translations
the current user may `view`** (`$translation->access('view')` is checked per language). A legacy
`$settings['blacklisted_metatags']` map can suppress specific tag/attribute values.
