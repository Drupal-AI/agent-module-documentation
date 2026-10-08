# Post API — manual setup guide

**Post API** (`post_api`) is a **developer toolkit** for sending **outbound POST requests** from
Drupal to external endpoints, using Drupal's **Queue API** for reliable, asynchronous delivery.
Rather than posting to a third‑party API inline (and blocking the request, or losing the data if
the remote service is down), your code hands a payload to Post API's queue service; the queued
items are then processed later — typically on cron — and POSTed to the endpoint you specify.

A small admin UI lets you review and manually process the queue, and the module dispatches two
events during processing so your own code can react (for example, notifying Slack if a queue run
processed nothing). This is a module aimed at engineers building content‑sync and integration
features; it does not do anything on its own until your custom code feeds the queue.

> **Note on what this module is.** Post API sends requests *out* to endpoints you choose — it is
> not an inbound API that external callers post *to*. There is no public endpoint that accepts
> outside requests, so there is no inbound authentication to configure; you authenticate to the
> remote service from your own payload/headers when you build the queue item.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.
2. [Configuration](configuration/index.md) — the queue management UI, permissions, and where to
   keep credentials.

## Where it lives in the admin menu

The queue management UI is at **Configuration → Web Services → Post API → Queue**
(`/admin/config/post-api/queue`), where you can review the queue and process it manually.

## How to use it

Post API is driven from code. The typical pattern is to react to entity changes and add items to
the queue:

```php
/**
 * Implements hook_entity_update().
 */
function mymodule_entity_update(\Drupal\Core\Entity\EntityInterface $entity) {
  if ($entity->getEntityTypeId() === 'node' && $entity->bundle() === 'article') {
    $queue = \Drupal::service('post_api.add_to_queue');
    $data = [
      // Optional unique id, used when de-duplicating queue items.
      'uid' => 'article-' . $entity->id(),
      // Endpoint PATH only (no host) — the host comes from your configuration.
      'endpoint_path' => 'your-endpoint-path',
      // Your payload — build this from the entity's fields.
      'payload' => _mymodule_build_payload($entity),
    ];
    if (!empty($data['payload'])) {
      // Second argument: remove pre-existing items with the same uid first.
      $queue->addToQueue($data, TRUE);
    }
  }
}
```

Queued items are POSTed to the endpoint when the queue is processed — on the next **cron** run,
or manually from the queue UI. You can subscribe to the module's two events
(`post_api_queue_item_processed_event` and `post_api_queue_processing_complete_event`) to react
to results.

> **Core queue note.** Because Post API uses the database queue, its reliable operation depends
> on a known core queue bug (`claimItem()` lease handling); the module's project page links the
> core patch to apply if you hit it.
