<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# drupal_js_path — routes, controller, hook, and JS helpers

Everything the module does. Source: `drupal_js_path.routing.yml`,
`src/Controller/DrupalJsPath.php`, `src/Hook/DrupalJsPathHooks.php`, `drupal_js_path.module`,
`drupal_js_path.services.yml`, `drupal_js_path.libraries.yml`, `js/drupal_js_path.js`.

## Install / enable

`composer require drupal/drupal_js_path` then enable (`drush en drupal_js_path`). No configuration
step — there is no settings form and no config to export. Once enabled, the library is attached to
**every** page automatically (see the hook), so `Drupal.alias` / `Drupal.path` are available in any
page's JS.

## Routes (`drupal_js_path.routing.yml`)

Both are `_permission: 'access content'` and both take the route machine name as the `{route}` path
slug. Titles are both `Drupal Js Path`.

| Route id | Path | Controller method | Returns |
|---|---|---|---|
| `drupal.js.alias` | `/find/alias/{route}` | `DrupalJsPath::fetchAliasByRoute` | the route's generated (alias-aware) URL |
| `drupal.js.path` | `/find/path/{route}` | `DrupalJsPath::fetchPathByRoute` | the route's internal system path (`/node/1`) |

The JS calls these with POST, but the routing declares no `methods:` restriction.

## Controller (`src/Controller/DrupalJsPath.php`)

`ControllerBase implements ContainerInjectionInterface`. `create()` injects `router.route_provider`
(`RouteProviderInterface`), `request_stack` (`RequestStack`), `url_generator`
(`UrlGeneratorInterface`).

Both methods do the same three steps:

1. Read caller-supplied POST body: `$params = $request->request->get('params') ?? []` and
   `$options = $request->request->get('options') ?? []`.
2. Guard: only proceed `if (!empty($this->routeProvider->getRoutesByNames([$route])))` — i.e. the
   route must exist. (This existence check does **not** run route access checks.)
3. Generate and return JSON:
   - `fetchAliasByRoute`: `$url = $this->urlGenerator->generateFromRoute($route, $params, $options)`
     → `new JsonResponse(['path' => $url])`.
   - `fetchPathByRoute`: `$url = '/' . Url::fromRoute($route, $params, $options)->getInternalPath()`
     → `new JsonResponse(['path' => $url])`.

Any thrown `\Exception` (unknown route, missing required route parameter, bad option) is caught and
returned as `new JsonResponse(['message' => $e->getMessage(), 'path' => NULL])`. Response
content-type is JSON (safe for the returned string; escaping/rendering of the value is the
consuming code's responsibility).

## Hook class (`src/Hook/DrupalJsPathHooks.php`)

Registered in `drupal_js_path.services.yml` (`autowire: true`); `drupal_js_path.module` keeps
`#[LegacyHook]` procedural shims that delegate to it.

- `#[Hook('page_attachments_alter')] pageAttachmentsAlter(array &$page)` — unconditionally does
  `$page['#attached']['library'][] = 'drupal_js_path/drupalJsPath';` so the helpers load on every
  page (front-end and admin, all users who can render a page).
- `#[Hook('help')] help($route_name, $route_match)` — returns the About text on
  `help.page.drupal_js_path`.

## Library (`drupal_js_path.libraries.yml`)

`drupalJsPath`: `js/drupal_js_path.js`, dependencies `core/drupal`, `core/jquery`, `core/once`.

## JS helpers (`js/drupal_js_path.js`)

`Drupal.behaviors.drupalJsPath.attach` runs once per page (`once('drupalJsPath', 'html', context)`)
and defines two globals:

```
Drupal.alias(route = '', routeParams = {}, routeOptions = {})
Drupal.path(route = '', routeParams = {}, routeOptions = {})
```

Each issues a **synchronous** (`async: false`) jQuery `$.ajax` POST to
`Drupal.url('find/alias/') + encodeURIComponent(route)` (resp. `find/path/`) with
`data: {params: routeParams, options: routeOptions}`, `dataType: 'json'`, and **returns the whole
decoded response object** (not just the string). If the response has a `message` key it is
`console.log`-ged. So typical use reads `.path`:

```js
var url = Drupal.alias('entity.node.canonical', { node: 1 }).path;   // e.g. "/my-alias"
var sys = Drupal.path('entity.node.canonical',  { node: 1 }).path;   // "/node/1"
```

Notes for consumers:

- `routeParams` are the route's parameters; `routeOptions` are core URL options (`query`,
  `fragment`, `absolute`, `language`, …).
- The calls are blocking (`async:false`) — each helper invocation is a round-trip to the server.
- On failure the returned object is `{message: '<reason>', path: null}`; check `.path` before use.
