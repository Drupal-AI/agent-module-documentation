<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON:API Menu items — agent index

Exposes each menu's link tree as a JSON:API resource at **`/%jsonapi%/menu_items/{menu}`**
(e.g. `/jsonapi/menu_items/main`). Read-only. Depends on `menu_link_content` + `jsonapi_resources`.
No config, permissions, schema, services, or Drush — just the resource and its query filters.

- **The resource: URL, response fields, filters, menu_link_config / Menu Item Extras support** →
  [api/resource.md](api/resource.md)

Key facts:
- Route `jsonapi_menu_items.menu`, path `/%jsonapi%/menu_items/{menu}` (`{menu}` = menu machine name).
  Registered via `route_callbacks` (`Routes::routes`), backed by `MenuItemsResource` (jsonapi_resources).
- Returns only **enabled**, access-checked links, in menu sort order.
- Filters (query): `filter[min_depth]`, `filter[max_depth]`, `filter[parent]` (root plugin id),
  `filter[parents]` (comma-separated), `filter[conditions][<field>][value|operator]`.
- Each item's attributes: `title`, `url`, `route{name,parameters}`, `weight`, `enabled`, `expanded`,
  `menu_name`, `parent`, `provider`, `options`, `description`, `meta` (+ `menu_link_content` fields).
- Submodule `jsonapi_menu_items_hypermedia` adds `menu_items` links to the `/jsonapi` root
  (needs `jsonapi_hypermedia`). Its docs:
  [modules/jsonapi_menu_items_hypermedia/1.2.x](../../modules/jsonapi_menu_items_hypermedia/1.2.x/agent/start.md).
