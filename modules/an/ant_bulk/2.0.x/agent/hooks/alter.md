# hook_ant_bulk_translation_items_alter

Documented in `ant_bulk.api.php`. Invoked by `TranslateForm::submitForm()` via
`ModuleHandler::invokeAll('ant_bulk_translation_items_alter', [&$nodes])`, right after the node list
is built and before the batch is queued. Lets other modules drop items from a bulk run.

```php
/**
 * Alter the nodes to be translated.
 *
 * @param array $nodes
 *   The items selected for translation, passed by reference.
 */
function mymodule_ant_bulk_translation_items_alter(array &$nodes) {
  foreach ($nodes as $key => $nid) {
    // Remove an item from the run.
    if (should_skip($nid)) {
      unset($nodes[$key]);
    }
  }
}
```

Notes:
- Fires on the **UI form path only** — the Drush command does not invoke it.
- In rc4 the array passed by `getNodes()` contains **node IDs** (nids), not loaded node entities.
  The example shipped in `ant_bulk.api.php` iterates the items as entities
  (`$node->field_not_to_translate->getString()`); if you copy that, load the node first
  (`Node::load($nid)`) before reading fields.
- Removing an entry (`unset()`) excludes that node from the batch; re-keying is not required.
