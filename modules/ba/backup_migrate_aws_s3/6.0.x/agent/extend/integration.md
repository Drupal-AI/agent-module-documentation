<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Integration internals — `AWSS3Destination` & the download route

For developers extending or debugging the S3 destination.

## The destination class

`\Drupal\backup_migrate_aws_s3\Destination\AWSS3Destination` extends Backup & Migrate's
`DestinationBase` and implements `RemoteDestinationInterface`, `ListableDestinationInterface`,
`ReadableDestinationInterface`, `ConfigurableInterface`. It is wrapped by the `awss3` plugin
(`AWSS3DestinationPlugin`, `wrapped_class` in its annotation). Services (`key.repository`,
`file.repository`, `file_system`, and `key_aws.repository` if present) are fetched via
`\Drupal::service()` in the constructor.

Key methods:

| Method | S3 call | Notes |
|---|---|---|
| `getClient()` | builds `Aws\S3\S3Client` | Reads region + credentials; version `latest`; adds `endpoint` if configured. Cached on the instance. |
| `saveFileToS3($filename,$loc,$client)` | `putObject` | Adds `ChecksumAlgorithm=SHA256` + `ContentSHA256` when the bucket has Object Lock enabled (checked via `getObjectLockConfiguration`). |
| `listFiles($count,$start)` | `getIterator('ListObjects')` | Lists bucket objects under `s3_folder_prefix`, strips the prefix from returned names. |
| `getFile($id)` / `fileExists($id)` | (via `listFiles`) | No single-object metadata call; lists then filters. |
| `downloadFile($file)` | `getObject` | Returns a Symfony `Response` streaming the body. |
| `loadFileForReading($file)` | `getObject` | Writes the body to `temporary://` and returns a `ReadableStreamBackupFile`. |
| `deleteTheFile($id)` | `deleteObject` | Prefix-aware. |

Credential resolution in `getClient()`:
- If `key_aws` is enabled and `s3_key_name` set → `AWSKeyRepository::getCredentials()`.
- Else read `s3_access_key_name` and `s3_secret_key_name` via `key.repository->getKey(...)->getKeyValue()`.
- All object operations use `confGet('s3_bucket')` + the trimmed `s3_folder_prefix`.

AWS SDK exceptions are caught, surfaced with `messenger()->addError()`, and logged to the
`backup_migrate_aws_s3` channel.

## Download route override

`\Drupal\backup_migrate_aws_s3\Routing\AWSS3RouteSubscriber` alters
`entity.backup_migrate_destination.backup_download`, repointing its `_controller` to
`AWSS3BackupController::download`. That controller loads the destination object; if it is an
`AWSS3Destination` it returns `downloadFile($file)` (S3 stream), otherwise it falls back to Backup
& Migrate's normal browser-download path. The route's access/permission requirements are Backup &
Migrate's own — this module does not add or relax them.

## Empty hook

`backup_migrate_aws_s3_backup_migrate_service_object_alter()` exists but is a no-op placeholder.
