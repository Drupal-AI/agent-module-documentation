<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SFTP source resource — data_pipelines_sftp

How the module lets a Data Pipelines dataset pull its file over SFTP. All classes under
`Drupal\data_pipelines_sftp`.

## Install / enable

- `composer require drupal/data_pipelines_sftp` (pulls `drupal/key` and `phpseclib/phpseclib:^3`),
  then enable `data_pipelines_sftp` (requires `data_pipelines` + `key`).
- `hook_install()` (`data_pipelines_sftp.install`) enumerates every registered source plugin id
  from `plugin.manager.data_pipelines_source` and, via `entityDefinitionUpdateManager()`, installs
  a base field storage definition `"{$source}_sftp"` of type `sftp` on the `data_pipelines`
  entity (bundle `data_pipelines`), required, form widget `sftp`.
- `hook_uninstall()` removes those field storage definitions.
- `data_pipelines_sftp_update_10001` / `_10002` add the `{$source}_sftp__local_copy` tiny-int
  column to already-installed sites (10002 sets `not null => FALSE`).

## Field type `SftpItem` (`Plugin/Field/FieldType/SftpItem.php`)

- `@FieldType(id="sftp", label="SFTP", default_widget="sftp", no_ui=TRUE)` — not exposed in the
  Field UI; installed only as a base field by the install hook / source resource.
- Properties & schema columns: `path` (varchar 512), `host` (varchar 256), `port` (varchar 32),
  `credentials` (varchar 256 — a Key id), `local_copy` (tinyint, nullable). `mainPropertyName()`
  is `path`.
- `postSave($update)`: when `local_copy` is falsy it calls
  `data_pipelines_sftp.storage->deleteLocalCopy($path)` to purge any cached file.

## Field widget `SftpWidget` (`Plugin/Field/FieldWidget/SftpWidget.php`)

- `@FieldWidget(id="sftp", field_types={"sftp"})`. `formElement()` builds:
  - `path` — textfield "Path on the server", required.
  - `local_copy` — checkbox "Local copy" ("In the event of the remote file not being available,
    this copy will be used.").
  - `connection` details group with `host` (required textfield), `port` (textfield, placeholder
    `22`), and `credentials` — a **`key_select`** element titled "Key", `#key_filters =
    ['type' => 'user_password']`, required.
- `massageFormValues()` flattens the nested `connection` subarray up into the item values
  (`$value = [...$value, ...$value['connection']]`).

## Source resource `Sftp` (`Source/Resource/Sftp.php`)

- Extends `SourceResourceBase`; constructed with `KeyRepositoryInterface $keyRepository` and
  `Storage $storage`. Registered as service `data_pipelines_sftp.source_resource.sftp` with tag
  `data_pipelines_source_resource` — this is how Data Pipelines discovers it.
- `getResourceBaseFieldDefinition()` returns the same `sftp` base field definition used at install.
- `getResource(DatasetInterface $dataset, string $field_name)`:
  1. reads `path` from the dataset field (`getPath()` → `self::getFieldValue(...)`),
  2. `getClient()` opens/authenticates the SFTP client, `$client->get($path)` downloads contents,
  3. throws if contents are empty,
  4. returns a stream — `Storage::createLocalCopy()` when `local_copy` is on, otherwise
     `Storage::createMemoryCopy()` (`php://temp`).
  - On any `\Exception` it logs to the dataset (`$dataset->addLogMessage(...)`); if `local_copy`
    is on it logs "The local copy … has been used." and returns `Storage::getLocalCopy($path)`;
    otherwise returns `NULL`.
- `getClient()` (static-cached per request): `Stream::register()`, then
  `new \phpseclib3\Net\SFTP($host, $port)` (port from `getPort()`, default 22). Credentials are
  loaded from the Key named by the `credentials` field value:
  `Json::decode($keyRepository->getKey($this->getCredentials())->getKeyValue())` yielding
  `['username' => …, 'password' => …]`, then `$client->login($username, $password)`; throws
  "Authentication failed." on failure. **The dataset stores only the Key id, never the secret.**

## Storage cache `Storage` (`src/Storage.php`, service `data_pipelines_sftp.storage`)

- Constant `LOCAL_FOLDER = 'private://data_pipelines_sftp/cache'`. `getLocalPath($path)` appends
  the basename of `$path` (via `pathinfo(...PATHINFO_BASENAME)`).
- `prepareLocalPath()` ensures the private cache directory (`CREATE_DIRECTORY`).
- `createLocalCopy($path, $contents)` writes the file (`fopen 'w+'`, `fwrite`, `rewind`) and
  returns the stream; throws "Could not create local copy." on write failure.
- `createMemoryCopy($contents)` does the same against `php://temp` (no disk).
- `getLocalCopy($path)` opens the cached file read-only if `is_readable`; `deleteLocalCopy()`
  unlinks it. Requires Drupal's **private file system** to be configured.

## Operating notes

- Configure the SFTP details on the dataset add/edit form (the `<source>_sftp` field): server
  path, host, optional port, and pick a `user_password` Key. Create that Key first via the Key
  module (Configuration → System → Keys), key type "User/password".
- One `sftp` field is installed per Data Pipelines source; the dataset uses the field matching its
  chosen source resource. Retrieval and error handling happen when the pipeline runs.
