<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Contextual Filter Referer (contextual_filter_referer) — agent index

Provides **two Views argument-default plugins** that resolve a contextual filter value from the
**referring page's URL** (the `Referer` request header) instead of the current URL, so context
survives Views' AJAX endpoint (`/views/ajax`). Package `Views`. Depends only on core **`views`**.
Core requirement `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.1 (dir `1.0.x`).
No routes, no permissions, no config schema, no Drush, no hooks, no install file.

- **The two plugins, their options, the two services, and how to wire them onto a View** →
  [plugins/argument-defaults.md](plugins/argument-defaults.md)

## What it actually is

- **`node_referer`** — *"Content ID from Referer"*
  (`src/Plugin/views/argument_default/RefererNode.php`, class `RefererNode`). Extends Views'
  `ArgumentDefaultPluginBase`. `getArgument()` reads the referer-derived route match and returns
  `$node->id()` when its `node` parameter is a `NodeInterface`. The referer analogue of core's
  *"Content ID from URL"*.
- **`referer_raw`** — *"Raw value from Referer URL"*
  (`src/Plugin/views/argument_default/RefererRaw.php`, class `RefererRaw`). Returns one path
  component of the referring URL. Two options (`defineOptions()`): `index` (1-based path-component
  selector, `range(1,10)`) and `use_alias` (resolve the path alias first). The referer analogue of
  core's *"Raw value from URL"*.
- Both implement `CacheableDependencyInterface` with `getCacheMaxAge() = Cache::PERMANENT` and
  `getCacheContexts() = ['url']`.

## Services (`contextual_filter_referer.services.yml`)

- **`contextual_filter_referer.referer_route_match`** → `Routing\RefererRouteMatch`
  (args `@request_stack`, `@router`). A `ResettableStackedRouteMatchInterface` whose
  `getCurrentRouteMatch()` reads the `Referer` header, strips scheme/host and query, builds a
  `Request` from the path, calls `$router->matchRequest()`, and returns the resulting route match.
  Consumed by `RefererNode`.
- **`contextual_filter_referer.referer_path`** → `RefererPathStack` (arg `@request_stack`).
  `getRefererPath()` reads the `Referer` header, strips the scheme+host and the `?query`, and
  returns the path. Consumed by `RefererRaw`.

## How you use it (no admin UI of its own)

Enable the module, edit a View's **contextual filter → Provide default value**, and choose
**Content ID from Referer** or **Raw value from Referer URL** just like the core URL-based options.
Details, config example, and the trust caveat around the client-supplied `Referer` header are in
[plugins/argument-defaults.md](plugins/argument-defaults.md).
