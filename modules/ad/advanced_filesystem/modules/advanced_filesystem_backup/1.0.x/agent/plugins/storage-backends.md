<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Backup — the `BackupStorage` plugin type and built-in backends

## Plugin type

- Annotation: `Annotation\BackupStorage` (`id`, `label`, `description`).
- Manager: `BackupStoragePluginManager` (service
  `plugin.manager.advanced_filesystem_backup_storage`, `parent: default_plugin_manager`), scans
  `Plugin/BackupStorage/`, namespace `…\Plugin\BackupStorage`. Exposes `getOptions()` (id ⇒ label)
  and `hasDefinition()` used by the settings form.
- Interface: `BackupStorageInterface`. Every backend implements:
  `getPluginId()`, `getLabel()`, `buildConfigForm($saved)`, `validateConfigForm($values,$fs,$prefix)`,
  `testConnection($config)`, and two I/O surfaces —
  ZIP mode: `upload()`, `listBackups()`, `delete()`, `download()`;
  file-by-file mode: `uploadFile()`, `downloadFile()`, `listFiles()`, `deleteFiles()`.

`BackupManager::getStoragePlugin($backend)` instantiates `$backend['type']` and passes
`$backend['config']` (the per-backend config array) to each call.

## Built-in backends

### `local` — `LocalBackupStorage`
Copies the archive/files into a `destination_dir` (stream-wrapper URI or absolute path, default
`private://advanced_filesystem_backup/archives`) via `file_system` copy / `prepareDirectory`.
`getLocalRealPath()` lets download/restore serve the file directly with no copy. `listBackups()`
globs `*.zip`; files mode uses `RecursiveDirectoryIterator`.

### `ftp` — `FtpBackupStorage`
PHP-native FTP. Config: `host`, `port` (21), `username`, `password` (password field), `remote_dir`
(`/backups`), `ssl` (FTPS via `ftp_ssl_connect`), `passive` (default on), `timeout` (90).
`connect()` requires the `ftp` extension, logs in, sets passive mode. Uploads with `ftp_put`
(binary), recursive mkdir for file-mode keys.

### S3-compatible base — `S3CompatibleBackupStorageBase`
Abstract base implementing **AWS Signature v4** by hand over Drupal's `\Drupal::httpClient()`
(no AWS SDK). `signRequest()` builds the canonical request, credential scope
`<date>/<region>/<service>/aws4_request`, and the `Authorization: AWS4-HMAC-SHA256 …` header using
chained `hash_hmac`. Shared config form: `access_key`, `secret_key` (password field, blank = keep),
`bucket`, `region`, `prefix` (key prefix/folder), `endpoint` (override template with `{bucket}` /
`{region}` placeholders). `upload()`/`uploadFile()` PUT the body; `listBackups()`/`listFiles()`
GET `?list-type=2&prefix=` and parse the S3 XML; `download()`/`delete()` as expected. Transfers use
the default HTTP-client TLS settings.

Concrete subclasses:

- **`s3` — `AwsS3BackupStorage`** — endpoint `https://{bucket}.s3.{region}.amazonaws.com`.
- **`r2` — `CloudflareR2BackupStorage`** — adds an `account_id` field; endpoint
  `https://{account_id}.r2.cloudflarestorage.com/{bucket}`, region forced to `auto`.
- **`gcs` — `GcsBackupStorage`** — endpoint `https://storage.googleapis.com/{bucket}` (bucket in
  path); `access_key`/`secret_key` are GCS interoperability **HMAC** keys, region used only for the
  SigV4 scope.

## Adding a backend

Create a class in `Plugin/BackupStorage/` with a `@BackupStorage` annotation implementing
`BackupStorageInterface` (extend `S3CompatibleBackupStorageBase` for S3-compatible targets, or
`PluginBase` directly). It then appears in the settings form's storage-type select automatically.
