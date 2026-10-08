# PDF Embed View (1.1.x) — manual setup guide

**PDF Embed View** (`pdf_embed_view`) renders PDF files directly on the page
instead of leaving visitors with a bare download link. It is a **display‑layer**
module: you assign one of its display plugins on a field's *Manage display* (or in
a View), pick a display mode, and the PDF renders inline, opens in a modal dialog,
or opens in a new browser tab. It uses the browser's built‑in PDF rendering — no
pdf.js or other external viewer library is required.

This page documents the **1.1.x** line, which is the more capable branch. Where
the earlier 1.0.x branch (documented in its own version folder) offered a basic
File/Media formatter, 1.1.x provides **three distinct display plugins** built on a
single shared theme and one `display_mode` setting:

- **PDF Embed Viewer** — a formatter for **File** fields.
- **PDF Embed Viewer (Media)** — a formatter for **entity reference** fields that
  point at **Media**. It only appears on media reference fields, and it enforces
  that the referenced file is a genuine `application/pdf` and that the viewer has
  permission to see the file.
- A **Views field** plugin, so you can add a PDF viewer column to a listing built
  in Views.

All three respect Drupal's file/media access, and inline mode lazy‑loads the PDF
in an `<iframe>` to keep pages light. There is **no central settings page** — every
option is set where you place the plugin.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and make sure core File (and Media, if you use it) are on.

There is **no configuration page** for this module. You wire it up per‑display on
*Manage display* or in the Views UI, described in "How to use it" below.

## Where it lives in the admin menu

PDF Embed View adds no admin settings page. You use it from:

- **Structure → Content types → *(your type)* → Manage display** — set a **File**
  field's format to **PDF Embed Viewer**.
- **Structure → Media types → *(your type)* → Manage display**, or any entity's
  *Manage display* that has an **entity reference → Media** field — set it to **PDF
  Embed Viewer (Media)**.
- The **Views** UI — add the module's PDF field to a view.

## How to use it

### Embed a PDF from a File field

1. Go to **Structure → Content types → *(your type)* → Manage display**.
2. Set the PDF **File** field's **Format** to **PDF Embed Viewer**.
3. Open the formatter settings (gear icon) and choose a **Display mode**:
   - **Inline** — the PDF is embedded in a lazy‑loaded frame on the page.
   - **Modal** — a "View PDF" link opens the PDF in a large (90% of the screen)
     pop‑up dialog.
   - **New tab** — an "Open PDF in new tab" link opens it in a new browser tab.
4. Save. Note that the File formatter embeds whatever file the field holds, so
   only point it at fields that actually contain PDFs.

### Embed a PDF referenced through Media

Use **PDF Embed Viewer (Media)** on an *entity reference → Media* field (for
example a Document media reference). It resolves the media's source file and only
renders items that are real PDFs and that the current user may view, giving you an
extra layer of safety over the plain File formatter.

### Show PDFs in a View

Add the module's PDF field to a View and set its **display mode** in the field's
options. This is handy for a document library or media listing where each row
shows an inline or click‑to‑open PDF.

> **Theming note:** the markup comes from a single template
> (`pdf-embed-view.html.twig`). To restyle the embed, copy that template into your
> theme and adjust it there — the PDF URL is safely escaped by Twig.
