# Epub Viewer — manual setup guide

**Epub Viewer** (project `epub_viewer`, but its machine name when you enable it is
`epub_module`) lets visitors **read `.epub` ebooks directly in the browser**. It
adds a field formatter you apply to a file field: for files that are EPUBs it
outputs a link that opens the file in a bundled in-browser reader; other file types
fall back to the normal file link. Everything needed to render EPUBs ships inside
the module, so there is no external JavaScript library to download.

The reader's appearance — background, icon and font colours, and whether a download
icon is shown — is adjustable on a small settings form. If you also have the jQuery
Colorpicker module enabled, the colour fields become colour pickers; otherwise they
are plain text boxes where you type a colour value.

It supports Drupal 9.3, 10 and 11 and has no other module dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Choosing a file scheme.** As with any file field, decide where the uploaded
> `.epub` files live. Public-scheme files are served directly by the web server;
> if you need ebooks whose downloads are permission-checked, store them in a
> **private file scheme** so Drupal enforces access on each download.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (remember: the machine name is `epub_module`).
2. [Configuration](configuration/index.md) — the reader appearance settings, field
   by field.

## Where it lives in the admin menu

The viewer's settings form sits at **Configuration → EPUB → Epub settings**
(`/admin/config/epub/epubsettings`), reachable by users with the *Access
administration pages* permission.

## How to use it

1. Add a **file** field to a content type (or reuse one) that will hold `.epub`
   uploads.
2. On that content type's **Manage display**, set the field's format to **Epub
   Formatter**.
3. Upload an `.epub` file to a piece of content and view it — the field renders a
   link that opens the bundled reader at `/view-ebook/{fid}`.
