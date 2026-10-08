<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Current Route Block (current_route_block) — agent index

A single **block plugin** that displays the current page's route information: route name,
parameters, path pattern, and HTTP methods. Package `Development`. **No dependencies** beyond
Drupal core (`^10 || ^11`, PHP `>=8.1`). License GPL-2.0-or-later. Version 1.0.0.

- **The block plugin, what it renders, caching, and how to place it** →
  [blocks/current-route-block.md](blocks/current-route-block.md)

## What it actually is

- One plugin: `CurrentRouteBlock` (id **`current_route_block`**, admin label *"Current Route Info
  Block"*, category *"Development"*), in `src/Plugin/Block/CurrentRouteBlock.php`, extending core's
  `BlockBase` and implementing `ContainerFactoryPluginInterface` + `CacheableDependencyInterface`.
- **No** settings form (no `blockForm`/`blockSubmit` override), **no** permissions, **no** config
  schema, **no** routes, **no** `.module`/`.install`, **no** hooks, **no** Drush, **no** libraries,
  **no** submodules. The whole module is the one block class plus `.info.yml` and `composer.json`.

## Mechanism (from source)

- Injects the **`current_route_match`** service (`RouteMatchInterface`) via `create()`.
- `build()` reads `getRouteName()`, `getParameters()->all()`, `getRouteObject()->getPath()`, and
  `getRouteObject()->getMethods()`, then returns a `#theme => 'item_list'` render array titled
  *"Current Route Information"* with four items. Parameters, path, and methods are `json_encode`d;
  all four values are passed as `@`-prefixed (escaped) `t()` placeholders.
- Caching: `getCacheMaxAge()` returns **`0`** (never cached), `getCacheContexts()` and
  `getCacheTags()` return **`[]`**. So the block re-renders on every request.

## Operating it

- Enable the module, then add the *"Current Route Info Block"* to any region on
  `/admin/structure/block`. Visibility (route/role/etc.) is controlled by core's standard block
  configuration; the module adds none of its own. Remove it by deleting the block placement.
