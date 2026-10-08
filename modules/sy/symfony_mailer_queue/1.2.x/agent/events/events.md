<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events

The queue worker dispatches two events so other modules can log or react to delivery problems.
Both extend `Drupal\Component\EventDispatcher\Event` and expose a single readonly property
`SymfonyMailerQueueItem $item`.

| Event class | Dispatched when |
|---|---|
| `Drupal\symfony_mailer_queue\Event\EmailSendRequeueEvent` | A send failed but attempts remain; the item is about to be requeued (delayed / immediate / suspend). |
| `Drupal\symfony_mailer_queue\Event\EmailSendFailureEvent` | A send failed and `maximum_attempts` is now exceeded; the item is dropped (no further retry). |

There are no named event constants — subscribe to the class name directly.

`$event->item` is the `SymfonyMailerQueueItem` DTO (see `api/queue-mechanism.md`); read
`item->type`, `item->subType`, `item->addresses`, `item->config`, `item->langcode`, etc.

## Example subscriber

```php
namespace Drupal\my_module\EventSubscriber;

use Drupal\symfony_mailer_queue\Event\EmailSendFailureEvent;
use Drupal\symfony_mailer_queue\Event\EmailSendRequeueEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;
use Psr\Log\LoggerInterface;

class MailQueueSubscriber implements EventSubscriberInterface {

  public function __construct(protected LoggerInterface $logger) {}

  public static function getSubscribedEvents(): array {
    return [
      EmailSendRequeueEvent::class => 'onRequeue',
      EmailSendFailureEvent::class => 'onFailure',
    ];
  }

  public function onRequeue(EmailSendRequeueEvent $event): void {
    $this->logger->warning('Requeued @type email.', ['@type' => $event->item->type]);
  }

  public function onFailure(EmailSendFailureEvent $event): void {
    $this->logger->error('Gave up sending @type email.', ['@type' => $event->item->type]);
  }

}
```

Register it as a `event_subscriber`-tagged service (inject `logger.channel.*` for `$logger`).
