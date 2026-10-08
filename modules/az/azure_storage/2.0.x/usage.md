<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Azure Storage Integration configures Microsoft Azure Storage credentials in Drupal and exposes a service that returns a ready-to-use Azure Queue client.

---

Azure Storage Integration is a thin bridge between Drupal and Microsoft Azure Storage. In this 2.0.x
release it centralises Azure account settings — protocol, account name, endpoint suffix, a mode
switch (test/live), and the matching account keys stored as Key module entities — in one admin
settings form at `/admin/config/services/azure-storage`, and provides a single service,
`azure_storage.client` (`AzureStorageClient`), that assembles an Azure Storage connection string and
hands back a configured Azure Queue service (`MicrosoftAzure\Storage\Queue\QueueRestProxy`) for
sending and reading queue messages. Other code retrieves the service, calls
`getStorageQueueService()` (or `setStorageQueueService($connection_string)` for a bespoke
connection), and then uses the returned proxy, for example `$service->createMessage('queue_name',
'message')`. The module depends on the Key module for credential storage and requires the
`microsoft/azure-storage-queue` and `microsoft/azure-storage-common` PHP SDK packages via Composer.
An `azure_storage_file` metadata table is installed for future blob/file support, but this version
ships no stream wrapper or blob file backend.

---

- Configure Azure Storage account name, protocol, and endpoint suffix in one admin form.
- Store Azure account keys as Key module entities rather than plaintext config.
- Switch between a test and a live account key with the mode radio.
- Retrieve the Azure client service with `\Drupal::service('azure_storage.client')`.
- Get a configured Azure Queue client via `getStorageQueueService()`.
- Send a message to an Azure Storage queue with `createMessage('queue_name', 'message')`.
- Read or peek messages from an Azure Storage queue via the returned `QueueRestProxy`.
- Build an Azure connection string from centrally managed configuration.
- Pass a custom connection string with `setStorageQueueService($connection_string)`.
- Override individual connection parameters via `getStorageQueueConnectionString($params)`.
- Share Azure credentials across multiple custom modules through one service.
- Integrate Azure Queue Storage into background/queue processing workflows.
- Keep Azure secrets out of version control by referencing Key entities.
- Restrict Azure configuration to trusted admins with the `administer azure storage` permission.
- Reuse the same Azure account settings for test and production deployments.
- Provide a foundation for custom Azure Storage integrations (blobs, tables, queues).
- Check runtime readiness (allow_url_fopen, 64-bit PHP) via `hook_requirements`.
- Author queue producers/consumers that decouple Drupal from Azure credential handling.
