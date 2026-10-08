# API — the indexing client service

Service id **`google_index_api.client`** → `Drupal\google_index_api\Service\GoogleIndexApi`
(constructor args: `@state`, `@logger.factory`). This is the module's whole public surface — the
module does NOT implement any entity hooks itself; you call the service from your own hook so you
control which entities are announced.

## Public methods

| Method | Sends | Behavior |
|---|---|---|
| `updateUrl(string $url)` | `type: URL_UPDATED` | Notify Google the URL was created/updated. |
| `deleteUrl(string $url)` | `type: URL_DELETED` | Notify Google the URL was removed. |

Both delegate to the protected `callApi($url, $type)`, which POSTs
`{"type": $type, "url": $base_domain . $url}` to
`https://indexing.googleapis.com/v3/urlNotifications:publish`. Pass a **path** (e.g. `/node/1` or the
result of `$node->toUrl()->toString()`); the configured base domain is prepended for you. A `200`
logs a success notice; anything else logs the Google error message (or the status code) to the
`Google Index API` logger channel.

## Typical use — from an entity hook

```php
use Drupal\node\NodeInterface;

/**
 * Implements hook_ENTITY_TYPE_update() for node entities.
 */
function MYMODULE_node_update(NodeInterface $node) {
  \Drupal::service('google_index_api.client')->updateUrl($node->toUrl()->toString());
}

/**
 * Implements hook_ENTITY_TYPE_delete() for node entities.
 */
function MYMODULE_node_delete(NodeInterface $node) {
  \Drupal::service('google_index_api.client')->deleteUrl($node->toUrl()->toString());
}
```

## Notes

- The service constructor initialises the `Google_Client` immediately from the uploaded
  service-account JSON (State key `google_index_api_json_file`) with scope
  `https://www.googleapis.com/auth/indexing`. If no credential is configured, the client is never
  built and a call will fail — configure the [settings form](../configure/settings.md) first.
- Authentication and the HTTPS transport are handled by the `google/apiclient ^2.0` library
  (`Google_Client::authorize()` returns an authorized Guzzle client used for the POST).
- The Indexing API is quota-limited (~200 calls/project/day) and Google documents it for
  job-posting / livestream pages; call it selectively.
