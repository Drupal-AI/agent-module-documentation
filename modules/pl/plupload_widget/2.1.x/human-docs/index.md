# Plupload file widget — manual setup guide

**Plupload file widget** (`plupload_widget`) replaces Drupal's standard File and
Image upload boxes with uploaders powered by the Plupload JavaScript library. The
payoff is large files: uploads are **chunked** (sent in pieces), so editors can
upload files bigger than a single request would normally allow, with a
client‑side progress indication along the way. Uploads also start as soon as a
file is selected and the form auto‑submits when they finish, for a smoother flow.

The module provides two field widgets built on the underlying **Plupload** module:
`plupload_file_widget` for core **File** fields and `plupload_image_widget` for
core **Image** fields. You switch a field over to one of them on *Manage form
display* — it only changes the *upload UI*, not how the field is stored or
displayed, so you can add chunked uploads to an existing field without migrating
anything.

Chunk size and maximum file size are derived automatically from your server's PHP
limits (`upload_max_filesize` and `post_max_size`), so raising those PHP settings
raises the effective upload ceiling. The field's normal validators (allowed
extensions, size) still apply. The File widget has no settings of its own; the
Image widget adds a single option — the image style used for the upload preview
thumbnail.

It depends on the **Plupload** module (`drupal/plupload`), which wraps the
Plupload library. There is **no global settings form, permission, or Drush
command** — you configure it entirely on the field's form display.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and Plupload) with
   Composer and enable it.

## How to use it

There is no configuration page — you turn the widget on per field.

1. Go to the bundle's **Manage form display** — for example **Structure → Content
   types → Article → Manage form display**.
2. Find a **File** or **Image** field and change its **Widget**:
   - File field → **Plupload file widget** (`plupload_file_widget`).
   - Image field → **Plupload image widget** (`plupload_image_widget`).
3. For the image widget, click the gear icon to set the **preview image style**
   used for the upload thumbnail (optional).
4. Save. That field now uses the Plupload uploader: files upload immediately in
   chunks with a progress indication, and the form submits automatically when the
   upload completes.

Only the widget changes — the field's stored data and its display formatter are
untouched. Because chunk and size limits come from your PHP configuration,
increasing `upload_max_filesize` / `post_max_size` on the server increases the
effective per‑chunk and maximum upload sizes.
