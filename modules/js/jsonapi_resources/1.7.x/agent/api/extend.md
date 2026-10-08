<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Declaring a custom JSON:API resource

Grounded in `src/Resource/ResourceBase.php`, `src/Unstable/Routing/ResourceRoutes.php`,
`jsonapi_resources.api.php`, and the `tests/modules/jsonapi_resources_test` examples.

## The two moving parts

1. A **route** in `mymodule.routing.yml` that uses a `_jsonapi_resource` default (not `_controller`).
2. A **resource processor class** that extends `ResourceBase` (or a subclass) and has a public `process()`.

## 1. The route

```yaml
# mymodule.routing.yml
mymodule.featured_content:
  # Path MUST begin with /%jsonapi% — the module rewrites %jsonapi% to the
  # JSON:API base path (default /jsonapi), giving /jsonapi/featured-content.
  path: '/%jsonapi%/featured-content'
  defaults:
    # A class FQN or a service id. Unlike _controller you cannot name a method;
    # the module always calls process().
    _jsonapi_resource: Drupal\mymodule\Resource\FeaturedNodes
    # Resource types this route may emit. Required UNLESS the class overrides
    # getRouteResourceTypes(). Must be a non-empty array of existing type names.
    _jsonapi_resource_types: ['node--article']
  requirements:
    # Any normal route requirement works: _permission, _entity_access,
    # _entity_create_access, _custom_access, _user_is_logged_in, _access.
    _permission: 'access content'
```

Rules enforced at route-build time by `ResourceRoutes::ensureResourceImplementationValid()`
(a `RoutingEvents::ALTER` subscriber, priority 6000). A violation throws and breaks the route cache:

- Path must start with `/%jsonapi%`.
- `_jsonapi_resource` must resolve to a class (or service) that is a subclass of `ResourceBase`.
- That class must declare a **public** `process()` method.
- The route must **not** also declare `_controller`.
- Either `_jsonapi_resource_types` is a non-empty array default, **or** the class overrides
  `getRouteResourceTypes()`. (Skipped for DELETE-only routes, which return 204.)

Auto-applied to every resource route (you cannot override the first two):
`_content_type_format: api_json`, `_format: api_json`, `_auth:` = all enabled providers,
the JSON:API route flag, and `methods: ['GET']` if you set none. Declare `methods: ['POST']`
(etc.) for write endpoints. Upcast route params (via `options.parameters`) become extra
`process()` arguments.

## 2. The resource class

`process(Request $request, …)` receives the request plus any upcast route parameters, and returns
a `ResourceResponse`. Build a `ResourceObjectData` and pass it to the inherited
`createJsonapiResponse()` — JSON:API normalizes the rest.

```php
<?php
namespace Drupal\mymodule\Resource;

use Drupal\Core\Cache\CacheableMetadata;
use Drupal\jsonapi\ResourceResponse;
use Drupal\jsonapi_resources\Resource\EntityQueryResourceBase;
use Drupal\node\NodeInterface;
use Symfony\Component\HttpFoundation\Request;

class FeaturedNodes extends EntityQueryResourceBase {

  public function process(Request $request, array $resource_types): ResourceResponse {
    $cacheability = new CacheableMetadata();
    // getEntityQuery(), getPaginatorForRequest() and loadResourceObjectDataFromEntityQuery()
    // are provided by EntityQueryResourceBase and honor JSON:API filter/sort/page params.
    $query = $this->getEntityQuery('node')
      ->accessCheck(TRUE)
      ->condition('status', NodeInterface::PUBLISHED)
      ->condition('promote', 1);
    $paginator = $this->getPaginatorForRequest($request);
    $paginator->applyToQuery($query, $cacheability);

    $data = $this->loadResourceObjectDataFromEntityQuery($query, $cacheability);
    $links = $paginator->getPaginationLinks($query, $cacheability, TRUE);

    $response = $this->createJsonapiResponse($data, $request, 200, [], $links);
    $response->addCacheableDependency($cacheability);
    return $response;
  }
}
```

## Choosing a base class

- **`ResourceBase`** — any data source (config object, remote API, computed values). You build
  `ResourceObject`s yourself and typically override `getRouteResourceTypes()` to return an inline
  `new ResourceType(...)`. Inherited helpers: `getDocumentFromRequest()` (the JSON:API request body,
  for POST/PATCH), `createJsonapiResponse()`, `getRouteResourceTypes()`.
- **`EntityResourceBase`** — entity-oriented; adds `entityTypeManager`, per-entity access checking,
  and helpers to turn entities into resource objects. Use for single-entity or entity-creation routes.
- **`EntityQueryResourceBase`** — entity collections; adds `getEntityQuery()`,
  `getPaginatorForRequest()`, and `loadResourceObjectDataFromEntityQuery()` so JSON:API `filter`,
  `sort`, `include`, sparse fieldsets and pagination all keep working on your custom collection.

## Resource as a service (dependency injection)

Instead of a bare class, register the resource as a service and use its **service id** as the
`_jsonapi_resource` value; or implement `ContainerInjectionInterface::create()` on the class
(as `SiteInfo` does) to inject dependencies. The module setter-injects the resource-response
factory, document extractor, and resource-type repository automatically.

## POST / write example (shape)

For `methods: ['POST']`, read the client's document with `$this->getDocumentFromRequest($request)`,
validate against the declared `_jsonapi_resource_types`, create the entity, and return a 201 via
`createJsonapiResponse($data, $request, 201)`. See `tests/.../Resource/AddReminder.php` and
`AddComment.php` in the module source.

## Verify a route registered

```bash
drush php:eval '$r = \Drupal::service("router.route_provider")->getRouteByName("mymodule.featured_content");
print $r->getPath() . " -> " . $r->getDefault("_jsonapi_resource") . "\n";'
# expect: /jsonapi/featured-content -> Drupal\mymodule\Resource\FeaturedNodes
```

The `%jsonapi%` placeholder in the stored path has already been replaced with `/jsonapi` by the time
the route is built.
