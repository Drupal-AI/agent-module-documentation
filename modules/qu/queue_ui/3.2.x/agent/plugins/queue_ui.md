# `QueueUI` plugin type — inspect a custom queue backend

Queue UI defines one plugin type, **`queue_ui`**, managed by `QueueUIManager`
(`plugin.manager.queue_ui`, parent `default_plugin_manager`). It maps a queue **backend
class** to a UI/inspection implementation so the Inspect operation can list and act on
individual items. Core's database queue is supported out of the box by the shipped
`DatabaseQueue` plugin (`src/Plugin/QueueUI/DatabaseQueue.php`); other backends (Redis, SQS)
need their own plugin.

## Discovery

- Namespace: `Plugin/QueueUI`
- Interface: `Drupal\queue_ui\QueueUIInterface` (base class `QueueUIBase`)
- Attribute: `Drupal\queue_ui\Attribute\QueueUI` (also legacy Annotation `QueueUI`)
- Cache: `queue_ui_plugins`; alter hook: `hook_queue_ui_info_alter()`

`QueueUIManager::fromQueueName($queueName)` gets the queue from `@queue`, reads its class,
and returns the plugin whose `class_name` matches either the **short** or **full** class
name — otherwise `FALSE` (so no Inspect link appears).

## The attribute

```php
#[QueueUI(
  id: "my_custom_queue",
  class_name: "\\Drupal\\my_module\\Queue\\MyCustomQueue",
)]
```

`class_name` (required) is the backend class this plugin inspects — short (`"DatabaseQueue"`)
or fully-qualified. Optional `deriver` supported.

## Interface methods (`QueueUIInterface`)

| Method | Purpose |
|---|---|
| `getOperations()` | Operations offered for this backend |
| `getItems($queueName)` | List the items in the queue |
| `releaseItems($queueName)` | Release (reset lease on) all items — used by "Remove leases" and `drush queue:release` |
| `loadItem($item_id)` | Load one item's data for viewing |
| `releaseItem($item_id)` | Release the lease on one item |
| `deleteItem($item_id)` | Delete one item |

## Minimal implementation

```php
namespace Drupal\my_module\Plugin\QueueUI;

use Drupal\queue_ui\Attribute\QueueUI;
use Drupal\queue_ui\QueueUIBase;

#[QueueUI(id: "my_custom_queue", class_name: "MyCustomQueue")]
class MyCustomQueue extends QueueUIBase {
  // Implement the QueueUIInterface methods for your backend.
}
```
