# Manipulating subqueues in code

Subqueues are `entity_subqueue` content entities (`Drupal\entityqueue\Entity\EntitySubqueue`,
interface `EntitySubqueueInterface`). Load one and mutate its ordered items, then save.

```php
$subqueue = \Drupal::entityTypeManager()
  ->getStorage('entity_subqueue')
  ->load('my_queue');           // For a 'simple' queue, subqueue id == queue id.

$subqueue->addItem($node);      // append an entity
$subqueue->removeItem($node);
$subqueue->hasItem($node);      // bool
$subqueue->reverseItems();
$subqueue->shuffleItems();
$subqueue->clearItems();
$subqueue->save();
```

Items are stored in the `items` entity-reference field
(`EntitySubqueueItemsFieldItemList`), so `$subqueue->get('items')` is the raw ordered list.

Find which queues an entity may go into:
`Drupal\entityqueue\EntityQueueRepositoryInterface::getAvailableQueuesForEntity($entity)`
(service `entityqueue.repository`).

Load queue config with the `entity_queue` storage; get its handler via
`$queue->getHandlerPlugin()`.
