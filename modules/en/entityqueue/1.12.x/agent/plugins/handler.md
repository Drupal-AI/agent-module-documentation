# EntityQueueHandler plugin

The plugin type that decides how a queue's subqueues behave.

- Manager: `plugin.manager.entityqueue.handler` (`EntityQueueHandlerManager`)
- Interface: `Drupal\entityqueue\EntityQueueHandlerInterface`; base:
  `EntityQueueHandlerBase`
- Attribute (preferred): `#[EntityQueueHandler(id, title, description, deriver)]`
  (`Drupal\entityqueue\Attribute\EntityQueueHandler`). The legacy
  `@EntityQueueHandler` annotation (`Drupal\entityqueue\Annotation\EntityQueueHandler`) is
  still supported — built-in handlers declare both.
- Namespace: `Plugin/EntityQueueHandler`

Built-in handlers: `simple` (single fixed subqueue), `multiple` (many editor-created
subqueues), and `smartqueue` (in the submodule — one auto subqueue per entity of a type).

Implement one:
```php
namespace Drupal\my_module\Plugin\EntityQueueHandler;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\entityqueue\Attribute\EntityQueueHandler;
use Drupal\entityqueue\EntityQueueHandlerBase;

#[EntityQueueHandler(
  id: 'my_handler',
  title: new TranslatableMarkup('My handler'),
  description: new TranslatableMarkup('Custom queue behaviour.'),
)]
class MyHandler extends EntityQueueHandlerBase {
  public function supportsMultipleSubqueues() { return TRUE; }
  public function hasAutomatedSubqueues() { return FALSE; }
  // Override lifecycle hooks as needed:
  // onQueuePostSave(), onQueuePreDelete(), getQueueListBuilderOperations(),
  // buildConfigurationForm()/submitConfigurationForm() for handler settings.
}
```
Key base methods: `defaultConfiguration()`, `buildConfigurationForm()`,
`supportsMultipleSubqueues()`, `hasAutomatedSubqueues()` (true = subqueues are created/
destroyed automatically, e.g. smartqueue — blocks manual add/delete),
`getQueueListBuilderOperations()`, and the `onQueue*` lifecycle callbacks
(`onQueuePreSave/PostSave/PreDelete/PostDelete/PostLoad`).
