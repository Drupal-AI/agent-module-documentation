# EntityQueueHandler plugin

The plugin type that decides how a queue's subqueues behave.

- Manager: `plugin.manager.entityqueue.handler` (`EntityQueueHandlerManager`)
- Interface: `Drupal\entityqueue\EntityQueueHandlerInterface`; base:
  `EntityQueueHandlerBase`
- Annotation: `@EntityQueueHandler` (`Drupal\entityqueue\Annotation\EntityQueueHandler`) with
  `id`, `title`, `description`
- Namespace: `Plugin/EntityQueueHandler`

Built-in handlers: `simple` (single fixed subqueue), `multiple` (many editor-created
subqueues), and `smartqueue` (in the submodule — one auto subqueue per entity of a type).

Implement one:
```php
namespace Drupal\my_module\Plugin\EntityQueueHandler;

use Drupal\entityqueue\EntityQueueHandlerBase;

/**
 * @EntityQueueHandler(
 *   id = "my_handler",
 *   title = @Translation("My handler"),
 *   description = @Translation("Custom queue behaviour."),
 * )
 */
class MyHandler extends EntityQueueHandlerBase {
  public function supportsMultipleSubqueues() { return TRUE; }
  // Override lifecycle hooks as needed:
  // onQueuePostSave(), onQueuePreDelete(), getQueueListBuilderOperations(),
  // buildConfigurationForm()/submitConfigurationForm() for handler settings.
}
```
Key base methods: `defaultConfiguration()`, `buildConfigurationForm()`,
`getQueueListBuilderOperations()`, and the `onQueue*` lifecycle callbacks
(`onQueuePreSave/PostSave/PreDelete/PostDelete/PostLoad`).
