# Zoom webhooks & the webhook event

The module exposes one route to receive Zoom **Event Subscription** posts and re-broadcasts each one
as a Drupal event your module can subscribe to.

## The route

- Name: `zoomapi.webhooks`, path `/zoomapi-webhooks`, `methods: [POST]`, `options.no_cache: 'TRUE'`.
- Controller: `Drupal\zoomapi\Controller\ZoomApiWebhooksController::capture`.
- Access callback: `ZoomApiWebhooksController::authorize` (`_custom_access`). It admits a request
  only when Zoom's `x-zm-signature` header is present, an `event_secret_token` Key is configured, and
  the module's recomputed HMAC-SHA256 signature matches; otherwise it logs a notice to the
  `zoomapi` channel and returns forbidden. Point Zoom's "Event notification endpoint URL" at
  `https://your-site/zoomapi-webhooks`.

## What `capture()` does

1. Reads the raw request body; returns HTTP **400** JSON if empty.
2. `Json::decode()`s the body.
3. **Dispatches** `new ZoomApiWebhookEvent($data['event'], $data['payload'], $request)` on
   `ZoomApiEvents::WEBHOOK_POST` (`'zoomapi.webhook.post'`) — every event, including the initial
   URL-validation handshake, reaches your subscribers.
4. If the event is Zoom's **URL validation** (`$data['event'] === 'endpoint.url_validation'` with a
   `payload.plainToken`), it answers with `{ plainToken, encryptedToken }` where `encryptedToken` is
   `hash_hmac('sha256', plainToken, event_secret_token)` — this is what completes Zoom's endpoint
   validation.
5. Otherwise returns `200` JSON `{ success: true, message: 'Webhook payload captured!', data: [] }`.

## Subscribe to the event

Zoom events are delivered to your code through the standard Drupal event dispatcher.

`your_module.services.yml`:

```yaml
services:
  your_module.zoom_subscriber:
    class: Drupal\your_module\ZoomApiWebhookEventSubscriber
    tags:
      - { name: event_subscriber }
```

`src/ZoomApiWebhookEventSubscriber.php`:

```php
namespace Drupal\your_module;

use Drupal\zoomapi\Event\ZoomApiEvents;
use Drupal\zoomapi\Event\ZoomApiWebhookEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class ZoomApiWebhookEventSubscriber implements EventSubscriberInterface {

  public static function getSubscribedEvents(): array {
    return [ZoomApiEvents::WEBHOOK_POST => ['onWebhook']];
  }

  public function onWebhook(ZoomApiWebhookEvent $event): void {
    $name = $event->getEvent();       // Zoom event name, e.g. 'meeting.started'.
    $payload = $event->getPayload();  // Decoded $data['payload'] array.
    // $event->getRequest() gives the full Symfony Request if you need headers/raw body.
  }
}
```

## `ZoomApiWebhookEvent` API

`Drupal\zoomapi\Event\ZoomApiWebhookEvent` extends `Symfony\Contracts\EventDispatcher\Event`.

| Method | Returns | Value |
| --- | --- | --- |
| `getEvent()` | `string` | Zoom event name (`$data['event']`). |
| `getPayload()` | `array` | Zoom payload (`$data['payload']`). |
| `getRequest()` | `Symfony\Component\HttpFoundation\Request` | The original inbound request. |

The event only carries data; it does not itself change any Drupal state — acting on a Zoom event is
entirely up to your subscriber.
