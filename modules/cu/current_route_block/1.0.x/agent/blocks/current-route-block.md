<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Current Route Info Block

`src/Plugin/Block/CurrentRouteBlock.php` — the module's only class. Block plugin id
**`current_route_block`**, admin label *"Current Route Info Block"*, category *"Development"*.
Extends `Drupal\Core\Block\BlockBase`; implements `ContainerFactoryPluginInterface` and
`CacheableDependencyInterface`.

## Install & place

1. Enable: `drush en current_route_block -y` (no dependencies to pull in).
2. Go to **Structure → Block layout** (`/admin/structure/block`), pick a region, choose
   *"Current Route Info Block"*, and save. There is **no module-specific configuration** — only
   core's block settings (label display, visibility by route/role/content type, etc.).
3. Visit any page: the block prints that page's route facts. Remove it by deleting the placement;
   the module leaves no config behind.

## What it renders (`build()`)

Returns a render array:

- `#theme => 'item_list'`
- `#title => t('Current Route Information')`
- `#items` — four strings built from the injected **`current_route_match`** service:
  - `Route name: @route_name` — `getRouteName()` (e.g. `entity.node.canonical`).
  - `Route parameters: @parameters` — `json_encode(getParameters()->all())`. Parameters are the
    **upcast** values from the route match (entity objects, etc.), so JSON-encoding a complex
    parameter yields whatever that object serializes to.
  - `Route path: @path` — `json_encode(getRouteObject()->getPath())` (e.g. `"/node/{node}"`).
  - `Route methods: @methods` — `json_encode(getRouteObject()->getMethods())` (allowed HTTP
    methods, often `[]`/`null` when unrestricted).

All four are passed as `@`-prefixed placeholders to `t()`, so their values are HTML-escaped by
core's translation/placeholder handling before output.

## Dependency injection

`create()` pulls `current_route_match` from the container and passes it to the constructor, stored
as `$this->routeMatch` (`RouteMatchInterface`). No other services are used.

## Caching (`CacheableDependencyInterface`)

- `getCacheMaxAge()` → **`0`** — the block is effectively uncacheable and rebuilds every request,
  so it always reflects the current page's route.
- `getCacheContexts()` → **`[]`**.
- `getCacheTags()` → **`[]`**.

Because max-age is `0`, placing this block on a page contributes a `max-age:0` to that page's block
region rendering — a deliberate trade-off for a development/debugging block, not something to leave
on high-traffic production pages.

## Notes

- `getRouteObject()` can be `null` on some non-standard requests; the block calls `->getPath()` /
  `->getMethods()` on it directly, so it assumes a matched route object is present (true for normal
  page requests).
- Access to the information is bounded by **who can see the block** — control that with core block
  visibility rules and by not placing it in publicly visible regions on production.
