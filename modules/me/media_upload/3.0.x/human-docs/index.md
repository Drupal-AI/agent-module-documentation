# Media Upload — manual setup guide

**Media Upload** (`media_upload`) adds a bulk **drag‑and‑drop upload form** to
Drupal that turns many uploaded files into media entities in a single action.
Instead of adding media items one form at a time, an editor drops a folder's worth
of files onto one page and the module creates a media entity for each — routing
every file to the right media bundle (image, video, document, or audio) based on
its file extension. It is built on **DropzoneJS** for the upload widget and core
**Media** for the resulting entities.

The problem it solves is the tedium (and, for migrations, the impossibility by
hand) of importing dozens or hundreds of assets into Drupal's media library. Each
file is matched to a configured media bundle, named after its base filename,
size‑checked, and saved into that bundle's configured file directory. Per‑file and
whole‑batch size limits protect the server, and files that fail (wrong extension
or too large) are reported while the valid ones still import.

Media Upload needs configuration before it is useful: you must first tell it which
media bundle each file type should go into, on its settings form. It also requires
that you already have suitable media bundles and their file fields set up. Access
is permission‑gated — the upload form needs the **`upload media`** permission (plus
DropzoneJS's own permissions), and the settings form needs **`administer
media_upload configuration`**.

> **Security note.** This module is **not covered by Drupal's security advisory
> policy**, and the final write uses the (DropzoneJS‑sanitised) filename without an
> additional `file_munge_filename()` pass — so safety rests entirely on the allowed
> extensions configured on your target media fields. **Do not allow executable or
> HTML‑type extensions** (for example `php`, `phtml`, `html`, `svg`) on the media
> fields that accept uploads.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, pull
   in DropzoneJS and Media, and enable it.
2. [Configuration](configuration/index.md) — map each file type to a media bundle
   and set the size limits on the settings form.

## Where it lives in the admin menu

- The **settings form** is at **Configuration → Media → Media upload**
  (`/admin/config/media/upload`), behind the **`administer media_upload
  configuration`** permission.
- The **bulk upload form** for editors is at `/media/upload`, behind the
  **`upload media`** permission.

## How to use it

Once configured, an editor with the `upload media` permission goes to
`/media/upload`, drags files onto the DropzoneJS area (or clicks to browse), and
submits. For each file the module reads the extension, finds the media bundle you
mapped it to, checks it against the per‑file and total size limits, writes the file
into that bundle field's configured directory, and creates a media entity named
after the file. After submission you get a count of how many files were imported
and how many were skipped.
