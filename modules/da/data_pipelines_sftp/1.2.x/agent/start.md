<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Data Pipelines - SFTP (data_pipelines_sftp) — agent index

Adds an **SFTP source resource** to the **Data Pipelines** framework: a dataset can read its input
file (e.g. JSON) from a remote SFTP server. Package `Data Pipelines`. Core `^10.1 || ^11`, PHP 8.0.
License GPL-2.0-or-later. Version 1.2.0.

Depends on Drupal modules **`data_pipelines`** and **`key`**, and the PHP library
**`phpseclib/phpseclib` ^3** (Composer). No permissions, no Drush, no routes, no config objects,
no config schema.

- **The source resource, field type/widget, storage cache, and install hooks** →
  [api/sftp-source.md](api/sftp-source.md)

## What it actually is (from source)

- **Source resource plugin** `Sftp` (`src/Source/Resource/Sftp.php`, extends
  `data_pipelines\Source\Resource\SourceResourceBase`), registered as tagged service
  `data_pipelines_sftp.source_resource.sftp` (tag `data_pipelines_source_resource`) in
  `data_pipelines_sftp.services.yml`, injected with `@key.repository` and
  `@data_pipelines_sftp.storage`. `getResource()` opens `phpseclib3\Net\SFTP`, logs in, and
  `$client->get($path)`.
- **Field type** `SftpItem` (id `sftp`, `no_ui = TRUE`) in `src/Plugin/Field/FieldType/SftpItem.php`
  — columns `path`, `host`, `port`, `credentials`, `local_copy`; main property `path`.
- **Field widget** `SftpWidget` (id `sftp`) in `src/Plugin/Field/FieldWidget/SftpWidget.php` —
  path/host/port textfields plus a Key `key_select` filtered to `type: user_password`, and a
  "Local copy" checkbox.
- **Storage helper** `Storage` (`src/Storage.php`, service `data_pipelines_sftp.storage`,
  injected `@file_system`) — caches downloads under `private://data_pipelines_sftp/cache`.
- **Install hooks** (`data_pipelines_sftp.install`) install one `sftp` base field per Data
  Pipelines source (`<source>_sftp`) on the `data_pipelines` entity; updates 10001/10002 add the
  `local_copy` column.

## Key facts

- Credentials are **not** stored on the dataset — the dataset stores only the Key id
  (`credentials`); the username/password are read at run time from a `user_password` Key via
  `KeyRepositoryInterface::getKey()->getKeyValue()` and JSON-decoded.
- Port defaults to **22** when blank. Path/host/port come from the dataset field values.
- "Local copy" mirrors the file to the private cache and enables a fallback read when the remote
  fetch throws; disabling it deletes the cached file on `postSave()`.
