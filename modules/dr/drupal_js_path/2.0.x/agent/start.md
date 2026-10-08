<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drupal Path in JS (drupal_js_path) — agent index

Exposes Drupal's server-side route/URL generation to client-side JavaScript. Attaches a library on
every page that defines two globals — `Drupal.alias(route, params, options)` (aliased URL) and
`Drupal.path(route, params, options)` (internal system path) — each of which POSTs a route machine
name to a controller endpoint and returns the generated URL as JSON. Package `Javascript`. No
dependencies beyond core. Core requirement `^8 || ^9 || ^10 || ^11 || ^12`. License
GPL-2.0-or-later. Version 2.0.0 (dir 2.0.x).

- **The two routes, the controller, the hook, and the JS helpers (inputs/outputs, how to consume)** →
  [api/js-path.md](api/js-path.md)

## What it actually is

- **No** config UI, config objects, config schema, permissions, plugins, entities, services of its
  own (beyond the hook class), Drush, or `.install`. It is entirely: 2 routes + 1 controller +
  1 hook class + 1 JS library.
- Two routes (`drupal_js_path.routing.yml`), both `_permission: 'access content'`:
  - `drupal.js.alias` → `POST /find/alias/{route}` → `DrupalJsPath::fetchAliasByRoute()`.
  - `drupal.js.path` → `POST /find/path/{route}` → `DrupalJsPath::fetchPathByRoute()`.
- Controller `src/Controller/DrupalJsPath.php` (`ControllerBase`, `ContainerInjectionInterface`),
  injecting `router.route_provider`, `request_stack`, `url_generator`.
- Hook class `src/Hook/DrupalJsPathHooks.php` (registered autowired in
  `drupal_js_path.services.yml`; legacy shims in `drupal_js_path.module`):
  - `#[Hook('page_attachments_alter')]` attaches library `drupal_js_path/drupalJsPath` on **every**
    page.
  - `#[Hook('help')]` provides the `help.page.drupal_js_path` text.
- Library `drupalJsPath` (`drupal_js_path.libraries.yml`) loads `js/drupal_js_path.js` and depends
  on `core/drupal`, `core/jquery`, `core/once`.

## Mechanism (from source)

- JS `Drupal.behaviors.drupalJsPath` (`js/drupal_js_path.js`) defines `Drupal.alias` and
  `Drupal.path`. Each does a **synchronous** (`async:false`) jQuery `$.ajax` POST to
  `Drupal.url('find/alias/') + encodeURIComponent(route)` (resp. `find/path/`) with
  `data: {params: routeParams, options: routeOptions}`, `dataType: json`, and returns the decoded
  response object. If the response has a `message`, it is `console.log`-ged.
- `fetchAliasByRoute($route)`: reads POST `params`/`options` from the request, and **if**
  `routeProvider->getRoutesByNames([$route])` is non-empty, returns
  `JsonResponse(['path' => urlGenerator->generateFromRoute($route, $params, $options)])` (the
  alias-aware URL). On any exception → `JsonResponse(['message' => $e->getMessage(), 'path' => NULL])`.
- `fetchPathByRoute($route)`: same guard, returns `'/' . Url::fromRoute($route, $params, $options)->getInternalPath()`
  (the internal system path, e.g. `/node/1`).
- The `{route}` slug is the route **machine name**; `params`/`options` map to core URL generation's
  route parameters and options (`query`, `fragment`, `absolute`, …).

See [api/js-path.md](api/js-path.md) for the request/response shape and consumption examples.
