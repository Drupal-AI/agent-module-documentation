<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Download route, controller & access

## Route

`download_file.download_file_path` (`download_file.routing.yml`):

- Path: `/download/file/{file}`
- `{file}` upcast with `type: entity:file` — the segment is a **numeric file id**, loaded to a
  `File` entity by Drupal's param converter (never a raw path string).
- Controller: `DownloadFileController::downloadFileDirectDownload`
- Access: `_custom_access: '\Drupal\download_file\Controller\DownloadFileController::access'`

Build a link with `Url::fromRoute('download_file.download_file_path', ['file' => $fid])`.

## Access

The access callback is one line:

```php
public function access(AccountInterface $account, FileInterface $file): AccessResultInterface {
  return $file->access('download', $account, TRUE);
}
```

It delegates entirely to core's File access handler for the `download` operation. In core
(`FileAccessControlHandler`): **public**-scheme files return `AccessResult::allowed()` (public files
are directly reachable at their own URL anyway); **private**-scheme files are allowed only if the
caller can `view` a referencing entity+field, or is the file's owner. The module adds no permission
and no bypass — download access equals whatever core grants for that file.

## Controller / response

`downloadFileDirectDownload(FileInterface $file): BinaryFileResponse`:

1. Starts from `file_get_content_headers($file)` (core helper: `Content-Type`, `Content-Length`,
   `Cache-Control` for the file's mime type).
2. Overrides with forced-download headers: `Content-Type: application/octet-stream`,
   `Content-Disposition: attachment; filename="<getFilename()>"`, `Content-Length` (`getSize()`),
   `Content-Transfer-Encoding: binary`, `Pragma: no-cache`,
   `Cache-Control: must-revalidate, post-check=0, pre-check=0`, `Expires: 0`,
   `Accept-Ranges: bytes`.
3. Fires `hook_download_file_headers_alter($headers, $file)` (see
   [../hooks/headers-alter.md](../hooks/headers-alter.md)).
4. Returns `new BinaryFileResponse($file->getFileUri(), 200, $headers)`.

The file URI comes from the loaded `File` entity (`getFileUri()`), so nothing request-supplied
reaches the filesystem. Bytes stream through PHP/Symfony (no web-server `X-Sendfile` unless you add
that header via the hook).
