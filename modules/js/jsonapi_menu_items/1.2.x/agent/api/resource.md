<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The menu items JSON:API resource

## Endpoint

```
GET /%jsonapi%/menu_items/{menu}
```

`%jsonapi%` is the JSON:API base path (default `jsonapi`), `{menu}` is a **menu machine name**
(entity `menu`), e.g.:

```
GET /jsonapi/menu_items/main
GET /jsonapi/menu_items/admin
GET /jsonapi/menu_items/footer
```

Route name `jsonapi_menu_items.menu`, registered dynamically by
`Drupal\jsonapi_menu_items\Routing\Routes::routes()` and served by
`Drupal\jsonapi_menu_items\Resource\MenuItemsResource` (a `jsonapi_resources` `ResourceBase`).
Router access is `TRUE`, but every link is still access-checked individually (unauthorized links are
dropped). Only **enabled** links are returned (`MenuTreeParameters::onlyEnabledLinks()`), in menu
sort order.

## Response

A JSON:API document whose `data` is an array of resource objects (type `menu_link_content--<bundle>`
or `menu_link_config--menu_link_config`). Each object's `id` is the menu link **plugin id**, and its
`attributes` include:

| Attribute | Meaning |
|---|---|
| `title` | Link text. |
| `url` | Resolved URL string. |
| `route` | `{ name, parameters }` of the target route. |
| `weight` | Sort weight (int). |
| `enabled` / `expanded` | Booleans. |
| `menu_name` | The menu machine name. |
| `parent` | Parent link plugin id (empty for top level). |
| `provider` | Module that provides the link (e.g. `menu_link_content`, `system`). |
| `options` | Link options (attributes, target, …). |
| `description` | Link description/title attribute. |
| `meta` | Link metadata (e.g. `entity_id`). |
| (menu_link_content fields) | For content links, the entity's own fields are also included. |

The hierarchy is flattened into `data` (children follow their parents); use `parent` / `weight` to
rebuild the tree client-side.

## Filters (query parameters)

| Filter | Example | Effect |
|---|---|---|
| `min_depth` | `?filter[min_depth]=2` | Minimum depth relative to root. |
| `max_depth` | `?filter[max_depth]=2` | Maximum depth relative to root. |
| `parent` | `?filter[parent]=system.admin` | Load the subtree under this root plugin id (root excluded). |
| `parents` | `?filter[parents]=system.admin,system.admin_structure` | Expand only these parents. |
| `conditions[]` | `?filter[conditions][provider][value]=system` | Add a menu-tree query condition. `[operator]` defaults to `=`. |

Filters map to `MenuTreeParameters` in `applyFiltersToParams()`; using any filter adds the
`url.query_args:filter` cache context.

## Supported link types

- `menu_link_content` — user-created links (always).
- `menu_link_config` — config-defined links, **only when the `menu_link_config` module is enabled**
  (`getRouteResourceTypes()` adds it if the entity type exists).
- Extra fields from **Menu Item Extras** are included for content links.

## Example

```bash
# All enabled links in the main menu:
curl -s "$SITE/jsonapi/menu_items/main" | jq '.data[].attributes | {title, url, weight}'

# Only the top level:
curl -s "$SITE/jsonapi/menu_items/main?filter[max_depth]=1"
```

There is no write support — the resource is read-only (GET).
