# VBO services & programmatic execution

| Service id | Interface / class | Purpose |
|---|---|---|
| `plugin.manager.views_bulk_operations_action` | `ViewsBulkOperationsActionManager` | Extends core Action manager; discovers VBO actions, fires the alter event, filters by entity type. |
| `views_bulk_operations.processor` | `ViewsBulkOperationsActionProcessorInterface` | Initializes an action against a view + selection and executes it (immediate or per-batch chunk). |
| `views_bulk_operations.data` | `ViewsBulkOperationsViewDataInterface` | Resolves the entity/base data for a view display and enumerates result rows. |
| `views_bulk_operations.access` | `ViewsBulkOperationsAccess` | The `_views_bulk_operation_access` route access check. |

## Run an action on a view in code
The `views_bulk_operations.processor` service drives execution. Typical flow (mirrors
`ViewsBulkOperationsBatch` and the Drush command):

```php
$processor = \Drupal::service('views_bulk_operations.processor');
// $view_data describes the display, action id, configuration, batch, selection, exposed input.
$processor->initialize($view_data, $view);
$processor->setActionContext($context);
$processor->populateQueue($view_data);      // or a supplied list of row keys
$count = $processor->getPageList(0);
$processor->process();                        // executes the action on the queued rows
```

For batch runs use `Drupal\views_bulk_operations\ViewsBulkOperationsBatch::getList()` /
`::operation()` / `::finished()` — the same helpers the UI and Drush use. To reuse this in a
custom controller/form, the `Traits\ViewsBulkOperations*Trait` classes provide the tempstore,
bulk-form-key and form helpers.

## Get actions for an entity type
```php
$manager = \Drupal::service('plugin.manager.views_bulk_operations_action');
$defs = $manager->getDefinitions();           // pass ['nocache' => TRUE] to bypass cache
```
