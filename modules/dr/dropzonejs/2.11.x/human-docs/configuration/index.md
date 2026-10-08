# Configuration

DropzoneJS is deliberately light on admin screens. There is **no dedicated
settings form** — instead a few global settings surface on core's file‑system
page, one permission controls who may upload, and the uploader appears
automatically in the Media Library once everything is in place. This page covers
all three.

## The upload permission

Every Dropzone upload is gated by a single permission, **`dropzone upload
files`**. Grant it on **People → Permissions** (`/admin/people/permissions`) to the
roles that should be allowed to upload. This matters: if a user lacks the
permission, the Dropzone element is hidden entirely and a warning is shown, so an
empty‑looking upload form usually means the permission is missing.

```bash
drush role:perm:add authenticated 'dropzone upload files'
```

## Global settings

The module stores three global settings in the `dropzonejs.settings`
configuration object. There is no standalone form for them — the one you're most
likely to change is exposed on the core **file‑system settings** form at
**Configuration → Media → File system** (`/admin/config/media/file-system`). The
rest are set with Drush.

- **Temporary upload scheme** (`tmp_upload_scheme`, default `temporary`) — the
  stream wrapper that incoming uploads are streamed into before they are validated.
  Set it to `public`, `private`, or `temporary` depending on where in‑progress
  uploads should live.
- **Upload timeout** (`upload_timeout_ms`, default `0`) — a per‑file timeout in
  milliseconds passed to DropzoneJS. `0` means use the library's own default. Raise
  it if users on slow connections upload large files.
- **Filename transliteration** (`filename_transliteration`, default off) — a
  **legacy, deprecated** option that forced ASCII transliteration of filenames on
  older Drupal. Leave it off on modern sites and rely on core's site‑wide
  transliteration instead.

To set the values that aren't on the file‑system form, use Drush:

```bash
drush config:set dropzonejs.settings tmp_upload_scheme private -y
drush config:set dropzonejs.settings upload_timeout_ms 60000 -y
```

## Using Dropzone in the Media Library

You don't have to configure anything special for the Media Library integration —
once the module is enabled, the library is present, and the upload permission is
granted, DropzoneJS automatically **replaces the default add form** for the image,
video, audio, and generic file media sources. Editors adding media through the
Media Library will see the drag‑and‑drop uploader in place of the standard file
input.

## Per‑upload options (for developers)

Beyond these global settings, most of Dropzone's behavior — maximum file size,
allowed extensions, how many files may be dropped at once, and optional in‑browser
image resizing — is configured **per form element** in code, not through the admin
UI, when a developer places the `dropzonejs` element in a form. See the sibling
[`agent/`](../agent/start.md) docs for the element's properties and the upload
services.
