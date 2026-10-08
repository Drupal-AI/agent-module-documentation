# Alter the available actions (event)

VBO does not ship a `*.api.php`; the main extension point (besides writing Action plugins) is
an event fired by the action manager while building the action list.

## Event
- Constant: `ViewsBulkOperationsActionManager::ALTER_ACTIONS_EVENT`
  = `'views_bulk_operations.action_definitions'`
- Object: `Drupal\views_bulk_operations\ActionAlterDefinitionsEvent`
  - `->definitions` — the array of action definitions (mutable).
  - `->alterParameters` — context passed to the alter (e.g. the view info).

## Subscribe
```php
use Drupal\views_bulk_operations\Service\ViewsBulkOperationsActionManager;
use Drupal\views_bulk_operations\ActionAlterDefinitionsEvent;

public static function getSubscribedEvents(): array {
  return [ViewsBulkOperationsActionManager::ALTER_ACTIONS_EVENT => 'alterActions'];
}

public function alterActions(ActionAlterDefinitionsEvent $event): void {
  // Add, remove, or tweak $event->definitions based on $event->alterParameters.
  unset($event->definitions['views_bulk_operations_delete_entity']);
}
```

VBO's own `ViewsBulkOperationsEventSubscriber` (service `views_bulk_operations.view_data_provider`)
and the `ViewEntityDataEvent` are additional internal events for supplying view row/entity data;
subscribe to `ViewEntityDataEvent` if you expose non-standard result data to VBO.
