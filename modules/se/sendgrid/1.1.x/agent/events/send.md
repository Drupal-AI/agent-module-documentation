<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pre-send event: `sendgrid.send`

Just before calling the API, `SendgridHandler::sendMail()` dispatches
`SendgridEvents::SEND` (`'sendgrid.send'`) with a `Drupal\sendgrid\Event\SendgridSendEvent`, then reads
the (possibly altered) email back via `$event->getEmail()`. This is the extension point for tweaking the
outgoing `SendGrid\Mail\Mail` — categories, custom args, IP pool, send-at, template ids, etc.

`SendgridSendEvent` getters:

| Method | Returns |
|---|---|
| `getEmail()` | `SendGrid\Mail\Mail` — the message object to mutate in place. |
| `getSendgrid()` | `\SendGrid` — the configured API client. |
| `getConfig()` | `ImmutableConfig` for `sendgrid.settings` (read options like `ip_pool_name`). |
| `getLogger()` | the `sendgrid` logger channel. |

There is no setter; mutate the object returned by `getEmail()` (the handler picks up your changes).

## Subscribe

```yaml
# my_module.services.yml
services:
  my_module.sendgrid_subscriber:
    class: Drupal\my_module\EventSubscriber\MySendgridSubscriber
    tags:
      - { name: event_subscriber }
```

```php
use Drupal\sendgrid\Event\SendgridEvents;
use Drupal\sendgrid\Event\SendgridSendEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MySendgridSubscriber implements EventSubscriberInterface {

  public static function getSubscribedEvents(): array {
    return [SendgridEvents::SEND => ['onSend']];
  }

  public function onSend(SendgridSendEvent $event): void {
    $email = $event->getEmail();
    $email->addCategory('transactional');
  }
}
```

## Built-in subscriber

The module ships `EventSubscriber\SendgridIpPoolNameSubscriber` (service `sendgrid.event_subscriber`),
which reads `ip_pool_name` from config on this event and would apply it to the email. Note in 1.1.0 the
`setIpPoolName()` call inside it is commented out, so the IP-pool option is effectively a no-op unless
you provide your own subscriber that sets it.
