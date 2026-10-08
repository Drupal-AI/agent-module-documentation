# Simple Media Bulk Upload — manual setup guide

**Simple Media Bulk Upload** (`simple_media_bulk_upload`) gives editors a single
drag‑and‑drop form for turning a pile of files into individual Media entities all
at once. Instead of creating each image, PDF, or video as a separate Media item by
hand, you pick a media type, drop dozens of files onto the upload area, and the
module creates one Media entity per file in a single pass.

The upload widget is powered by **DropzoneJS** (a required dependency), so you get
a familiar drag‑and‑drop area with per‑file progress bars. Only media types whose
source is a file — image, document/file, video file, audio file, and so on — are
offered, and the accepted extensions and maximum file size come straight from that
media type's own field settings, so your existing limits are respected.

To keep the upload step fast, required fields on the media type are **not** checked
while you upload. After the batch is created, the module walks you through editing
each new item in turn — so you upload everything first, then fill in alt text,
titles, or other required fields one item at a time in a guided pass.

Convenient "Bulk upload" action links appear on the media admin listing and the
Media Library page, so editors can reach the form in context.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and note its DropzoneJS dependency.
2. [Configuration](configuration/index.md) — the one setting (max files per
   upload) and the permissions that control who can bulk upload.

## Where it lives in the admin menu

The upload form is at **Content → Media → Bulk upload**
(`/admin/content/media/bulk-upload`), and a "Bulk upload" action link also appears
on the Media Library page. The settings form sits at **Configuration → Media →
Simple Media Bulk Upload** (`/admin/config/media/simple-media-bulk-upload`).

## How to use it

1. Enable the module and grant the **`dropzone upload files`** permission to any
   role that should bulk upload.
2. Go to **Content → Media → Bulk upload** and choose a file‑based media type (or
   reach the form with `?media_type=<id>` in the URL to skip the picker).
3. Drag your files onto the drop area and submit. The module creates a Media entity
   per file, then sends you to the edit form of the first one.
4. Fill in each item's fields; saving advances you to the next new item until the
   batch is done.
