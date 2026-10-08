# Book PDF — manual setup guide

**Book PDF** (`book_pdf`) prints an entire book to a downloadable PDF. Drupal
core's Book module lets you build hierarchical, multi‑page documentation; this
module adds a route that gathers a book node and all of its child pages, renders
that page tree, and hands the reader back a single PDF file. It depends only on
core's **Book** module and lives in the *Book* package.

The PDF is generated on demand the first time it is requested (and served from a
cache afterward). The module provides its own permission, and it exposes a small
settings form for the PDF output.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and the note about the PDF rendering library.
2. [Configuration](configuration/index.md) — the permission and the PDF
   settings.

## Where it lives in the admin menu

The module adds a *Print to PDF* download route for book nodes rather than a
prominent admin dashboard of its own. Grant its permission at
**People → Permissions** (`/admin/people/permissions`), and see
[Configuration](configuration/index.md) for the PDF settings.

## How to use it

1. Build a book with core's Book module (a book node plus child pages).
2. Enable Book PDF and grant its permission to the roles that should be able to
   export.
3. Follow the module's PDF link/route for a book to download the whole book —
   the book node and its nested pages — as one PDF file.
