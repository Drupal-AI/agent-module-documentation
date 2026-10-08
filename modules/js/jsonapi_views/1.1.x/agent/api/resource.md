<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The JSON:API Views resource

## URL

```
/{jsonapi_base_path}/views/{viewId}/{displayId}
```

`{jsonapi_base_path}` is the container parameter `jsonapi.base_path` (default `/jsonapi`), so
typically:

```
/jsonapi/views/frontpage/page_1
```

`Routing\Routes::routes()` iterates `Views::getEnabledViews()` and adds a route
`jsonapi_views.<viewId>.<displayId>` for **every** display of each view whose base entity type
resolves to JSON:API resource types. Requirement `_access: 'TRUE'` — the real gate is the
view's own access plugin, checked in the resource.

## Query parameters

| Param | Purpose | Example |
|---|---|---|
| `views-filter[<filter_id>]` | set an exposed filter | `?views-filter[title]=hello` |
| `views-sort[sort_by]` | exposed sort field | `?views-sort[sort_by]=created` |
| `views-sort[sort_order]` | sort direction | `?views-sort[sort_order]=DESC` |
| `views-argument[]` | contextual filter(s), repeatable | `?views-argument[]=42&views-argument[]=news` |
| `page` | pager page (0-based internally) | `?page=2` |

`ViewsResource` merges `views-filter` + `views-sort` into the view's exposed input
(`setExposedInput`) and passes `views-argument` as the display arguments to
`$view->preview($display_id, $args)`.

## Response

A JSON:API collection document (built via `jsonapi_resources`' `EntityResourceBase`):

- `data`: the view's result rows as JSON:API entity resources (each row's `_entity`).
- `links`: `prev` / `next` pagination links when a pager is present (derived from the view's
  `PagerManager`).
- `meta.count`: total item count (`$pager->getTotalItems()`, or `count($view->result)` when
  there is no pager).

Cache contexts added: `url.query_args:page`, `:views-filter`, `:views-sort`,
`:views-argument`, plus the view's cache tags — so responses invalidate correctly.

## Errors

If the view's access check fails, or the display's `jsonapi_views` extender is present and not
exposed, the resource returns **HTTP 403** with an empty collection and cache tag
`config:views.view.<id>`.

## Discovering the URL

While editing a view, `hook_views_preview_info_alter()` adds a **"JSON:API Views"** row to the
preview panel with the exact URL for the current preview (current filters, sorts and arguments
encoded), so you can copy the working endpoint directly.
