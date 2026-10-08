<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — the extractor service

The entire module is one service. Inject it and call one of four methods; each returns an
`EntityInterface` or `NULL`.

- **Service id:** `url_entity.extractor`
- **Interface (autowire type):** `Drupal\url_entity\UrlEntityExtractorInterface`
- **Class:** `Drupal\url_entity\UrlEntityExtractor`

```php
$extractor = \Drupal::service('url_entity.extractor');
// or inject '@url_entity.extractor' / the interface as a constructor argument.
```

## Methods

| Method | Returns | What it resolves |
|---|---|---|
| `getCurrentEntity(?Request $request = NULL): ?EntityInterface` | entity / `NULL` | The entity for the current request (or a `Request` you pass). |
| `getRefererEntity(?Request $request = NULL): ?EntityInterface` | entity / `NULL` | The entity for the URL in the `Referer` header. `NULL` if no referer or it doesn't match a route. |
| `getEntityByRoute(string $routeName, array $routeParameters = [], array $options = []): ?EntityInterface` | entity / `NULL` | The entity behind a named route + params. |
| `getEntityByUrl(Url $url): ?EntityInterface` | entity / `NULL` | The entity behind a `Drupal\Core\Url` object. |

## How resolution works

A URL/route is turned into a `Symfony\...\Request`, matched against Drupal's router
(`router.no_access_checks`), and the loaded route parameters are inspected:

1. If the matched route declares `_entity_form`, `_entity_access`, or is
   `entity.menu.add_link_form`, the corresponding route parameter is read.
2. Otherwise the first route attribute that is an `EntityInterface` is returned.

Because matching runs the router and its param converters, path aliases, language prefixes and
non-node entity types resolve correctly — unlike hand-rolled `explode('/', $path)` parsing.

## Behaviour to know

- Returns `NULL` (never throws) when the URL matches no route, the route has no entity, or a
  param converter fails — the four router/param exceptions are caught internally.
- Resolution is **not access-filtered**: matching uses the no-access-checks router, so the
  returned entity is not gated by the current user's view permission. Perform your own
  access check (`$entity->access('view', $account)`) before rendering or exposing it.
- `getRefererEntity()` matches only the *path* of the `Referer`; a foreign host is effectively
  ignored and simply resolves against the local router (or yields `NULL`). No outbound HTTP
  request is ever made.
