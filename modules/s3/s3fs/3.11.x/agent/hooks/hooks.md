<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alter hooks (`s3fs.api.php`)

Five hooks, all altering AWS SDK parameter arrays. In every one, the file path/key you receive
**includes the prefixes** the module adds — `s3fs-public/` for `public://` files,
`s3fs-private/` for private, plus any `root_folder` — so match on the full key, not the Drupal URI.

## `hook_s3fs_url_settings_alter(array &$url_settings, string $s3_file_path)`

Shapes the external URL for a file. Keys:

| Key | Type | Meaning |
|---|---|---|
| `torrent` | bool | Serve via BitTorrent |
| `presigned_url` | bool | Use a time-limited signed URL |
| `timeout` | int | Seconds until a presigned URL expires |
| `api_args` | array | Extra arguments to `S3Client::getObject()` |
| `custom_GET_args` | array | Extra GET args appended to the URL; keys starting with `x-` are ignored by S3 but appear in access logs |

```php
function mymodule_s3fs_url_settings_alter(array &$url_settings, $s3_file_path) {
  // Sign everything under a contracts/ prefix, 10-second window.
  if (str_contains($s3_file_path, '/contracts/')) {
    $url_settings['presigned_url'] = TRUE;
    $url_settings['timeout'] = 10;
  }
  // Tag requests with the current user for S3 access-log analysis.
  $url_settings['custom_GET_args']['x-user'] = \Drupal::currentUser()->getAccountName();
}
```

This is the programmatic equivalent of the `presigned_urls` / `saveas` / `torrents` config
strings, with full PHP logic available (per-role, per-entity, time-of-day…).

## `hook_s3fs_stream_open_params_alter(array &$stream_params, string $s3_file_path)`

Applied when a stream is opened for reading (`getObject`). The documented use case is
customer-provided server-side encryption:

```php
function mymodule_s3fs_stream_open_params_alter(array &$stream_params, string $s3_file_path) {
  if (str_contains($s3_file_path, 'private/')) {
    $stream_params['SSECustomerAlgorithm'] = 'AES256';
    $stream_params['SSECustomerKey'] = my_secret_key();   // never hard-code
  }
}
```

## `hook_s3fs_upload_params_alter(array &$upload_params)`

Applied to `putObject`. `$upload_params['Key']` is the object key. Typical uses: per-prefix ACLs,
storage class, object tags, SSE-C.

```php
function mymodule_s3fs_upload_params_alter(array &$upload_params) {
  if (str_contains($upload_params['Key'], '/archive/')) {
    $upload_params['StorageClass'] = 'GLACIER_IR';
  }
  $upload_params['Tagging'] = 'site=example&env=prod';
}
```

## `hook_s3fs_copy_params_alter(array &$copy_params, array $s3_key_paths)`

Applied to `copyObject` (also used for renames). `$s3_key_paths` has `from_key` and `to_key`.
With SSE-C you must supply **both** the source decryption key and the destination encryption key:

```php
function mymodule_s3fs_copy_params_alter(array &$copy_params, array $s3_key_paths) {
  if (str_contains($s3_key_paths['from_key'], 'private/')) {
    $copy_params['CopySourceSSECustomerAlgorithm'] = 'AES256';
    $copy_params['CopySourceSSECustomerKey'] = my_secret_key();
  }
  if (str_contains($s3_key_paths['to_key'], 'private/')) {
    $copy_params['SSECustomerAlgorithm'] = 'AES256';
    $copy_params['SSECustomerKey'] = my_secret_key();
  }
}
```

## `hook_s3fs_command_params_alter(array &$command_params)`

Applied to the generic command parameters from `getCommandParams()` — metadata operations such as
`headObject`. If you use SSE-C you must implement this one too, or `file_exists()`/`filesize()`
style calls fail against encrypted objects.

## Practical notes

- **Do not hard-code keys** as the doc examples do. Read them from the Key module or
  `Settings::get()`.
- The hooks fire on **every** matching operation, including inside batch runs
  (`s3fs:copy-local`, `s3fs:refresh-cache`) — keep them cheap and side-effect free.
- If you enable SSE-C via these hooks, implement `stream_open`, `upload`, `copy` **and**
  `command` together; a partial implementation produces objects that can be written but not
  stat'ed or read.
- After adding an implementation: `drush cr`, and consider `drush s3fs:refresh-cache` if the
  change affects how metadata is fetched.
