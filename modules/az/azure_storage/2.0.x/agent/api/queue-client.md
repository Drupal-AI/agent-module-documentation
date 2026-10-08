<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — azure_storage.client service (Azure Queue)

The one service the module provides and how to drive it. Source: `src/AzureStorageClient.php`,
`src/AzureStorageClientInterface.php`, `src/AzureStorage.php`, `azure_storage.services.yml`.

## Service definition

- `azure_storage.client` = `\Drupal\azure_storage\AzureStorageClient`, arguments
  `['@config.factory', '@logger.channel.azure_storage']`.
- `logger.channel.azure_storage` — a `logger.channel_base` child with channel name `azure_storage`.
  (Injected and stored on `$this->logger`, but this version logs nothing.)
- The constructor reads `azure_storage.settings` once into `$this->config`.

## Interface: `AzureStorageClientInterface`

| Method | Returns | Notes |
|---|---|---|
| `setStorageQueueService($connection_string = NULL)` | `$this` | Creates a `QueueRestProxy` and stores it. `NULL` → builds the string from config. |
| `getStorageQueueService()` | `MicrosoftAzure\Storage\Queue\Internal\IQueue` | Lazily calls `setStorageQueueService()` when none set yet. |
| `getStorageQueueConnectionString(array $params = []): string` | `string` | Assembles the Azure connection string; each param falls back to config. |

## Connection string

`getStorageQueueConnectionString()` returns:

```
DefaultEndpointsProtocol=$protocol;AccountName=$account_name;AccountKey=$account_key;EndpointSuffix=$endpoint_suffix
```

Each value is `$params[...]` if given, else from `azure_storage.settings`, except `account_key`,
which defaults to `AzureStorage::getAccountKey()` (the Key-entity value for the current `mode` — see
[../config/settings.md](../config/settings.md)). Overridable param keys: `protocol`, `account_name`,
`account_key`, `endpoint_suffix`.

`setStorageQueueService()` calls `QueueRestProxy::createQueueService($connection_string)` — the Azure
Queue SDK client, not a Blob or Table client.

## Usage

```php
/** @var \Drupal\azure_storage\AzureStorageClientInterface $client */
$client = \Drupal::service('azure_storage.client');

// Default: connection string built from config (account key from the Key entity).
$queue = $client->getStorageQueueService();
$queue->createMessage('queue_name', 'message');

// Or supply a bespoke connection string:
$queue = $client->setStorageQueueService($connection_string)->getStorageQueueService();
```

In OOP services, inject `azure_storage.client` rather than using `\Drupal::service()`.

## Scope / limits

- **Queue only.** No Blob or Table client, no Drupal stream wrapper, no file backend ships here — the
  returned `QueueRestProxy` speaks the Azure Queue REST API.
- The installed `azure_storage_file` table (`hook_schema`) is unused by shipped code (reserved for
  future blob/file metadata).
- Transport TLS follows `protocol` (default `https`); the Azure SDK performs standard certificate
  verification — no verification is disabled in module code.
