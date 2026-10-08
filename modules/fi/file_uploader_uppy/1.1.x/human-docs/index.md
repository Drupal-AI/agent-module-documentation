# File Uploader by Uppy — manual setup guide

**File Uploader by Uppy** (`file_uploader_uppy`) replaces Drupal's plain file input
with the widely used **Uppy** JavaScript uploader — drag-and-drop, upload progress,
image previews, and, most importantly for large files, **chunked, resumable
uploads**. It's the Uppy front end for the
[File Uploader](https://www.drupal.org/project/file_uploader) framework, which
supplies the server side.

The gap it closes is a familiar one. Drupal's stock widget is an
`<input type="file">` and a page submit: no drag target, no progress bar, no preview,
and no recovery when a big upload dies at ninety percent on flaky wifi. Uppy brings
all of that — and because it uploads in chunks, a dropped connection **resumes**
rather than restarting, and a file larger than PHP's `upload_max_filesize` can arrive
in pieces. The module supports several Uppy plugins: the **Dashboard** (the drag-and-
drop UI), the **Image Editor** (inline image editing before upload), **XHR** (the
client-to-Drupal transfer method), and **Internationalisation** (translated UI).

You use it as a **field widget**: on a file field's *Manage form display*, switch the
widget to *File Uploader by Uppy* and configure its options. This release is
**1.1.0**, and it supports **Drupal 9, 10, and 11**.

A word on safety: the actual upload endpoint and its access/validation live in the
`file_uploader` parent module, not here. As with any chunked-upload path, make sure
the field's **own validators** (allowed extensions, size, and number of files) are
set — those are what keep an upload widget from accepting things it shouldn't.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (which brings in
   the File Uploader framework) and enable the module.
2. [Configuration](configuration/index.md) — how to set the Uppy widget on a file
   field and configure its options.

## Where it lives in the admin menu

File Uploader by Uppy has no central settings page. It is a **field widget**, set up
per field at **Structure → *(entity type)* → *(bundle)* → Manage form display**.
