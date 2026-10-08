# File Metadata Cleaner — manual setup guide

**File Metadata Cleaner** (`file_metadata_cleaner`) removes embedded metadata —
EXIF data, GPS coordinates, author names, device info, and revision history — from
uploaded files, using a bundled **ExifTool** binary. Uploaded images and PDFs
frequently carry this hidden metadata, and it can leak an author's identity, the
camera model, or the exact location a photo was taken. This module strips it out
so that sensitive details never end up stored in your file system or served to the
public.

It can work in two ways. Set to **clean on upload**, it strips metadata
automatically the moment a file is uploaded. It also offers a **manual** "Clean
Metadata" action on a per-file admin page, and an overview page that shows the
current metadata for a file before you clean it. Every processed file is stamped
with a `metadata_cleaned` flag, so you can tell at a glance which files have
already been handled.

Under the hood it wraps the `ahmetburkan/exiftool-binary` Composer package in a
service and a **plugin system** of file-type processors — JPEG, JPG, and PDF
processors ship in the box, and developers can add their own for new formats. The
ExifTool wrapper is defensively coded (it runs the binary through Symfony's
`Process` with an argument array rather than a shell string, rejects path
traversal and shell metacharacters, and enforces a timeout), so there is no
command-injection surface. The feature is admin-only: changing settings requires
the **edit file metadata cleaner settings** permission, and the per-file
read/clean pages additionally require core's **access files overview** permission.

It depends on core's **File**, **User**, and **Views** modules, requires the
ExifTool Composer package to function, and targets Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the ExifTool
   binary with Composer, and enable it.
2. [Configuration](configuration/index.md) — the settings form, the per-processor
   options, the per-file clean action, and the permissions.

## Where it lives in the admin menu

- **Settings** — **Configuration → Media → File Metadata Cleaner**
  (`/admin/config/media/file-metadata-cleaner`).
