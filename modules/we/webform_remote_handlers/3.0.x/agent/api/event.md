# RestRemoteHandlerMessageEvent

The REST handler dispatches an event right before sending, letting other modules rewrite the
outgoing message. (The SOAP handler does **not** dispatch this event.)

- Class: `Drupal\webform_remote_handlers\Event\RestRemoteHandlerMessageEvent`
- Constant: `RestRemoteHandlerMessageEvent::EVENT_NAME` = `'webform_remote_handlers.rest_message_event'`
- Dispatched in `RestWebformHandler::postSave()` after `getMessage()` builds the token-replaced
  payload and before the cURL request.

Accessors:
- `getMessage(): string` — the payload about to be sent.
- `setMessage(string $message): void` — replace it.
- `getWebformSubmission(): WebformSubmission` — the submission being posted.

## Example subscriber

```php
// mymodule.services.yml
services:
  mymodule.rest_message_subscriber:
    class: Drupal\mymodule\EventSubscriber\RestMessageSubscriber
    tags: [{ name: event_subscriber }]
```

```php
use Drupal\webform_remote_handlers\Event\RestRemoteHandlerMessageEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class RestMessageSubscriber implements EventSubscriberInterface {

  public static function getSubscribedEvents(): array {
    return [RestRemoteHandlerMessageEvent::EVENT_NAME => 'onMessage'];
  }

  public function onMessage(RestRemoteHandlerMessageEvent $event): void {
    $data = json_decode($event->getMessage(), TRUE);
    $data['source'] = 'drupal';
    $event->setMessage(json_encode($data));
  }
}
```
