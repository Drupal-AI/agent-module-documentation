# Media Bulk Upload — manual setup guide

**Media Bulk Upload** (`media_bulk_upload`) lets editors upload many files at once
and turns each one into a media entity, automatically matching every file to the
right media type by its file extension. Instead of creating media items one at a
time, an editor drops in a folder full of images (or PDFs, or a mix) and the module
sorts them out and saves them in a single batch operation.

The heart of the module is a reusable **bulk‑upload configuration** — a small
config entity where you pick which media types the form may create, an optional
media form mode (to expose shared metadata fields), and where files are uploaded.
Each configuration exposes its own upload form. You can have several
configurations, each scoped to a different set of media types — for example a
photo team gets an images‑only form while another team gets a documents form.

On the upload form, the allowed file extensions and maximum file size are derived
from the media types you selected. When an editor submits, the module validates
each file (extension, per‑type size limit, and image resolution for image types),
moves it into the correct target directory, and saves it as a new media entity of
the type whose extensions match. When several selected types share an extension,
the file is assigned to one of them automatically.

Access is controlled by two kinds of permission: a single admin permission for
managing the configurations, and a **separate per‑configuration permission** for
each upload form, so you can hand specific forms to specific roles. A landing page
at `/media/bulk-upload` lists the forms a user may use (and jumps straight to the
form when there is only one).

An optional sub‑module swaps the plain file field for a **DropzoneJS** drag‑and‑drop
uploader.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in
   DropzoneJS), enable it, and optionally add the DropzoneJS sub‑module.
2. [Configuration](configuration/index.md) — create a bulk‑upload configuration,
   grant its permission, and use the upload form.

## Where it lives in the admin menu

- Manage bulk‑upload configurations at **Configuration → Media → Bulk upload
  media** (`/admin/config/media/media-bulk-config`).
- Editors reach their upload forms at **`/media/bulk-upload`** (or a specific form
  at `/media/bulk-upload/{configuration}`). If Admin Toolbar's Extra Tools is
  installed, a **Bulk upload media** entry also appears under **Content → Media**.
