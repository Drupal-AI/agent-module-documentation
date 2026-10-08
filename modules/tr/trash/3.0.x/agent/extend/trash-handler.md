# Add trash support to an entity type (trash handler)

Per-entity-type logic lives in a **trash handler**: a service implementing
`Drupal\trash\Handler\TrashHandlerInterface` (extend `DefaultTrashHandler`) tagged
`trash_handler` with the target `entity_type_id`. The `TrashHandlerConfigurator` collects
tagged services and `TrashManager::getHandler()` resolves them.

```yaml
# my_module.services.yml
services:
  Drupal\my_module\Trash\MyThingTrashHandler:
    autowire: true
    tags:
      - { name: trash_handler, entity_type_id: my_thing }
```

```php
namespace Drupal\my_module\Trash;

use Drupal\Core\Entity\EntityInterface;
use Drupal\trash\Handler\DefaultTrashHandler;

class MyThingTrashHandler extends DefaultTrashHandler {
  public function preTrashDelete(EntityInterface $entity): void { /* cleanup before soft-delete */ }
  public function postTrashDelete(EntityInterface $entity): void {}
  public function validateRestore(EntityInterface $entity): void { /* throw UnrestorableEntityException */ }
  public function preTrashRestore(EntityInterface $entity): void {}
  public function postTrashRestore(EntityInterface $entity, int|string $deleted_timestamp): void {}
}
```

Interface methods: `preTrashDelete`, `postTrashDelete`, `validateRestore`,
`preTrashRestore`, `postTrashRestore`, plus `deleteFormAlter` / `restoreFormAlter` /
`purgeFormAlter` to add messaging to those confirmation forms. Throw
`Drupal\trash\Exception\UnrestorableEntityException` from `validateRestore`/`preTrashRestore`
to block a restore (e.g. a conflicting unique value or path alias). Core ships handlers for
node, taxonomy_term, menu_link_content, file, path_alias and redirect as reference examples
(`src/Hook/TrashHandler/`).
