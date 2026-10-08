<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audio upload route & controller

## Route
`ckeditor5_audio_plugin.routing.yml`:

```
ckeditor5_audio_plugin.upload:
  path: '/ckeditor5-audio-upload'
  defaults:
    _controller: '\Drupal\ckeditor5_audio_plugin\Controller\AudioUploadController::upload'
  requirements:
    _permission: 'access content'
```

Method: POST (the JS adapter uses `fetch(..., {method:'POST'})`). Returns `application/json`.

## Controller
`src/Controller/AudioUploadController.php` (`AudioUploadController extends ControllerBase`,
`@internal`). Services injected via `create()`: `file_system` (`FileSystemInterface`),
`file_url_generator` (`FileUrlGeneratorInterface`).

`upload(Request $request)`:
1. Reads `file` (uploaded file), `directory` (default `public://`), `max_size` (default `0`) from the request.
2. If no `file` → JSON `{error:'No file uploaded'}` 400.
3. If `max_size` is set and `file->getSize() > (int) max_size` → JSON error 400.
4. `$directory = sprintf('public://%s', trim($directory, '/'));`
5. `fileSystem->prepareDirectory($directory, CREATE_DIRECTORY)` (creates it if missing) — else 400.
6. `$destination = $directory . '/' . $file->getClientOriginalName();`
7. `fileSystem->move($file->getRealPath(), $destination)` (catch → JSON `{error:'File upload failed'}` 400).
8. Returns JSON `{url: fileUrlGenerator->generateAbsoluteString($destination)}`.

## Client contract
The CKEditor button (upload mode) POSTs multipart form fields `file`, `directory`
(from the format's config `directory`), and `max_size` (from config `max_size`); it uses the returned
`url` as the `<audio src>`.

## Operating notes
- The route/controller are the only server-side surface; there is no admin UI page for it and no
  `hook_install`/update hooks (`ckeditor5_audio_plugin.module` only implements `hook_help`).
- The controller performs no file-type/extension checking and honors client-supplied `directory` and
  `max_size` values; operators who expose this format to lower-trust roles should treat the upload
  endpoint like any raw file-write surface and confine the granting text format to trusted editors.
