<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin UI Only — the request/response gate

All enforcement is in `Drupal\admin_ui_only\EventSubscriber` (`src/EventSubscriber.php`), a
`event_subscriber`-tagged service constructed with `@config.factory` and `@router.builder`. It
subscribes to three events (`getSubscribedEvents`):

| Event | Method | Purpose |
| --- | --- | --- |
| `KernelEvents::RESPONSE` | `onKernelRespond` | Enforce: turn a blocked HTML response into 403/404 |
| `RoutingEvents::ALTER` (prio 30) | `onAlterRoutes` | Flag allowed routes with `_admin_route` |
| `ConfigEvents::SAVE` | `onConfigSave` | Rebuild router / clear 4xx cache on settings change |

## Enforcement — `onKernelRespond`

Runs only on the **main** request (`$event->isMainRequest()`). It throws (blocks) only when **all**
of these hold:

1. `response->getStatusCode() === 200` — only successful pages are blocked; existing 403/404/redirect
   responses pass through unchanged.
2. `str_contains($response->headers->get('Content-Type') ?? '', 'text/html')` — only HTML responses.
   A missing Content-Type header (`?? ''`) or a non-HTML type (JSON, XML, images, downloads) is
   **not** blocked — this is deliberate so serialized API responses are served.
3. `deny($request)` returns TRUE.

If all hold: throw `NotFoundHttpException` when `admin_ui_only.settings:error_code === 404`, otherwise
`AccessDeniedHttpException` (403). The exception message names the route (for the 403 case, which
"has more information").

## The decision — `deny(Request $request)`

Returns TRUE (block) unless one of these makes it return FALSE (allow):

- `$request->getRequestFormat() !== 'html'` → **allow**. Non-HTML formats (e.g. `?_format=json`,
  JSON:API, GraphQL) are never blocked.
- The matched `Route` object (`_route_object` attribute) exists and has option `_admin_route` → **allow**.
- The front page: `return $request->getPathInfo() !== '/'` — so path `/` is **always allowed**,
  everything else is denied. (The recommended setup points `/` at `/user/login`.)

Note the gate does **not** grant access — it can only *reduce* a successful HTML page to a 403/404.
Drupal's own route access/permission checks still run first; a page the current user is not permitted
to see already returns 403 (not 200) and is unaffected by this module. Non-HTML representations of
the same content (JSON:API, REST, GraphQL) are intentionally left reachable, which is the module's
stated purpose (see `hook_help` / README: allow anonymous JSON:API/GraphQL, block HTML).

## The allow-list — `onAlterRoutes`

For each route name it sets `$route?->setOption('_admin_route', TRUE)` (the `?` no-ops if the route
does not exist), over two sources:

- Hardcoded `ADMIN_ROUTES` constant: `entity.user.cancel_form`, `entity.user.canonical`,
  `entity.user.contact_form`, `entity.user.edit_form`, `media.oembed_iframe`,
  `system.batch_page.html`, `user.edit`, `user.login`, `user.logout`, `user.logout.confirm`,
  `user.page`, `user.cancel_confirm`, `user.reset.login`, `user.reset`, `user.reset.form`,
  `user.well-known.change_password`, `user.register`.
- Every route name in `admin_ui_only.settings:routes`.

Because login/logout/password-reset are hardcoded here, an admin cannot lock the site's login flow
out of HTML by editing the settings `routes` list. Core admin routes already carry `_admin_route`, so
the whole `/admin` UI stays reachable.

## Cache/router coherency — `onConfigSave`

- `routes` changed → `routeBuilder->setRebuildNeeded()` so the new `_admin_route` flags apply.
- `error_code` changed → `Cache::invalidateTags(['4xx-response'])` so cached error responses reflect
  the new code.

## Other module code touching behavior

- `admin_ui_only_form_node_form_alter` + `_admin_ui_only_form_node_form_submit`
  (`admin_ui_only.module`) add a node-form submit handler that `setRedirect('system.admin_content')`
  — after saving a node the editor lands on the admin content list rather than the (now blocked)
  node canonical page. The redirect target is a fixed route name, not request-supplied.
- `admin_ui_only_install` / `_modules_installed` (`admin_ui_only.install`) set
  `node.settings:use_admin_theme = TRUE` so node forms render in the admin theme.
