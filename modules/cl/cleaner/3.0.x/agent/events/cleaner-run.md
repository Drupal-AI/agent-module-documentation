# Event: cleaner.run

Cleaner is built on the event dispatcher. `hook_cron` (`cleaner_cron()`) dispatches a single
event on the configured interval; all cleanup work lives in subscribers, so you can add,
replace, or reorder behavior without touching the module.

## The event

- Class: `Drupal\cleaner\Event\CleanerRunEvent` (extends `Drupal\Component\EventDispatcher\Event`).
- Name constant: `CleanerRunEvent::CLEANER_RUN` = `'cleaner.run'`.
- Payload: none (the event carries no data; subscribers read `cleaner.settings` themselves).

## Built-in subscribers

All are registered in `cleaner.services.yml`, tagged `event_subscriber`, and subscribe to
`cleaner.run` at priority `100`. Each re-checks its own config flag and logs to the `cleaner`
channel.

| Service id | Class | Method | Runs when |
|-----------|-------|--------|-----------|
| `cleaner.cache_clear_subscriber` | `CleanerCacheClearEventSubscriber` | `clearCaches` | `cleaner_clear_cache` |
| `cleaner.tables_clear_subscriber` | `CleanerTablesClearEventSubscriber` | `clearTables` | `cleaner_additional_tables` non-empty |
| `cleaner.mysql_optimization_subscriber` | `CleanerMysqlOptimizeEventSubscriber` | `optimizeMysql` | `cleaner_optimize_db` and driver is `mysql` |
| `cleaner.session_clear_subscriber` | `CleanerSessionClearEventSubscriber` | `clearSession` | `cleaner_clean_sessions` |
| `cleaner.watchdog_clear_subscriber` | `CleanerWatchdogClearEventSubscriber` | `clearWatchdog` | `cleaner_empty_watchdog` |

## Add your own subscriber

Subscribe to the same event name to run custom cleanup on Cleaner's schedule:

```php
// my_module.services.yml
// my_module.cleaner_subscriber:
//   class: Drupal\my_module\EventSubscriber\MyCleanupSubscriber
//   tags: [{ name: event_subscriber }]

namespace Drupal\my_module\EventSubscriber;

use Drupal\cleaner\Event\CleanerRunEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MyCleanupSubscriber implements EventSubscriberInterface {

  public static function getSubscribedEvents(): array {
    // Use a priority below 100 to run after the built-in subscribers.
    return [CleanerRunEvent::CLEANER_RUN => ['onCleanerRun', 50]];
  }

  public function onCleanerRun(CleanerRunEvent $event): void {
    // Your periodic cleanup here.
  }

}
```

You can also trigger a run yourself:

```php
\Drupal::service('event_dispatcher')
  ->dispatch(new CleanerRunEvent(), CleanerRunEvent::CLEANER_RUN);
```
