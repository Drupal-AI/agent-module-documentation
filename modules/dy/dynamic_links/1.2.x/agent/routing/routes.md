<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dynamic route generation, controller & access

## Route registration (`src/Routing/DynamicLinkRoutes.php`)
`dynamic_links.routing.yml` declares only:
```
route_callbacks:
  - Drupal\dynamic_links\Routing\DynamicLinkRoutes::routes
```
`routes()` loads all `dynamic_link` entities and, for each **enabled** one (`$link->status()`), clones a template `Route` and sets its path to `$link->getPath()`. Each generated route:
- name: `dynamic_link.<id>` (`DynamicLinkRoutes::getRouteName($id)`, prefix constant `ROUTE_PREFIX = 'dynamic_link.'`).
- `_controller` = `DynamicLinkController::redirect`.
- `_custom_access` = `DynamicLinkController::access`.
- `parameters.dynamic_link` = `{type: 'entity:dynamic_link'}`, with the `dynamic_link` default set to the link id (so the controller receives the loaded entity).

Routes are rebuilt when a link is saved (`DynamicLinkForm::save()` calls `router.builder->rebuild()`). Disabled links produce no route.

## Access (`DynamicLinkController::access()`)
```
$available = $dynamic_link->getFirstAvailable($account);
return ($available['url'] ? AccessResult::allowed() : AccessResult::forbidden())
  ->addCacheableDependency($available['cacheability']);
```
Access to the dynamic link path is **allowed only if at least one target resolves and is accessible to the account**. The link therefore inherits its targets' access — it never exposes a destination the account could not otherwise reach. Cacheability of the access result carries the targets' access cacheability.

## Resolving the first available target (`DynamicLink::getFirstAvailable()`)
- If `getRoutes()` is non-empty: dispatches `DynamicLinkRoutesEvent`, then for each `route` builds `Url::fromRoute($route['name'], $route['parameters'], $route['options'])`.
- Else if `getRedirects()` is non-empty: dispatches `DynamicLinkRedirectsEvent`, then for each `redirect` builds `Url::fromUserInput($redirect)`.
- Each candidate is checked by `checkUrl()`: `$url->access($account, TRUE)` is added to the shared `CacheableMetadata`, and the **first** allowed URL is kept.
- Returns `['url' => Url|null, 'cacheability' => CacheableMetadata]`.

## Serving the link (`DynamicLinkController::redirect()`)
Gets `getFirstAvailable($currentUser)['url']`, generates the string URL (capturing cacheability via `toString(TRUE)`), then:
- **Redirect mode** (`useSubrequest()` FALSE): returns a `RedirectResponse` to the generated internal URL.
- **Subrequest mode** (`useSubrequest()` TRUE): builds a Symfony sub-request for the target path and dispatches it through `httpKernel->handle(..., HttpKernelInterface::SUB_REQUEST)`, so the target content renders while the browser URL stays on the dynamic link path.
  - For GET, request params merge query args + the target's route parameters + query options.
  - For non-GET (e.g. POST form submits), the original request body (`$request->request->all()`) is forwarded so form submissions reach the target.
  - The current session is attached if present; cacheable responses get the generated URL added as a cacheable dependency. The target route still runs through the full kernel (its own access and CSRF checks apply).

## Getting a link's URL programmatically (`DynamicLink::getDynamicUrl()`)
Returns `Url::fromRoute(DynamicLinkRoutes::getRouteName($id))` (or NULL if the entity has no id) — the canonical way for other code to link to a dynamic link's path.
