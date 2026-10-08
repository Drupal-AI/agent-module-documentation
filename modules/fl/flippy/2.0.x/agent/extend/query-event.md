# Alter the pager queries — `buildFlippyQuery` event

Before executing them, `FlippyPager::flippy_build_list()` dispatches a `FlippyEvent` on the event
name **`buildFlippyQuery`**, carrying the four entity queries (`first`, `prev`, `next`, `last`)
and the current node. Subscribe to it to add conditions (e.g. restrict to a taxonomy term, honour
an access rule, or change ordering) — the modified queries are what actually run.

```php
namespace Drupal\my_module\EventSubscriber;

use Drupal\flippy\FlippyEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class FlippyQuerySubscriber implements EventSubscriberInterface {

  public static function getSubscribedEvents(): array {
    return ['buildFlippyQuery' => 'onBuildQuery'];
  }

  public function onBuildQuery(FlippyEvent $event): void {
    $node = $event->getNode();
    $queries = $event->getQueries();      // ['first'=>Query,'prev'=>Query,'next'=>Query,'last'=>Query]
    foreach ($queries as $query) {
      // e.g. only page within the same category as the current node:
      $query->condition('field_category', $node->get('field_category')->target_id);
    }
    $event->setQueries($queries);         // write them back
  }
}
```

```yaml
# my_module.services.yml
services:
  my_module.flippy_query_subscriber:
    class: Drupal\my_module\EventSubscriber\FlippyQuerySubscriber
    tags:
      - { name: event_subscriber }
```

`FlippyEvent` (extends Symfony `Event`) API: `getQueries()`, `setQueries(array)`, `getNode()`.
Each query is a node `EntityQueryInterface` already constrained to published nodes of the same
type, current language, excluding the current node, with `node_access` tag and the sort applied.
The `random` query is built but not part of the event.
