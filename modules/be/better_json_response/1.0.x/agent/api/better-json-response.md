<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BetterJsonResponse class + response subscriber

Install: `drush en better_json_response` (pulls in core `jsonapi`). No config needed to use the
class; the cache toggle is optional (see [../config/settings.md](../config/settings.md)).

## The response class — `src/BetterJsonResponse.php`

`class BetterJsonResponse extends Symfony\Component\HttpFoundation\JsonResponse implements
CacheableResponseInterface` (uses `CacheableResponseTrait`).

- Constructor `__construct(mixed $data = NULL, int $status = 200, array $headers = [], bool $json
  = FALSE)` stores `$data` in the protected `$originalData` before calling the parent.
- `getOriginalData(): mixed` — returns the un-serialized payload (the subscriber reads this).
- `setData(mixed $data = []): static` — overridden to also refresh `$originalData`.
- `isCacheabilityDefined(): bool` — TRUE once `cacheabilityMetadata` is set (via the trait's
  `addCacheableDependency()` / `getCacheableMetadata()`).

Use it from a controller exactly like `CacheableJsonResponse`. To embed entities in JSON:API
form, put `Drupal\jsonapi\ResourceResponse` objects into the data array (at any depth). Example
shape:

```php
use Drupal\better_json_response\BetterJsonResponse;
use Drupal\jsonapi\ResourceResponse;

$node = \Drupal::entityTypeManager()->getStorage('node')->load(1);
// Build a JSON:API ResourceResponse for the entity (e.g. via jsonapi's
// EntityResource / ResourceObject as your code already does).
$resource = new ResourceResponse(/* jsonapi document/data for $node */);

$response = new BetterJsonResponse([
  'meta' => ['generated_by' => 'my_module'],
  'node' => $resource,          // <-- becomes a decoded JSON:API document
]);
$response->addCacheableDependency($node); // optional cacheability
return $response;
```

The subscriber replaces the `node` value with the serialized JSON:API document. Scalars and
plain arrays pass through untouched.

## The subscriber — `src/EventSubscriber/SubResourceResponseSubscriber.php`

`class SubResourceResponseSubscriber extends Drupal\jsonapi\EventSubscriber\ResourceResponseSubscriber`.
Service `ogf_jsonapi.subscriber.sub_resource_response` (in `better_json_response.services.yml`),
arguments `@jsonapi.serializer`, `@config.factory`, tagged `event_subscriber`.

- `getSubscribedEvents()` → `KernelEvents::RESPONSE` (`onResponse`) at priority **129** — runs
  right after core's JSON:API `ResourceResponseSubscriber`. `hook_install()` also sets the
  module weight to 1.
- `onResponse(ResponseEvent $event)`:
  1. Returns immediately unless `$event->getResponse()` is a `BetterJsonResponse`, and unless
     `getOriginalData()` is an array.
  2. `$isCacheActivate = isCacheabilityDefined() && !config('deactivate_cache')`.
  3. Calls `transformToJsonApi()` on the data by reference.
  4. Rebuilds the response as `CacheableJsonResponse` when caching is active, else plain
     `JsonResponse`, preserving the original status code and `headers->all()`. When cacheable it
     adds the collected `CacheableMetadata` plus a cache tag `config:better_json_reponse.settings`
     (so the config toggle busts cached responses).
- `transformToJsonApi(array &$originalData, CacheableMetadata &$cacheableMetadata, Request
  $request)`: recurses into nested arrays; for each `ResourceResponse` item it calls inherited
  `renderResponseBody($request, $item, $this->serializer, 'api_json')` and `flattenResponse()`,
  merges the item's cacheable metadata, then replaces the item with
  `Json::decode($result->getContent())` (the JSON:API document as an associative array).

## Behavior notes

- Entity serialization goes through the standard `jsonapi.serializer`, so JSON:API's normal
  entity/field access control and cacheability apply to embedded entities — the module adds no
  bypass.
- Only array-shaped `originalData` is processed; a scalar/object payload is left as-is (still a
  valid JSON response, just not transformed).
- If no cacheability was defined on the response (`isCacheabilityDefined()` false), the result is
  a plain `JsonResponse` regardless of the config toggle.
