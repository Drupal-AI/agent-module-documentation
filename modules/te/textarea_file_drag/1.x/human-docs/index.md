# Textarea File Drag'n'Drop — manual setup guide

**Textarea File Drag'n'Drop** (`textarea_file_drag`) lets people upload files by
dragging and dropping them onto a plain textarea. When a file is dropped, it is
uploaded in the background over AJAX and the resulting public URL is inserted
into the text — a lightweight way to attach an image, screenshot or document to
a comment or body field without a full media widget.

Under the hood the module decorates textareas with a drop zone (for users who
hold its permission), and the bundled JavaScript posts a dropped file to an
upload endpoint. The controller checks the file's extension against a configurable
allowlist, sanitises the filename, moves the file into a configurable
destination (by default `public://inline`), and returns the generated public URL,
which the script drops into the textarea.

It runs on Drupal 8 through 12, has no other module dependencies, provides a
settings form, and gates everything behind a single permission —
`dragndrop files to textarea` — which controls both the drop zone and the upload
endpoint.

Uploads are checked against an extension allowlist, and **no managed Drupal file
entity** is created (files land directly in the public filesystem and are not
tracked or garbage-collected by Drupal). Grant the `dragndrop files to textarea`
permission only to trusted roles. The [Configuration](configuration/index.md) page
covers the settings in detail.

This guide is written for a **human** setting the module up through the admin
UI. If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the allowed extensions and the
   upload path, and assign the permission safely.

## Where it lives in the admin menu

The settings form is at **Configuration → Media → Textarea File Drag'n'Drop**
(`/admin/config/media/textarea-file-drag`), reachable by users with the
**Administer site configuration** permission. The upload feature itself is
governed separately by the `dragndrop files to textarea` permission.
