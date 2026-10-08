<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Download route, controller, permission, hooks

## The route & controller

```
file_download.link:
  path: '/file-download/download/{scheme}/{fid}'
  defaults: { _controller: '\Drupal\file_download\Controller\FileDownloadDownloadController::deliver' }
  requirements: { _access: 'TRUE' }   # file access is enforced inside the controller / hooks
```

`FileDownloadDownloadController` extends core `\Drupal\system\FileDownloadController`. `deliver()`:

1. Loads the file entity by `{fid}`; 404 if missing.
2. Compares `{scheme}` to the file's **actual** stream wrapper scheme; throws 403 "Invalid file scheme."
   on mismatch (you can't pass `public` to grab a `private` file).
3. 404 if the file doesn't exist on disk.
4. Invokes `hook_file_download($uri)` on all modules; if any returns `-1`, throws 403 (honours core
   private-file access control).
5. Streams a `BinaryFileResponse` with headers forcing a download:
   `Content-Type: <mime>`, `Content-Disposition: attachment; filename="<name>"`,
   `Content-Length`, `Content-Transfer-Encoding: binary`, no-cache `Pragma`/`Cache-Control`/`Expires`,
   `Accept-Ranges: bytes`.
6. If `file_download_counter` is enabled and its `count_downloads` setting is on, increments that
   file's counter.

The link URL is built in `template_preprocess_download_file_link()` as
`internal:/file-download/download/<scheme>/<fid>` (scheme derived from the file URI, e.g. `public`).

## Permission

`access file download` (`file_download.permissions.yml`, description "The user can download files.").
Grant it to roles that should be able to hit the download route. Note the route itself is
`_access: 'TRUE'`; real gating comes from this permission being checked in your access setup plus the
core `hook_file_download` hooks for private files.

## Theme hooks

- `download_file_link` — variables `file`, `title`, `description`, `size`, `raw_size`, `attributes`;
  template `download-file-link.html.twig`. Used by `file_download_formatter`.
- `download_file_title` — variables `title`, `attributes`; template `download-file-title.html.twig`.

`template_preprocess_download_file_link()` sets the link render array, MIME `type` attribute, and
file icon classes (`file`, `file--mime-…`, `file--<icon class>`).

## Token

`hook_token_info()`/`hook_tokens()` (named `file_download_token_info` / `file_download_tokens`) add a
**`file:type`** token: the short form of the MIME type (the part after `/`, e.g. `pdf` for
`application/pdf`). Useful in the formatter's `custom_title_text`, e.g. `Download ([file:type])`.

## Programmatic download URL

```php
use Drupal\Core\Url;
$url = Url::fromUri('internal:/file-download/download/' . $scheme . '/' . $file->id());
// $scheme e.g. 'public' or 'private'; $file is a \Drupal\file\Entity\File
```
