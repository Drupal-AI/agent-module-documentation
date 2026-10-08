# Hooks & event — altering the JSON:API response

Two equivalent ways to modify a JSON:API response body; both receive the decoded array by
reference/return and the Symfony `Response`.

## Option A — the hook

Declared in `jsonapi_response_alter.api.php`:

```php
use Symfony\Component\HttpFoundation\Response;

/**
 * Implements hook_jsonapi_response_alter().
 */
function mymodule_jsonapi_response_alter(array &$jsonapi_response, Response $response) {
  // $jsonapi_response is the decoded JSON body (associative array).
  $jsonapi_response['meta']['generated'] = \Drupal::time()->getRequestTime();
  // unset($jsonapi_response['data'][0]['attributes']['internal_note']);
}
```

## Option B — the event

Subscribe to `Drupal\jsonapi_response_alter\Event\JsonApiResponseAlterEvent`:

```php
use Drupal\jsonapi_response_alter\Event\JsonApiResponseAlterEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MySubscriber implements EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [JsonApiResponseAlterEvent::class => 'onAlter'];
  }
  public function onAlter(JsonApiResponseAlterEvent $event): void {
    $event->jsonapiResponse['meta']['flag'] = TRUE; // public array property
    // $event->response is the Symfony Response object.
  }
}
```

The event object exposes public properties `jsonapiResponse` (the array) and `response`.

## Firing order & mechanics (`ResponseSubscriber::onResponse`)

1. Subscribes to `KernelEvents::RESPONSE`. Returns immediately unless there's a route object and it
   is a JSON:API route (`Routes::JSON_API_ROUTE_FLAG_KEY` default flag or
   `Routes::isJsonApiRequest($route->getDefaults())`).
2. `json_decode($response->getContent(), TRUE)`; if the result isn't an array, returns without
   changes.
3. Runs the **hook first** (`moduleHandler->alter('jsonapi_response', $jsonapi_response, $response)`),
   **then dispatches the event** with the (already hook-altered) array.
4. `$response->setContent(json_encode($event->jsonapiResponse))`.

So the hook and event both run, hook before event, and later implementations see earlier
implementations' changes.

## Important: this runs AFTER JSON:API access filtering

The subscriber operates on the **final serialized response**, i.e. after JSON:API has already
applied entity/field access control and normalization. Implications:

- You receive only data the requester was already allowed to see — good.
- **But you can add arbitrary keys/values, including data that JSON:API would have filtered out.**
  Nothing re-checks access on what you inject. If your implementation copies in field values,
  entity data, or secrets, you are responsible for access-checking them yourself — the module does
  not. Treat additions as bypassing JSON:API's access layer.
- Because it re-encodes the body but does not adjust cacheability metadata, ensure any
  request-varying additions carry appropriate cache contexts/tags on the underlying response.
