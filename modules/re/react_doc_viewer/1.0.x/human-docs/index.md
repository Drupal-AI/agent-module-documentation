# react doc viewer — manual setup guide

**react doc viewer** (`react_doc_viewer`) displays uploaded document files through
a bundled **React** viewer application, so visitors can preview documents in the
browser without downloading them or leaving the site. It supports a broad range of
formats: images (PNG, JPEG, GIF, BMP, including 360-degree images), PDF, CSV,
XLSX, DOCX, video (MP4, WebM), and audio (MP3).

It has two moving parts that work together:

- A **field formatter** (*Rdv field formatter*) for file fields. Instead of a
  plain download link, it renders a link to a viewer page at `/rdv/{fid}`, which
  mounts the React viewer.
- A **REST resource** (`GET /react-doc-viewer/{fid}`) that returns a file's
  absolute URL and its type by file ID, so the React app knows what to fetch and
  how to render it.

The bundled React build ships with the module (in `js/dist/index.js`), so there is
nothing to compile.

> **Note.** This project's security advisory coverage is **not covered** on
> drupal.org, and it is currently *seeking co-maintainer(s)*. Evaluate it
> accordingly before using it on a production site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it
   alongside core REST, and set the field formatter.

This module has **no central settings form**; setup is a matter of choosing the
formatter and granting permissions, covered below.

## Where it lives in the admin menu

There is no dedicated admin settings page. You configure the viewer on a file
field's **Manage display** (choosing the *Rdv field formatter*), and you manage
who can use it from the standard **People → Permissions** page.

## How to use it

1. Enable the module and core **REST** (see
   [Installation](installation/index.md)).
2. On a file field's **Manage display**, set the field's format to **Rdv field
   formatter**. The field will now show a link to the viewer page instead of a
   plain file link.
3. Grant permissions to the roles that should use it:
   - **Access page file viewer** — controls who can open the `/rdv/{fid}` viewer
     page. (The viewer page itself is also gated by the core *access content*
     permission.)
   - The relevant **RESTful GET** permission for the file-metadata endpoint, so
     the React app (using cookie authentication, same-origin) can fetch each
     file's URL and type.
4. View a piece of content with the file field — following the "view document"
   link opens the in-browser React viewer for that file.
