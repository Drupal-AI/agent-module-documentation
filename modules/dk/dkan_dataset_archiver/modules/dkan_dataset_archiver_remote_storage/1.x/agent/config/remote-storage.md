<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Remote storage — services, queue, and S3 wiring

Install/enable: `drush en dkan_dataset_archiver_remote_storage` (requires the parent
`dkan_dataset_archiver`). This submodule has **no config object of its own** — it reads the parent's
`dkan_dataset_archiver.settings` (`storage_locations`, `remote_type`, `remote_address`, `remote_region`).
Enabling it un-greys the `remote` / `local_and_remote` radios on the parent settings form
(`/admin/dkan/archiver`).

## Trigger chain

1. `EventSubscriber/StorageSubscriber::addArchiveToFileMover()` listens on the parent's
   `ArchivePostSaveEvent` (priority 10). When an archive `isNew()` or `localFilesChanged()` **and** not
   `hasRemoteStored()` (recursion guard), it calls
   `RemoteStorageService::addToRemoteFileSyncQueue($archive)`.
2. `addToRemoteFileSyncQueue()` only enqueues if `storage_locations` is `remote` or `local_and_remote`;
   it pushes `{archive_id, title}` onto queue **`archive_remote_file_sync`**.
3. Queue worker `Plugin/QueueWorker/SyncToRemote` (`cron: ['time' => 30]`) → `syncToRemote($data)`.
   On a generic exception it re-queues the item to the tail (non-blocking); `SuspendQueueException`
   bubbles up.

## `RemoteStorageService::syncToRemote()` (`src/Service/RemoteStorageService.php`)

- Short-circuits unless `canSync()` (`storage_locations ∈ {remote, local_and_remote}`).
- For `remote_type === 'aws:s3'`: `s3Bucket = str_replace('s3://', '', remote_address)`, builds a
  Flysystem `Filesystem` over `AwsS3Adapter` (`AwsS3Trait::getAwsS3Filesystem()`). Empty `remote_address`
  → `SuspendQueueException`; any other `remote_type` → exception (only AWS supported).
- Loads the `dda_archive`, iterates `getResourceFileItems()`, maps the local `public://`/`private://`
  path to an S3 key under `/dataset_archives/public/` or `/dataset_archives/private/`, and uploads with
  `$fileSystem->putStream($destination, fopen($local_file_path, 'r'))`.
- On success it appends `s3://{bucket}{destination}` to the archive's `remote_url` link field. In
  `remote`-only mode it then **deletes the local file** and notes it in the revision log.
- If anything was uploaded it saves a new revision with `setSyncing(TRUE)` + `setHasRemoteStored(TRUE)`
  (so the save doesn't re-trigger a sync).

## S3 client + credentials (`src/Service/AwsS3Service.php`)

- `getS3Client()` throws a `RuntimeException` unless `remote_type === 'aws:s3'` and both `remote_address`
  and `remote_region` are set.
- Credentials come from the **AWS SDK credential chain** — `CredentialProvider::env()` composed via
  `CredentialProvider::chain()` — i.e. from process environment variables, **not** from Drupal config.
  The README lists the accepted env vars (`AWS_ID`, `AWS_KEY`, `AWS_SECRET_ACCESS_KEY`, `AWS_PROFILE`,
  `AWS_SESSION_TOKEN`, `AWS_TOKEN`). The client is created with `version: 'latest'`, the configured
  `region`, and the resolved credentials, then `registerStreamWrapper()` enables the `s3://` stream.
- Only `remote_region` and `remote_address` (bucket) are read from config; no access key or secret is
  stored in configuration.

## Notes

- Uploaded archive files inherit the sensitivity of their source dataset (public vs non-public), reflected
  in the `/dataset_archives/public/` vs `/dataset_archives/private/` key prefix — bucket-side access
  policy is the operator's responsibility.
- No custom S3 endpoint override is set, so it targets AWS S3 proper (region-based), using the AWS SDK's
  default (TLS-verified) transport.
