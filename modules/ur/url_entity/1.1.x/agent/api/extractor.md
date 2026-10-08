<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — the extractor service

The core of the module is one service. Inject it and call one of four methods; each returns an
`EntityInterface` or `NULL`. (Templates can reach the same methods via the Twig filters — see
[twig/filters.md](../twig/filters.md).)

- **Service id:** `url_entity.extractor`
- **Interface (autowire type):** `Drupal\url_entity\UrlEntityExtractorInterface`
- **Class:** `Drupal\url_entity\UrlEntityExtractor`
- **Constructor args:** `@request_stack`, `@router.no_access_checks` (a `RequestMatcherInterface`).

```php
$extractor = \Drupal::service('url_entity.extractor');
// or inject '@url_entity.extractor' / the interface as a constructor argument.
```

## Methods

| Method | Returns | What it resolves |
|---|---|---|
| `getCurrentEntity(?Request $request = NULL): ?EntityInterface` | entity / `NULL` | The entity for the current request (or a `Request` you pass). |
| `getRefererEntity(?Request $request = NULL): ?EntityInterface` | entity / `NULL` | The entity for the URL in the `Referer` header (`HTTP_REFERER`). `NULL` if no referer or it doesn't match a route. |
| `getEntityByRoute(string $routeName, array $routeParameters = [], array $options = []): ?EntityInterface` | entity / `NULL` | The entity behind a named route + params (via `Url::fromRoute()`). |
| `getEntityByUrl(Url $url): ?EntityInterface` | entity / `NULL` | The entity behind a `Drupal\Core\Url` object (resolved absolute). |

## How resolution works

Each method funnels through `createRequest()` → `getEntityByRequest()`:

1. `createRequest($url)` builds an in-memory `Symfony\...\Request::create($url)` and matches it
   with `$this->requestMatcher->matchRequest($request)` (the `router.no_access_checks` matcher),
   adding the matched attributes onto the request.
2. `getEntityByRequest()` reads `_route_object` / `_route`; if the route declares `_entity_form`,
   `_entity_access`, or is `entity.menu.add_link_form`, the corresponding route parameter is read.
3. Otherwise it returns the first request attribute that is an `EntityInterface`.

Because matching runs the router and its param converters, path aliases, language prefixes and
non-node entity types resolve correctly — unlike hand-rolled `explode('/', $path)` parsing.

## Behaviour to know

- Returns `NULL` (never throws) when the URL matches no route, the route has no entity, or a
  param converter fails — `ParamNotConvertedException`, `ResourceNotFoundException`,
  `MethodNotAllowedException`, `AccessDeniedHttpException` and `NotFoundHttpException` are all
  caught inside `createRequest()` and converted to `NULL`.
- The service makes **no outbound HTTP request**: `Request::create()` builds a request object
  in memory and matches it only against the local router. A referer or URL pointing at a foreign
  host simply fails to match a local route and yields `NULL`.
- Resolution is **not access-filtered**: matching uses the no-access-checks router, so the
  returned entity is not gated by the current user's view permission. Perform your own access
  check (`$entity->access('view', $account)`) before rendering or exposing it.
- `getRefererEntity()` resolves the path from the client-supplied `Referer` header; a foreign
  host is effectively ignored and simply resolves against the local router (or yields `NULL`).
