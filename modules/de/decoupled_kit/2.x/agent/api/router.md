<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Router JSON:API resource

Class `Drupal\decoupled_kit\Resource\Router` (extends `jsonapi_resources` `EntityResourceBase`,
implements `ContainerInjectionInterface`). Route `decoupled_kit.router` in
`decoupled_kit.routing.yml`:

```yaml
decoupled_kit.router:
  path: '%jsonapi%/decoupled_kit/route'          # e.g. /jsonapi/decoupled_kit/route
  defaults:
    _jsonapi_resource: Drupal\decoupled_kit\Resource\Router
  requirements:
    _access: 'TRUE'
```

Method: GET (JSON:API resources are read). No `_jsonapi_resource_types` is declared; the resource
computes the type from the resolved entity in `getRouteResourceTypes()`.

## Request contract

- Query parameter **`current_path`** is required. The resource is constructed with
  `decoupled_kit->checkPath($request)` (canonicalized) then
  `getEntityFromPath($path)` — so the entity is resolved at construction time.
- Missing/empty `current_path` → `NotFoundHttpException` (from `checkPath`).

## Response (`process()`)

- If no entity resolved: returns `createJsonapiResponse(new ResourceObjectData([]), $request,
  HTTP_NOT_FOUND)` — a 404 with empty JSON:API `data`.
- Otherwise: `createIndividualDataFromEntity($this->entity)` → `createJsonapiResponse(...)`. The
  payload is the standard JSON:API individual document for the resolved entity (e.g. `node--article`).
  Field-level access and normalization are handled by JSON:API / `jsonapi_resources` as for any
  resource.
- Cacheability: adds cache context `url.query_args:current_page` (note: the varying query arg used
  in practice is `current_path`; the added context name is `current_page`).

## `getRouteResourceTypes(Route, string)`

Returns the resource type array `["$entity_type_id--$bundle"]` for the resolved entity via
`resourceTypeRepository->getByTypeName()`; throws `RouteDefinitionException` if that type does not
exist. Returns `[]` when no entity resolved.

## Operating it

```bash
curl 'https://SITE/jsonapi/decoupled_kit/route?current_path=/blog/my-post'
```

Returns the JSON:API document for whatever entity `/blog/my-post` routes to. The front end reads
`data.type` to decide how to render. `%jsonapi%` is the site's configured JSON:API base
(default `/jsonapi`).
