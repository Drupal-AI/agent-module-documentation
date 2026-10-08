# Media Library Bulk Upload — manual setup guide

**Media Library Bulk Upload** (`media_library_bulk_upload`) adds a "Multiple
upload" screen to Drupal's Media Library, so editors can drop many files at once
and turn each into a media entity of a chosen type — instead of adding them one
at a time.

Unlike the older `media_bulk_upload` module, this one ships **no extra JavaScript
library** (no DropzoneJS). It reuses Drupal core's standard file‑upload widget and
the Media Library UI itself, so the experience looks and feels exactly like the
Media Library your editors already know, with nothing extra to theme or maintain.
A landing page lists every media type the current user is allowed to bulk‑upload;
pick one and you get the media library scoped to that type with unlimited
cardinality, ready for a whole batch in a single pass.

Access is fine‑grained: the module generates a per‑type permission of the form
`use media {type} bulk upload form`, so you can, for example, let a photographer
role bulk‑upload only Image media and nothing else. A small settings form lets you
optionally limit which media types are offered site‑wide. When Admin Toolbar
Extra Tools is present, the module also nests its link under Content → Media in
the toolbar.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — limit which media types are offered,
   and the per‑type permissions that control who can bulk‑upload.

## Where it lives in the admin menu

The bulk‑upload landing page is at **Content → Media → Bulk upload**
(`/admin/content/media/bulk-upload`), which also links from the Media admin
listing. The settings form is at **Configuration → Media → Media Library Bulk
Upload** (`/admin/config/media/media-library-bulk-upload-config`).

## How to use it

Grant the relevant `use media {type} bulk upload form` permissions to your editor
roles (see Configuration). Then an editor visits the bulk‑upload landing page,
which lists the media types they may upload, picks a type, and drops a batch of
files into the familiar Media Library upload form — each file becomes a media
entity of that type.
