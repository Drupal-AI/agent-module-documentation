<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events

Every index/document operation runs through an event pipeline, so integrators can veto, observe,
or react to Elasticsearch activity.

## Event names

| Constant | Name string | Dispatched | Event class |
|----------|-------------|------------|-------------|
| `ElasticsearchEvents::OPERATION` | `elasticsearch_helper.operation` | Before a document/index operation runs (vetoable). | `ElasticsearchOperationEvent` |
| `ElasticsearchEvents::OPERATION_REQUEST` | `elasticsearch_helper.operation_request` | Just before the ES client callback executes. | `ElasticsearchOperationRequestEvent` |
| `ElasticsearchEvents::OPERATION_REQUEST_RESULT` | `elasticsearch_helper.operation_request_result` | After a response is received. | `ElasticsearchOperationRequestResultEvent` |
| `ElasticsearchEvents::OPERATION_ERROR` | `elasticsearch_helper.operation_error` | When a `\Throwable` is thrown during an operation. | `ElasticsearchOperationErrorEvent` |
| `ElasticsearchHelperEvents::REINDEX` | `elasticsearch_helper.reindex` | Around the reindex callback. | `ElasticsearchHelperCallbackEvent` |
| `DataTypeEvents::BUILD` | `elasticsearch_helper.data_type_build` | While the data-type repository builds valid field types. | `DataTypeDefinitionBuildEvent` |

`ElasticsearchOperationEvent` carries the operation string (constants in
`Event\ElasticsearchOperations`, e.g. `document.index`, `index.create`, `query.search`,
`index.truncate`), the plugin instance, the actionable `&getObject()` (by reference — you may
rewrite the document/entity) and `&getMetadata()`.

## Vetoing / rewriting an operation

`ElasticsearchOperationEvent` implements `OperationPermissionInterface`
(`isOperationAllowed()`, `allowOperation()`, `forbidOperation()` — via `OperationPermissionTrait`,
default allowed). A subscriber calling `forbidOperation()` stops that index/document write; the
plugin checks `isOperationAllowed()` before issuing the request. `getObject()` returns by reference,
so a subscriber can mutate the document before it is sent.

```php
public static function getSubscribedEvents(): array {
  return [\Drupal\elasticsearch_helper\Event\ElasticsearchEvents::OPERATION => 'onOperation'];
}

public function onOperation(\Drupal\elasticsearch_helper\Event\ElasticsearchOperationEvent $event) {
  if ($event->getOperation() === \Drupal\elasticsearch_helper\Event\ElasticsearchOperations::DOCUMENT_INDEX) {
    $doc = &$event->getObject();
    // Inspect/modify $doc, or:
    // $event->forbidOperation();
  }
}
```

## Built-in subscribers (`elasticsearch_helper.services.yml`)

| Service | Class | Reacts to | Effect |
|---------|-------|-----------|--------|
| `elasticsearch_helper.logging_event_subscriber` | `LoggingEventSubscriber` | `OPERATION_ERROR`, `OPERATION_REQUEST_RESULT` | Logs per-operation errors and create/delete confirmations to the `elasticsearch_helper` channel. Respects `settings.php` flag `elasticsearch_helper.silent_delete`. |
| `elasticsearch_helper.messaging_event_subscriber` | `MessagingEventSubscriber` | `OPERATION_ERROR` | Shows an admin message on a failed document index (suppressed on CLI). |
| `elasticsearch_helper.queue_index_event_subscriber` | `QueueIndexEventSubscriber` | `OPERATION_ERROR` | If indexing from the queue worker and the cluster is unreachable (`NoNodeAvailableException`), throws `SuspendQueueException` so the queue backs off. |

Subscribe to `OPERATION_REQUEST_RESULT` (event `getResult()->getResultBody()->asArray()`) to read
responses, or `OPERATION_ERROR` (`getError()`, `getOperation()`, `getRequestWrapper()`) to handle
failures. Data types accepted in mappings are extendable through `DataTypeEvents::BUILD` on
`elasticsearch_helper.data_type_repository`.
