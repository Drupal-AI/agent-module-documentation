<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Add trash support to an entity type (trash handler)

Per-entity-type logic lives in a **trash handler**: a service implementing
`Drupal\trash\Handler\TrashHandlerInterface` (extend `DefaultTrashHandler`) tagged
`trash_handler` with the target `entity_type_id`. `TrashHandlerConfigurator` collects the
tagged services (setting the entity type ID, entity type manager and trash manager on each via
the `set*()` methods) and `TrashManager::getHandler($entity_type_id)` resolves them.

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
  public function preTrashDelete(EntityInterface $entity, array $langcodes): void { /* cleanup before soft-delete */ }
  public function postTrashDelete(EntityInterface $entity, array $langcodes): void {}
  public function validateRestore(EntityInterface $entity): void { /* throw UnrestorableEntityException */ }
  public function preTrashRestore(EntityInterface $entity, array $langcodes): void {}
  public function postTrashRestore(EntityInterface $entity, array $deleted_timestamps): void {}
}
```

## Interface (`TrashHandlerInterface`)

- `preTrashDelete($entity, array $langcodes)` / `postTrashDelete(...)` — around soft-delete.
- `validateRestore($entity)` / `preTrashRestore($entity, array $langcodes)` /
  `postTrashRestore($entity, array $deleted_timestamps)` — around restore.
- `deleteFormAlter(&$form, $form_state, bool $multiple = FALSE)`,
  `restoreFormAlter(&$form, $form_state)`, `purgeFormAlter(&$form, $form_state)` — add
  messaging/fields to those confirmation forms.
- `setEntityTypeId()`, `setEntityTypeManager()`, `setTrashManager()` — called by the
  configurator; `DefaultTrashHandler` provides them.

Throw `Drupal\trash\Exception\UnrestorableEntityException` from `validateRestore()` /
`preTrashRestore()` to block a restore (e.g. a conflicting unique value or path alias); the
restore form surfaces the message. Core ships reference handlers for node, taxonomy_term,
menu_link_content, file, path_alias and redirect in `src/Hook/TrashHandler/` (each uses PHP
attribute `#[Hook]`-style tagging in `trash.services.yml`). An entity type with no registered
handler falls back to `DefaultTrashHandler`.
