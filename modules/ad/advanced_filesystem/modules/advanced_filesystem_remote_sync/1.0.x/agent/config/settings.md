<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, service & sync batch (destination-server side)

## Install / enable

`drush pm:install advanced_filesystem_remote_sync && drush cr`. Requires core `file`, core `user`,
`advanced_filesystem` and `advanced_filesystem_backup`. Enable it on **both** servers: the source
needs it to expose the API endpoints; the destination needs it for the form + batch.

## Admin form & route

`RemoteSyncForm` (`src/Form/RemoteSyncForm.php`, extends `ConfigFormBase`) at
`/admin/config/media/advanced_filesystem/backup/remote-sync`
(route `advanced_filesystem_remote_sync.form`, `_permission: 'administer advanced_filesystem_backup'`,
`_admin_route`), shown as the "Remote Sync" local task (`links.task.yml`). Three submit buttons:

- **Save settings** → `saveSettings()` (persist only).
- **Test connection** → `testConnection()` (persist, then live check; limited validation).
- **Save & start sync now** → `submitForm()` (persist, then `batch_set(...)`).

`validateForm()` requires a valid URL (`FILTER_VALIDATE_URL`) and, for the start action, at least
one scheme selected. Scheme checkboxes are built from local stream wrappers
(`stream_wrapper_manager->getWrappers(StreamWrapperInterface::LOCAL)`). The password field is
optional; blank keeps the previously saved password (`persistSettings()`).

## Config object `advanced_filesystem_remote_sync.settings`

Schema: `config/schema/advanced_filesystem_remote_sync.schema.yml`. Install defaults:
`config/install/advanced_filesystem_remote_sync.settings.yml`.

```yaml
connection:
  url: ''            # source base URL, trailing slash stripped
  username: ''       # Basic Auth username (a Drupal user on the source)
  password: ''       # Basic Auth password — stored in config, plaintext
  verify_ssl: true   # TLS cert verification; default TRUE
sync_options:
  schemes: [public]  # stream-wrapper scheme IDs to pull
  overwrite: true    # overwrite files already present locally
  chunk_size: 5      # files downloaded per batch step (clamped 1..50)
```

The password is stored plaintext in config (the schema label itself says "use HTTPS"); prefer an
HTTPS source URL. `verify_ssl` should stay on except for self-signed dev certs.

## Service `RemoteSyncService` (`advanced_filesystem_remote_sync.service`)

Args: `@config.factory`, `@http_client`, own logger channel. Methods:

- `getConnectionConfig()` — reads `connection`, trims/rtrims the URL, defaults `verify_ssl` TRUE.
- `getSyncOptions()` — reads `sync_options`, defaults `schemes=[public]`, `overwrite=TRUE`,
  `chunk_size` clamped 1..50.
- `isConfigured()` — TRUE when url, username, password all non-empty.
- `testConnection()` — Guzzle `GET {url}/advanced-filesystem-remote-sync/list?scheme=public&limit=1`
  with `auth => [username, password]`, `verify => verify_ssl`, `timeout => 10`; returns
  `['ok'=>bool,'message'=>string]` after checking the JSON has a `files` key.
- `buildBatch($schemes, $overwrite, $chunkSize)` — returns a `batch_set()` definition with two
  operations (`RemoteSyncBatch::collect`, `RemoteSyncBatch::syncFiles`) and the `finished` callback.

## Batch `RemoteSyncBatch` (`src/Batch/RemoteSyncBatch.php`)

Static methods; `LIST_PAGE_SIZE = 200`.

- `collect($rs_config, $schemes, &$context)` — for each scheme, paginates the source `/list`
  (`offset`/`limit=200`) via `httpGet()` (Guzzle `auth`+`verify`+`http_errors`), accumulating
  every returned `files` entry into `$context['results']['all_files']`. Aborts on config gaps or
  a malformed response (must be an array with a `files` key).
- `syncFiles($overwrite, $chunk, &$context)` — walks `all_files` in chunks. For each entry it
  takes `$f['uri']`, validates the scheme via `stream_wrapper_manager`, optionally skips when the
  local file already exists (`overwrite` off), downloads `/file?uri=…` to a tempfile via
  `httpGetToFile()` (Guzzle `sink`), then `prepareDirectory(dirname($uri), CREATE_DIRECTORY|MODIFY_PERMISSIONS)`
  and `streamCopy(tmp, $uri)` (fopen `wb` on the stream URI). Counts `synced` / `skipped` / `errors`.
- `finished($success, $results, $operations)` — adds a status or error message with the counts.

Both HTTP helpers pass `verify => $verify_ssl` (from config, default TRUE) and put credentials in
the Guzzle `auth` option (Basic Auth header), never in the URL.

## Operating notes

- The destination writes each downloaded file to the `uri` the **source** reported. Writes go
  through Drupal's stream wrapper, so they land under the selected scheme's root.
- Large source trees: `collect()` holds the entire file list (and `listFiles()` on the source
  scans the whole directory) in memory — expect higher memory use on very large filesystems.
- Use `overwrite = FALSE` to top up only missing files; use `chunk_size` to trade speed for
  stability on slow links.
