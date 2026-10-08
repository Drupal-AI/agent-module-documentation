<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The download route, access chain & file delivery

## Route

`file_downloader.routing.yml`:

```yaml
download_option_config.download_path:
  path: 'download/{download_option_config}/{file}'
  defaults:
    _controller: '\Drupal\file_downloader\Controller\DownloadOptionPluginController::downloadFile'
  requirements:
    _custom_access: '\Drupal\file_downloader\Controller\DownloadOptionPluginController::access'
  parameters:
    download_option_config: { type: 'entity:download_option_config' }
    file: { type: 'entity:file' }
```

Both slugs are upcast to real entities by param conversion: `{download_option_config}` → a
`download_option_config` config entity (by id), `{file}` → a `file` entity (by numeric fid). A
missing/invalid id yields a 404 before any access or controller code runs — the served path is never
a raw request string.

## Access callback

`DownloadOptionPluginController::access($account, $download_option_config, $file)`
(`Controller/DownloadOptionPluginController.php:47`) delegates to
`$download_option_config->accessDownload($account, $file)` and converts a *neutral* result to
*allowed*. `DownloadOptionConfig::accessDownload()` (`Entity/DownloadOptionConfig.php:120`) enforces,
in order:

1. **Per-option permission** — `$account->hasPermission("use {id} download option link")`; forbidden
   otherwise.
2. **Extension allowlist** — `validFileExtensions($file)`: forbidden unless the file's extension is in
   the option's `extensions` list (or the list is empty = all allowed). Matched via
   `pathinfo($file->getFilename(), PATHINFO_EXTENSION)`.
3. **Plugin access** — `getPlugin()->access($account, $file)`. The base implementation
   (`DownloadOptionPluginBase::access`, line 232) returns forbidden unless
   `$file->access('view', $account)` — i.e. the file entity's own view access. For private-scheme
   files this defers to core file access (references / `hook_file_download`); for public files it
   requires `access content`.

Net effect: a caller must hold the per-option permission **and** be allowed to view the file **and**
(if configured) the extension must match. There is no path/id concatenation and no server-side fetch
of a request-supplied URL.

## Delivery

`downloadFile()` calls `$plugin->deliver($file, $config)`
(`DownloadOptionPluginBase::deliver`, line 65):

```php
$fileUri = $this->getFileUri($file);          // original_file: $file->getFileUri();
                                              // image_style: $style->buildUri($file->getFileUri())
if (!file_exists($fileUri)) { throw new NotFoundHttpException(); }
$scheme = $this->streamWrapperManager->getScheme($fileUri);
return new BinaryFileResponse($fileUri, 200, $this->getHeaders($file, $config), $scheme !== 'private');
```

- The URI is derived from the loaded `File` entity (and, for `image_style`, a server-side image-style
  config value) — never from the request.
- `deliver()` **does not** generate a missing image-style derivative (it 404s instead); the code
  comment notes this is deliberate, to avoid file-id enumeration triggering derivative generation
  (DoS). Derivatives are generated only by the formatter when the field is first displayed
  (`ImageStyle::imageStyleFileExists`).
- The 4th `BinaryFileResponse` arg (`$public`) is `false` for `private://` files, so no public cache
  headers/etag are added for private files.
- Response headers (`DownloadOptionPluginBase::getHeaders`, line 96): `Content-Type` from
  `$file->getMimeType()`, `Content-Disposition: attachment; filename="{name}-{configId}.{ext}"`
  (filename from the stored `File` entity), `Content-Length`, `Content-Transfer-Encoding: binary`,
  no-cache directives, `Accept-Ranges: bytes`. The `image_style` plugin overrides `Content-Length`
  with the derivative's `filesize()`.

## Building a link in code

The formatter builds links with:

```php
$url = \Drupal\Core\Url::fromRoute('download_option_config.download_path', [
  'download_option_config' => $downloadOptionConfig->id(),
  'file' => $file->id(),
]);
if ($url->access()) { /* render link */ }
```
