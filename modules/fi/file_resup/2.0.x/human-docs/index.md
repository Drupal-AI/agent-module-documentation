# File Resumable Upload — manual setup guide

**File Resumable Upload** (`file_resup`) upgrades Drupal's ordinary file-field upload
into a chunked, resumable, drag-and-drop experience. It lets editors upload very large
files — well beyond PHP's per-request `upload_max_filesize` / `post_max_size` limits —
by slicing each file into small chunks and streaming them one at a time. If a connection
drops or the browser is refreshed mid-upload, the transfer picks up where it left off
instead of starting over. Editors can also drag-and-drop several files at once and watch a
live progress bar.

It doesn't replace or add a field type. Instead, you turn it on **per file field**: tick
*Enable resumable upload* in that field's settings, and the module layers its chunked
uploader onto whatever file widget the field already uses. Uploads still respect the
field's storage scheme (public or private), destination directory, and allowed extensions;
in-progress chunks are held in a private, `.htaccess`-protected temporary directory until
the real form is submitted and the file is assembled and validated.

The module depends only on core's **File** module. It has a small global settings page and
a per-field settings section, plus a permission that controls who can reach the settings
form. A submodule, **File Resup Media Library** (`file_resup_media_library`), brings the
same resumable behavior to the Media Library "Add media" upload form.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable it, and
   add the Media Library submodule if you need it.
2. [Configuration](configuration/index.md) — the global settings page, the per-field
   *Resumable Upload Settings*, the chunk-size option, and the permission.

## Where it lives in the admin menu

- **Configuration → System → File Resup settings**
  (`/admin/config/system/file-resup-settings`) — the global settings form.
- **The field settings / edit form of any file field** — the per-field *Resumable Upload
  Settings* section (this is where you actually switch resumable upload on for a field).
- **People → Permissions** — the *Administer file resup* permission that gates the settings
  form.

## How to use it

Once installed, resumable upload stays off until you enable it on a specific field:

1. Go to the file field you want to enhance (for example **Structure → Content types →
   Article → Manage fields → your file field**) and open its settings/edit form.
2. In the **Resumable Upload Settings** section, tick **Enable resumable upload**.
3. Optionally set a **Maximum upload size** for the field and turn on **Start upload on
   files added** for hands-free auto-upload.
4. Save the field.

From then on, editors using that field get chunked, resumable, drag-and-drop uploading with
a progress bar. See [Configuration](configuration/index.md) for every setting in detail.
