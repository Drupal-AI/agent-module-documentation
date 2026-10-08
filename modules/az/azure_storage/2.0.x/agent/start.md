<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Azure Storage Integration (azure_storage) — agent index

Thin integration layer between Drupal and **Microsoft Azure Storage**. In this **2.0.x** release it
does two things: centralises Azure credentials in an admin settings form, and exposes one service
that returns a configured **Azure Queue** client (`QueueRestProxy`). Package `Azure`. Depends on
**`key`** (`key:key`). Core `^8.8.3 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 2.0.3.

Requires the PHP SDK via Composer: `microsoft/azure-storage-queue` `^1.3`,
`microsoft/azure-storage-common` `^1.5`.

- **Settings form, config object/keys, route, permission, credential (Key) handling** →
  [config/settings.md](config/settings.md)
- **The `azure_storage.client` service, queue client, and connection-string API** →
  [api/queue-client.md](api/queue-client.md)

## What it actually is (from source)

- One service **`azure_storage.client`** = `Drupal\azure_storage\AzureStorageClient`
  (`src/AzureStorageClient.php`), implementing `AzureStorageClientInterface`. Constructed with
  `@config.factory` and a dedicated logger channel `@logger.channel.azure_storage`. It builds a
  connection string and returns a `MicrosoftAzure\Storage\Queue\QueueRestProxy`.
- A static helper **`AzureStorage::getAccountKey()`** (`src/AzureStorage.php`, `final` class) reads
  the configured Key entity id (`test_account_key`/`live_account_key` per `mode`) from
  `key.repository` and returns its secret value.
- One config form **`SettingsForm`** (`src/Form/SettingsForm.php`, extends `ConfigFormBase`) editing
  config object **`azure_storage.settings`**.
- One route **`azure_storage.settings_form`** → `/admin/config/services/azure-storage`, requirement
  `_permission: 'administer azure storage'` (the only permission, from
  `azure_storage.permissions.yml`). Menu link under *Configuration → Services* and a local task tab.
- `azure_storage.install`: `hook_requirements` (checks `allow_url_fopen` on, 64-bit PHP) and
  `hook_schema` installing table **`azure_storage_file`** (uri/filesize/timestamp/dir/version) —
  intended for future blob/file metadata. **No stream wrapper or blob file backend ships in this
  version.**
- `hook_help` only. No entities, no plugins, no Drush, no config schema directory, no other routes.

## Not present (despite name/README)

- No Azure **Blob** stream wrapper, no file field/formatter, no blob download route. The README
  mentions blobs/tables/queues, but the 2.0.x code implements only the **Queue** path plus shared
  credential config. The `azure_storage_file` table is installed but unused by shipped code.
