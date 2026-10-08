# Files Upload — manual setup guide

**Files Upload** (`files_upload`) provides a simple file‑upload system for your
site — a UI for uploading and managing multiple files, as an alternative or
complement to core's own file handling. Enable it and you get a dedicated files
area under **Content** where you can upload several files at once and manage them.

It is a content‑editing convenience, not an access‑control tool. As with any upload
feature, its safety rests on Drupal's **server‑side upload validation**: restrict
the allowed **file extensions**, enforce sensible size limits, store sensitive or
non‑public files in the **private** file system so they can't be served or executed
directly, and restrict who is allowed to upload. Files Upload does not add an
access model of its own beyond that.

Files Upload works on **Drupal 8.9, 9, 10, and 11** and has no module
dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

This module has **no dedicated settings form** — you use it directly from the
Content area described below. Its behaviour is governed by standard Drupal file
handling (allowed extensions, size limits, and file system), so tune those through
core's usual field and file‑system settings.

## Where it lives in the admin menu

Once enabled, the upload area lives under **Content** at
**`/admin/content/files`**. That is where you upload and manage files.

## How to use it

1. Go to **`/admin/content/files`**.
2. Use the upload controls there to add one or more files.
3. Manage the uploaded files from the same page.

Because the module leans on core's file handling for validation, make sure your
allowed extensions and size limits are set appropriately and that anything
sensitive is stored privately — see [Installation](installation/index.md) for the
safe‑setup checklist.
