# Write a VBO Action plugin

VBO actions are core Action plugins discovered by VBO's own manager
(`plugin.manager.views_bulk_operations_action`). Extend
`Drupal\views_bulk_operations\Action\ViewsBulkOperationsActionBase` and use the core
`#[Action]` attribute. Put the class in `src/Plugin/Action/`.

```php
use Drupal\Core\Action\Attribute\Action;
use Drupal\Core\Entity\EntityInterface;
use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\views_bulk_operations\Action\ViewsBulkOperationsActionBase;

#[Action(
  id: 'my_publish_action',
  label: new TranslatableMarkup('Publish selected'),
  type: 'node',            // limit to an entity type; '' = all entity types
)]
final class MyPublishAction extends ViewsBulkOperationsActionBase {

  public function execute(?EntityInterface $entity = NULL) {
    $entity->setPublished()->save();
    return $this->t('Published @label', ['@label' => $entity->label()]);
  }

  // Optional: access gate; determines if the action is offered/allowed per row.
  public function access($object, ?AccountInterface $account = NULL, $return_as_object = FALSE) {
    return $object->access('update', $account, $return_as_object);
  }
}
```

## What the base gives you
- `$this->view` (`ViewExecutable`) — the processed view, full selected result rows.
- `$this->context` — view data + batch context (`sandbox`, `results`, `finished`...). Also
  `getContext()` / `getView()`.
- `executeMultiple(array $objects)` — override to process the whole chunk at once (default
  loops `execute()` per object).
- `static::finished($success, $results, $operations)` — set final message / return a
  `RedirectResponse`.

## Extra `#[Action]` / definition keys VBO honors
- `type` — entity type id the action applies to, or `''` for all.
- `confirm_form_route_name` — route to a custom confirm form.
- `requirements` — e.g. `{ _permission: '...' }`; if set, Actions Permissions skips it.

## Making it configurable
- Implement `PluginFormInterface` + `buildConfigurationForm()` → shows a per-run **configure**
  step; values land in `$this->configuration`.
- Implement `ViewsBulkOperationsPreconfigurationInterface` +
  `buildPreConfigurationForm($element, $values, $form_state)` → fixed settings set by the site
  builder in the View field settings.

See `modules/views_bulk_operations_example` for a class exercising all of the above, and
core-style examples in `src/Plugin/Action/EntityDeleteAction.php` / `CancelUserAction.php`.
