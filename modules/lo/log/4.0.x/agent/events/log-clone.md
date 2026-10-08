<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `log_clone` event

`Drupal\log\Event\LogEvent` (extends `Symfony\Component\EventDispatcher\Event`, aliased as
`Drupal\Component\EventDispatcher\Event`) is dispatched by the clone action's confirm form
(`LogCloneActionForm`) once for **each cloned log**, *before* it is saved. Subscribe to
adjust or supplement the duplicate.

- Event name constant: `LogEvent::CLONE` = `'log_clone'`.
- Property: `public LogInterface $log` — the cloned (not-yet-saved) log. The form saves
  `$event->log` after dispatch, so mutations in your subscriber persist.

The clone form has already set the new timestamp, set the current user as owner, and
written a "Cloned from …" revision-log message before dispatching.

```php
use Drupal\log\Event\LogEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MyLogCloneSubscriber implements EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [LogEvent::CLONE => 'onClone'];
  }
  public function onClone(LogEvent $event): void {
    // e.g. copy or clear a custom field on the clone.
    $event->log->set('my_field', NULL);
  }
}
```

Register the subscriber as a service tagged `event_subscriber`. No other events are
defined by this module.
