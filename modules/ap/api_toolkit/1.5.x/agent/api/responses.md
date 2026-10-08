<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Standardised JSON responses, errors & maintenance mode

All response classes live in `src/Response/` and extend Symfony's `JsonResponse`.

## Response envelopes

- **`Response\JsonResponse`** — `JsonResponse::createWithData(array $data, int $status = 200, array $headers = [])`
  wraps the payload as `{"data": …}`.
- **`Response\PagedJsonResponse`** — `PagedJsonResponse::createWithPager(array $data, \Drupal\Core\Pager\Pager $pager, int $status = 200, array $headers = [])`
  produces `{"pagination": {currentPage,totalPages,totalItems,limit}, "data": [...], "links": {...}}`.
  `links.prev`/`links.next` are generated with `Url::fromRoute('<current>', ['page' => …] + queryParams)`
  and included only when a previous/next page exists.
- **`Response\CacheableJsonResponse`** and **`Response\CacheablePagedJsonResponse`** — same shapes but
  extend core's cacheable JSON response so you can attach cacheability metadata
  (`$response->getCacheableMetadata()->addCacheableDependency(...)`). Use these whenever the endpoint is
  cacheable so Dynamic Page Cache works.
- **`Response\ApiErrorJsonResponse`** — constructed from a `ConstraintViolationListInterface`
  (`createWithViolations()`), renders `{"errors": [...]}`; `addViolation()/addViolations()` append more.

Example (from the examples submodule):

```php
$data = $this->normalizer->normalize($examplePage, 'my_format', ['cacheability' => $cacheability]);
$response = CacheableJsonResponse::createWithData($data);
$response->getCacheableMetadata()->addCacheableDependency($cacheability);
return $response;
```

## Automatic error responses — `EventSubscriber\ExceptionJsonSubscriber`

Registered as an event subscriber, priority **−40**, handled format `json`. On an exception it:

1. resolves the route name (matching the request itself if needed) and returns early unless the route is
   an "API Toolkit request" — i.e. the route's `_format` requirement is one of the strings in
   `api_toolkit.settings:route_formats` (`isApiToolkitRequest()`).
2. sets the locale to the current language (so violation messages are translated).
3. if the throwable is an `ApiValidationException`, uses its violations; otherwise wraps
   `getMessage()` into a one-item violation list.
4. builds `{"errors": [ {path?, code?, message}, … ]}`. Message templates are translated via
   `t()` + `TranslatorTrait::trans()` with the violation parameters. Status is the HTTP exception's
   status (else 400); a `CacheableJsonResponse` is returned when the exception is a
   `CacheableDependencyInterface`.

`getMessage()` returns the raw exception message only when `error_displayable()` (core's verbose-error
gate) is true; otherwise it returns a generic 404/403/401/4xx/500 message — no internal detail is leaked
when verbose errors are off.

**You must opt routes in** by adding their `_format` to `route_formats` (see
[../config/settings.md](../config/settings.md)); with the default empty `route_formats`, no route is
treated as an API Toolkit route and error JSON is not applied.

## JSON maintenance-mode responses — `EventSubscriber\MaintenanceModeSubscriber`

Subscribes to `KernelEvents::REQUEST` (priority 31) and `KernelEvents::EXCEPTION` (priority 1). For a
route whose `_format` is in `route_formats` AND whose `Accept` includes `application/json`, when
`maintenance_mode->applies()` it returns a JSON 503 `{"errors":[{"message": …}]}` built from
`system.maintenance:message` (with `@site` = `system.site:name`) instead of the HTML maintenance page.
