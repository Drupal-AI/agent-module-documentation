# Messages, handlers, dispatching, deduplication, queue interception

## Create a message + handler

A **message** is any serializable class (no services/entities — use scalar identifiers).

```php
namespace Drupal\my_module;

final class MyMessage {
  public function __construct(public string $foo) {}
}
```

A **handler** is a class in the module's `src/Messenger/` directory carrying `#[AsMessageHandler]`,
with an `__invoke()` (or, alternatively, the attribute on any public method). Handlers are
**autowired** — inject dependencies via the constructor.

```php
namespace Drupal\my_module\Messenger;

use Symfony\Component\Messenger\Attribute\AsMessageHandler;

#[AsMessageHandler]
final class MyMessageHandler {
  public function __invoke(\Drupal\my_module\MyMessage $message): void {
    // Runs with full site privileges.
  }
}
```

Discovery: `SmMessageHandlerCompilerPass` (priority 200, runs before Symfony's attribute
autoconfiguration) recursively scans each module's `src/Messenger/` for classes with
`#[AsMessageHandler]` on the class or a public method, registers an autowired private service, tags it
`messenger.message_handler`, and derives the provider module from the FQCN. **Handlers are only
picked up on container rebuild (`drush cr`).** Handlers can also be declared explicitly in a module's
`*.services.yml` (useful for explicit DI).

## Dispatch a message

Default bus (simplest):

```php
/** @var \Symfony\Component\Messenger\MessageBusInterface $bus */
$bus = \Drupal::service('messenger.default_bus');
$bus->dispatch(new \Drupal\my_module\MyMessage(foo: 'bar'));
```

Whether this runs now or later depends on `sm.routing` (see
[../configure/settings.md](../configure/settings.md)): no route ⇒ synchronous; routed to an async
transport ⇒ stored and processed by the consume command ([console.md](console.md)).

A specific bus (when more than one is defined in `sm.buses`):

- **Injected**: depend on `@sm.bus.<name>` in your service definition (compiled DI only — not
  `\Drupal::service()` / controllers).
- **Routable bus**: inject `messenger.routable_message_bus`
  (`Symfony\Component\Messenger\RoutableMessageBus`, NOT autowired) and dispatch an `Envelope` with a
  `BusNameStamp('sm.bus.<name>')`. Without DI, alias the routable bus in your own `services.yml`
  (no stability promise on that service ID).

## Deduplication

Prevent the same logical message being processed twice by stamping a unique id at dispatch:

```php
use Symfony\Component\Messenger\Stamp\DeduplicateStamp;

$bus->dispatch(new MyMessage(foo: 'bar'), [new DeduplicateStamp('unique_message_id')]);
```

The `DeduplicateMiddleware` (added to every bus by `SmCompilerPass` when `symfony/lock` +
`DeduplicateMiddleware` exist) acquires a lock via `DrupalDeduplicatingLockStore` →
`KeyLockBackendAdapter` over Drupal's `lock.persistent` backend (name prefix `sm-`); a conflicting id
is skipped.

## Recoverable failures

To have a failed message retried (rather than sent straight toward the failure transport), throw a
`Symfony\Component\Messenger\Exception\RecoverableMessageHandlingException` from the handler. Retry
counts/backoff come from the transport's `retry_strategy` (default 3 retries) — see
[transports.md](transports.md).

## Replace the core Queue API with the bus (opt-in)

SM can intercept legacy Drupal `QueueInterface` items and route them through the messenger bus so
existing `@QueueWorker` plugins keep working unchanged. After enabling the module, add to
`settings.php`:

```php
$settings['queue_default'] = \Drupal\sm\QueueInterceptor\SmLegacyQueueFactory::class;
```

Mechanics:
- `SmLegacyQueueFactory::get($name)` returns `SmLegacyQueue`, whose `createItem($data)` wraps the item
  in a `SmLegacyDrupalQueueItem` (`data`, `queueName`) and dispatches it on the default bus.
- `SmLegacyQueue` holds nothing itself — `numberOfItems()` is `0`, `claimItem()` returns `FALSE`,
  `deleteItem()`/`releaseItem()` throw. Items no longer flow through Drupal cron / web-cron / Drush
  queue commands, so you **must** run the consume command (see [console.md](console.md)).
- `Drupal\sm\Messenger\SmLegacyDrupalQueueItemMessageHandler` (`#[AsMessageHandler]`) handles the
  message by calling `queueManager->createInstance($queueName)->processItem($data)` — the original
  `@QueueWorker::processItem()` logic.
- Existing `queue_service_*` / `queue_reliable_service_*` overrides in `settings.php` still win; remove
  them (or point them at this factory) to intercept those queues too.
