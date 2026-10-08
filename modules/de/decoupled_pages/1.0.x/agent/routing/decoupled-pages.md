<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Defining decoupled page (SPA host) routes

Source: `src/Routing/RoutingEventSubscriber.php`, `src/Controller/DecoupledPage.php`,
`decoupled_pages.services.yml`, `decoupled_pages.libraries.yml`.

## Install / enable

`ddev drush en decoupled_pages -y`. No dependencies, no config, no permissions, no UI. After enabling,
rebuild caches (`ddev drush cr`) whenever you add or change a decoupled route — the route rewrite happens
during route rebuild.

## Minimal route

In `your_module.routing.yml`:

```yaml
your_module.app:
  path: /app
  defaults:
    _decoupled_page_main: your_module/app_library   # marks the route + names the main library
  requirements:
    _permission: 'access content'                   # YOUR access rule — see "Access" below
```

- Do **not** declare `_controller` or `_form`. The subscriber sets `_controller` to
  `controller.decoupled_pages.main:serve` for you; declaring your own `_controller` throws
  `RouteDefinitionException`.
- `_decoupled_page_main` value is an asset library id `extension/library_name`. It must resolve via
  library discovery or `RouteDefinitionException` ("...library ... does not exist") is thrown.
- Define the library in `your_module.libraries.yml`; any module's library may be referenced.
- To smoke-test without your own library, use the module's shipped `decoupled_pages/route_test` library;
  a working route logs "Your decoupled page route is working." to the browser console.

## What gets rendered

`DecoupledPage::serve()` returns:

```php
[
  '#type' => 'page',
  'content' => [
    '#type' => 'html_tag', '#tag' => 'div',
    '#attributes' => ['id' => 'decoupled-page-root', 'data-...' => '...'],
  ],
  '#attached' => ['library' => [ <main>, ...<assets> ]],
]
```

i.e. an empty `<div id="decoupled-page-root">` placed in the active theme's main content region, with the
resolved libraries attached and the dataset copied to `data-*` attributes. Your JS mounts onto that div:
`document.getElementById('decoupled-page-root')`. Cacheability from the dataset is applied to the build
(`CacheableMetadata::createFromObject($dataset)->applyTo($build)`).

## Route defaults and options (all handled in `alterDecoupledPageRoute()`)

- **`_decoupled_page_main`** (default, string `module/library`) — required marker + main SPA library.
- **`_decoupled_page_assets`** (option, sequence of `module/library`) — extra libraries attached with the
  main one. Must be an array of strings and each must exist, else `RouteDefinitionException`. Internally the
  subscriber merges `[main, ...assets]` into the internal `decoupled_page_libraries` default consumed by the
  controller.
- **`_decoupled_page_data`** (default, map string→string) — static `data-*` attributes on the root element.
  Keys and values must all be strings. Each **key** must match `/^[a-z\-]+$/` and must not begin or end with
  a dash, else `RouteDefinitionException`. In JS the dasherized key is camel-cased by the browser:
  YAML `api-base-path` → `root.dataset.apiBasePath`.
- **`_decoupled_page_data_provider`** (default, service id string) — selects a dynamic data provider service;
  defaults to `decoupled_pages.route_definition_data_provider` (returns the static `_decoupled_page_data`).
  Must name a registered service, else `RouteDefinitionException`. See [../api/data-provider.md](../api/data-provider.md).
- **`_decoupled_page_paths`** (option, map name→path) — register additional URLs that serve the **same**
  shell. Keys and values must be strings; **every path must start with the parent route's path** or
  `RouteDefinitionException` is thrown. Each entry is cloned into a new route `"{route_name}.{key}"` copying
  the parent's defaults/requirements/options/host/schemes/methods/condition. Use for client-side deep links
  so users can link directly to in-app routes.

## HTTP methods

If the route declares no `methods`, the subscriber forces `['GET']`. Declare `methods` yourself to allow
others.

## Reserved internal defaults

You must NOT set `decoupled_page_libraries`, `decoupled_page_data`, or `decoupled_page_data_provider` as
route defaults — these are the subscriber's internal argument names and doing so throws
`RouteDefinitionException`.

## Access (important — the module does not gate access)

The module never sets access; whatever your route's `requirements` declare is the access rule. The upstream
docs' example uses `requirements: { _access: 'TRUE' }`, which makes the page reachable by everyone including
anonymous users. Use a real requirement (`_permission`, `_role`, `_custom_access`, `_entity_access`, …)
appropriate to the page. The rendered shell is empty; the SPA's actual data is fetched separately (e.g.
JSON:API/REST) and must be access-controlled on that layer independently of this route.

## Errors you may hit

All are `Drupal\decoupled_pages\Exception\*` (`LogicException` subclasses) signalling a mis-declared route,
surfaced at cache-rebuild or request time: `RouteDefinitionException` for the validation failures above.
They indicate a developer mistake, not runtime/user input.
