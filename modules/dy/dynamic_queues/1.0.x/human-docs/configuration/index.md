# Configuration

Dynamic Queues has one setting to configure in the UI; the rest of its work happens
from code and from cron.

## Set the maximum queue limit

1. Log in as a user with the **Access administration pages** permission.
2. Go to `/admin/dynamic-queues/config`.
3. Set the **Maximum queue limit** — the number of items a single sub‑queue holds
   before the module creates the next one. For example, with a limit of `10` and 20
   items to enqueue, you'll end up with `content_queue_queue_0` holding 10 items and
   `content_queue_queue_1` holding the other 10.
4. Save.

## Enqueue items from your code

You feed items into the queues by calling the module's loader helper from your own
module (for example in a hook, an event subscriber, or a batch):

```php
\Drupal\dynamic_queues\Controller\DynamicQueueController::loadDatatoDynamicQueues(
  'content_queue',   // your queue "type" name
  $item              // the payload to store on the queue item
);
```

A typical producer loops over a data set:

```php
foreach ($data as $item) {
  \Drupal\dynamic_queues\Controller\DynamicQueueController::loadDatatoDynamicQueues('content_queue', $item);
}
```

The helper finds the highest existing sub‑queue for that type, checks whether it has
reached the maximum limit, and either reuses it or spins up the next numbered
sub‑queue.

## Process the queues

The bundled queue worker processes each dynamic sub‑queue. Let Drupal's **cron**
run it on schedule, or trigger it manually:

```bash
drush queue:run dynamic_queues:content_queue_queue_0
```

You can list all queues and their counts with `drush queue:list`.

## Inspect the dashboard

A dashboard at `/admin/dynamic-queues/lists` lists the items inside a queue. Add a
`?queue_lists_name=<full queue name>` parameter to filter to a specific sub‑queue,
and use the pager to page through a large listing.
