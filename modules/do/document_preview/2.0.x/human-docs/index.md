# Document Preview — manual setup guide

**Document Preview** (`document_preview`) lets visitors **preview office and PDF
documents right in the browser** instead of downloading a file just to see what's
inside. It supports `.pdf`, `.doc`, `.docx`, `.xls`, `.xlsx`, `.ppt`, `.pptx`, and
`.txt`, and renders them by embedding the **Google Docs viewer**. It provides a
custom **field formatter** with two display styles — a **Simplebox** (inline) and a
**Modal window** — and a custom **"Document" block type** for placing previews on
your pages or in Layout Builder.

It depends only on core's **Field** and **File** modules, so there is little to
install beyond the module itself. There is no settings form: you configure it by
choosing the **Document Preview Formatter** on a file field's display, exactly the
way you would set any other field formatter.

**Read this privacy caveat before using it.** Because the preview is rendered by the
**Google Docs viewer**, the document's URL is handed to **Google**, which fetches and
renders the file. That has two consequences: the document must be **publicly
reachable** (Google has to be able to download it), and its **content is processed by
Google's servers**. Do **not** use Document Preview for confidential or private
documents — for those, use a self-hosted viewer instead. Also note a practical
limitation: because Google must reach the file, **the viewer does not work on local
environments** (a URL like a DDEV `.ddev.site` address is not publicly reachable).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form. You set
it up on a field's display and by placing a Document block, as described below.

## Where it lives in the admin menu

Document Preview adds no admin settings page. You use it from **Structure → Block
types** (to create a Document block) and from the **Manage display** tab of the field
whose file you want to preview.

## How to use it

The typical setup places a document field on a custom block and formats it with the
Document Preview formatter:

1. Create a media type (for example "File") that holds your document file, if you do
   not already have one.
2. Set the **Document Preview Formatter** on the file field (on the relevant
   **Manage display**), and choose the display style — **Simplebox** or **Modal
   window**.
3. Create a custom **block type**, add a field of your media type to it, and allow the
   document formats you need (`.pdf`, `.doc`, `.docx`, `.xls`, `.xlsx`, `.ppt`,
   `.pptx`, `.txt`).
4. Add the block to a page or place it with **Layout Builder**.

Because rendering relies on the Google Docs viewer, make sure the uploaded files are
publicly accessible (and remember previews will not render on a local-only
environment), and only use this for documents that are safe to expose to Google.
