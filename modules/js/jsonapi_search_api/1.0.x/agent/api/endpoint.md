<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The index endpoint: routes, query params, response

## Routes

`Drupal\jsonapi_search_api\Routing\Routes::routes()` (registered as a `route_callbacks` in
`jsonapi_search_api.routing.yml`) iterates all **enabled** Search API indexes and adds, per
index:

- route name `jsonapi_search_api.index_<index_id>`
- path `/%jsonapi%/index/<index_id>` (the `%jsonapi%` prefix is the JSON:API base path,
  default `/jsonapi`)
- defaults: `_jsonapi_resource = IndexResource::class`, the index uuid, and the resource
  types derived from the index's datasource bundles.
- requirement `_access: 'TRUE'` (access is delegated to the index/query and entity access).

Disabled indexes get no route. Adding/enabling an index and rebuilding routes makes its
endpoint appear.

## Request → Search API query (`Resource\IndexResource::process()`)

The resource runs `$index->query()` with search id `jsonapi_search_api:<index>` and maps
JSON:API query parameters:

| Query param | Effect |
|---|---|
| `page[offset]`, `page[limit]` | `$query->range(offset, size)` (size must be > 0). |
| `sort=field,-other` | `$query->sort(path, direction)` per JSON:API `sort`. |
| `filter[fulltext]=terms` | `$query->keys('terms')` (parse mode `terms`). |
| `filter[...]` | Conditions via the JSON:API filter grammar (see below). |

Filters use a Search-API port of JSON:API's `Filter`/`EntityCondition`
(`Query\Filter`, `Query\EntityCondition`). Supported operators:
`=`, `<>`, `>`, `>=`, `<`, `<=`, `IN`, `NOT IN`, `BETWEEN`, `NOT BETWEEN`, `IS NULL`,
`IS NOT NULL`. **Not supported:** `STARTS_WITH`, `CONTAINS`, `ENDS_WITH` (Search API can't
express them). `IS NULL`/`IS NOT NULL` are translated to `= NULL` / `<> NULL`. Grouped
conditions (AND/OR `filter[...][group]` + `memberOf`) are supported.

Example:
```
GET /jsonapi/index/content?filter[fulltext]=climate&filter[status][value]=1&sort=-created&page[limit]=10
```

## Response

A JSON:API collection document of the result entities (each item's original object value),
with:
- `meta.count` = total result count (also `data` total count for pager),
- pager links `first`/`prev`/`next`/`last` computed from offset/size/total,
- cache contexts `url.query_args:page|filter|sort` and the index's cacheability
  (`search_api_list:<id>` tag).

Errors in the query raise a `CacheableBadRequestHttpException` (e.g. non-positive page size,
invalid filter).

## The meta extension event

Before responding, the resource dispatches `AddSearchMetaEvent`
(`Events::ADD_SEARCH_META = 'jsonapi_search_api.add_search_meta'`) with the query, result set
and current `meta`; subscribers may add keys (used by the facets submodule to add
`meta.facets`). See [../configure/expose-index.md](../configure/expose-index.md).
