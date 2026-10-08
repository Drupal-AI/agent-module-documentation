<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DKAN Dataset Archiver: Remote Storage (dkan_dataset_archiver_remote_storage) — agent index

Submodule of [`dkan_dataset_archiver`](../../../../1.x/agent/start.md). Streams generated `dda_archive`
files to **AWS S3** via League Flysystem. Package **DKAN**, version **1.x**, core `^10 || ^11`,
GPL-2.0-or-later. Depends only on the parent `dkan_dataset_archiver`. No routes, no permissions, no config
schema of its own — it reuses the parent's `dkan_dataset_archiver.settings` object.

## What it provides

- **Service `dkan_dataset_archiver_remote_storage.remote_storage_service`** (`Service/RemoteStorageService`,
  uses `AwsS3Trait`) — `addToRemoteFileSyncQueue()` enqueues an archive; `syncToRemote()` uploads each
  resource file to S3, appends the `s3://bucket/…` URL to the archive's `remote_url` field, and (in
  `remote`-only mode) deletes the local file after a successful upload.
- **Service `dkan_dataset_archiver_remote_storage.aws_s3_service`** (`Service/AwsS3Service`) — builds the
  `Aws\S3\S3Client` from config `remote_region` + `remote_address` (parent settings) and credentials from
  the **AWS SDK environment credential chain** (`CredentialProvider::env()`→`chain()`); registers the S3
  stream wrapper. Throws if `remote_type !== 'aws:s3'` or region/address is empty.
- **Trait `AwsS3Trait`** (`src/AwsS3Trait.php`) — wraps the S3 client in a Flysystem `Filesystem` over
  `AwsS3Adapter`.
- **Queue worker `archive_remote_file_sync`** (`Plugin/QueueWorker/SyncToRemote`, cron time 30) — calls
  `RemoteStorageService::syncToRemote()`; re-queues on failure (except `SuspendQueueException`, re-thrown).
- **Event subscriber `StorageSubscriber`** — on the parent's `ArchivePostSaveEvent`, queues the archive for
  sync when it is new or its local files changed and it has not already been remote-stored (recursion
  guard via `hasRemoteStored()`).
- **Hook** `Hook/CoreHooks::help()` — renders this submodule's README.

## Operation

Enable the submodule, then on `/admin/dkan/archiver` set **Storage location** to `remote` or
`local_and_remote` and fill **bucket address** (`s3://…`) + **region**. Provide AWS credentials to the web
process via environment variables (README lists `AWS_ID`, `AWS_KEY`, `AWS_SECRET_ACCESS_KEY`, `AWS_PROFILE`,
`AWS_SESSION_TOKEN`, `AWS_TOKEN`). Uploads run on cron through the `archive_remote_file_sync` queue.

## Solution doc

- **Services, queue, S3 client, credentials, storage modes** → [config/remote-storage.md](config/remote-storage.md)
