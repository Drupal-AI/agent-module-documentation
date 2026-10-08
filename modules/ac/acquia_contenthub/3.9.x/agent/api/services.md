# acquia_contenthub key services

From `acquia_contenthub.services.yml`. Most work is done through events (see
[../extend/events.md](../extend/events.md)); these are the services you call directly.

| Service id | Class / role |
|---|---|
| `acquia_contenthub_common_actions` | High-level facade — serialize entities to CDF, import CDF, get dependencies. The main entry point for programmatic export/import. |
| `acquia_contenthub.client.factory` | `Client\ClientFactory` — builds the authenticated `\Acquia\ContentHubClient\ContentHubClient`; `getClient()` returns it, `authenticate(Request)` performs HMAC verification of incoming webhooks. |
| `acquia_contenthub.configuration` | `Settings\ContentHubConfiguration` — resolves connection details (dispatches `GET_SETTINGS`). |
| `entity.cdf.serializer` | Serializes/normalizes entities to CDF documents. |
| `acquia_contenthub.file_scheme_handler.manager` | Plugin manager for file scheme handlers (see [../plugins/file-scheme-handler.md](../plugins/file-scheme-handler.md)). |
| `acquia_contenthub.client_metadata_manager` | Builds/updates this client's CDF metadata. |
| `acquia_contenthub.cdf_metrics_manager` | Sends client CDF metrics/updates to the service. |
| `pub.sub_status.checker` | Determines whether the site is acting as publisher and/or subscriber. |

Depends on the `depcalc` module's `entity.dependency.calculator` to compute the full
dependency graph of an entity (fields, references, files, config) before export.

## Example: serialize an entity to CDF
```php
/** @var \Drupal\acquia_contenthub\ContentHubCommonActions $common */
$common = \Drupal::service('acquia_contenthub_common_actions');
$node = \Drupal::entityTypeManager()->getStorage('node')->load(1);
$cdf = $common->getEntityCdf($node); // array of CDF documents incl. dependencies
```

## Example: get the authenticated client
```php
$client = \Drupal::service('acquia_contenthub.client.factory')->getClient();
if ($client) {
  $settings = $client->getSettings(); // origin UUID, api key, hostname, shared secret…
}
```
Prefer Drush (`acquia:contenthub-*`, see [../drush/commands.md](../drush/commands.md)) for
operational tasks rather than scripting these services.
