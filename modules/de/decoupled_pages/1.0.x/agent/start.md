<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Decoupled Pages (decoupled_pages) — agent index

Declare a Drupal route that serves an **empty page shell for a JavaScript SPA** to mount onto —
no controller needed. Add `_decoupled_page_main: <module>/<library>` to any route default and the
module validates it, swaps in its own controller, renders `<div id="decoupled-page-root">` in the
theme's main content region, and attaches the library. Package **Decoupled**. **No dependencies**
(core only). Core `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version **1.0.x** (installed
as legacy branch `8.x-1.x`, dev checkout). No permissions, no Drush, no config, no admin UI.

- **Defining SPA host routes — every route default/option, validation rules, the controller, data
  attributes, extra assets, extra paths** → [routing/decoupled-pages.md](routing/decoupled-pages.md)
- **Dynamic `data-*` attributes — `DataProviderInterface`, the `decoupled_pages_data_provider`
  service tag, `Dataset`, the route enhancer** → [api/data-provider.md](api/data-provider.md)
- **The `decoupled_pages_test` example submodule** is documented at
  `modules/de/decoupled_pages/modules/decoupled_pages_test/1.0.x/`.

## What it actually is (from source)

- **No routes, no permissions, no config, no plugin types of its own.** It works entirely by
  *altering other modules' routes* at cache-rebuild time.
- **`Routing\RoutingEventSubscriber`** (final, `@internal`) subscribes to `RoutingEvents::ALTER`.
  For every route whose defaults contain `_decoupled_page_main`, `alterDecoupledPageRoute()`
  validates the definition and sets `_controller` to `controller.decoupled_pages.main:serve`.
- **`Controller\DecoupledPage::serve()`** (`@internal`) builds a `#type => page` render array with
  a single `<div id="decoupled-page-root">` `html_tag`, copies the resolved dataset into
  `data-*` `#attributes`, and `#attached`es the resolved library list.
- **`Routing\DatasetRouteEnhancer`** (`route_enhancer` + `service_collector` for the
  `decoupled_pages_data_provider` tag) resolves the route's data provider and merges its
  `Dataset` into the request attributes before the controller runs.
- **`RouteDefinitionDataProvider`** (`DataProviderInterface`, `SERVICE_ID =
  decoupled_pages.route_definition_data_provider`) is the default provider: it returns the static
  `_decoupled_page_data` map, cached permanently. Custom providers implement `DataProviderInterface`
  and carry the `decoupled_pages_data_provider` tag.
- **`Dataset`** (`final`, extends `ArrayIterator`, `CacheableDependencyInterface`) carries the
  attribute map plus cacheability; `cachePermanent()`, `cacheVariable()`, `merge()`.
- **Exceptions** (`Exception\ImplementationException` → `RouteDefinitionException`,
  `DataProviderException`, all `LogicException`) signal a *developer* mistake in a route/provider
  definition — thrown at cache-rebuild or request time, not caused by end-user input.

## Route keys at a glance

- Default `_decoupled_page_main` (string `module/library`) — **marks the route + names the main SPA library**. Required.
- Default `_decoupled_page_data` (map string→string) — static `data-*` attributes on the root element.
- Default `_decoupled_page_data_provider` (service id) — custom dynamic data provider; defaults to the built-in one.
- Option `_decoupled_page_assets` (list of `module/library`) — extra libraries attached alongside the main one.
- Option `_decoupled_page_paths` (map name→path) — additional URLs (must be under the parent path) serving the same shell.
- You **must not** set `_controller`/`_form`; access is your route's own `requirements` (govern it — see the routing doc).

## Library

- `decoupled_pages.libraries.yml` ships one testing library `route_test` (`assets/js/route-test.js`)
  that logs "Your decoupled page route is working." to the console. Use it as `decoupled_pages/route_test`.
