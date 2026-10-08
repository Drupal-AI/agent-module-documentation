<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# hook_download_file_headers_alter

The only hook the module invites (`download_file.api.php`). Called in the download controller just
before the `BinaryFileResponse` is built, so you can add/replace/remove any response header on a
per-file basis.

```php
/**
 * @param array $headers                    Response headers (mutable, by reference).
 * @param \Drupal\file\FileInterface $file  The file being served.
 */
function hook_download_file_headers_alter(array &$headers, FileInterface $file): void {
  $headers['Expires'] = 0;
}
```

Example — different caching for PDFs, and opt into `X-Sendfile` for large files:

```php
function mymodule_download_file_headers_alter(array &$headers, \Drupal\file\FileInterface $file): void {
  if ($file->getMimeType() === 'application/pdf') {
    $headers['Cache-Control'] = 'private, max-age=0, must-revalidate';
  }
}
```

Notes:
- Runs for every direct download; keep it cheap.
- The starting `$headers` already contain the forced-download set from the controller (see
  [../api/download-route.md](../api/download-route.md)); your changes win because the alter runs
  last.
