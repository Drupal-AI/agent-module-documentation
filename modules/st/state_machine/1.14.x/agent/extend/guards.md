# Guards — restrict individual transitions

A guard is a tagged service that can veto a transition. **A transition is allowed unless at
least one guard returns FALSE.** Guards decide availability (permissions, a parent field, stock
levels, etc.).

Implement `Drupal\state_machine\Guard\GuardInterface`:
```php
namespace Drupal\mymodule\Guard;

use Drupal\Core\Entity\EntityInterface;
use Drupal\state_machine\Guard\GuardInterface;
use Drupal\state_machine\Plugin\Workflow\WorkflowInterface;
use Drupal\state_machine\Plugin\Workflow\WorkflowTransition;

class FulfillmentGuard implements GuardInterface {
  public function allowed(WorkflowTransition $transition, WorkflowInterface $workflow, EntityInterface $entity) {
    if ($transition->getId() === 'fulfill') {
      return $entity->hasItems();   // return FALSE to block
    }
    return TRUE;                    // TRUE (or NULL) = no opinion
  }
}
```

Register it, tagged with the **workflow group** so the `GuardFactory` only instantiates guards
relevant to that group — `mymodule.services.yml`:
```yaml
services:
  mymodule.fulfillment_guard:
    class: Drupal\mymodule\Guard\FulfillmentGuard
    tags:
      - { name: state_machine.guard, group: commerce_order }
```

- Guards run whenever allowed transitions are computed (`getAllowedTransitions()`,
  `getTransitions()`, `isTransitionAllowed()`) and before `applyTransition()`.
- Return TRUE only for the transitions you care about; return TRUE/NULL otherwise so you don't
  unintentionally block others.
