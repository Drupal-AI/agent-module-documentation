# PDF Reader — manual setup guide

**PDF Reader** (`pdf_reader`) adds a new field display format that renders a PDF
inline as a document viewer, instead of showing a plain download link. Point it
at a field that holds a PDF — an uploaded **File** field, or a plain‑text or
**URI** field containing a PDF's URL — and the file appears embedded on the page,
ready to read.

You choose how the PDF is displayed per field, from several renderers: the
**Google Docs Viewer**, the **Microsoft Office** web viewer, a **direct embed**
using the browser's own native PDF viewer, the bundled **pdf.js** viewer (which
works without any external service), or — if you also have the Colorbox and
Libraries modules — a **Colorbox** lightbox that opens the PDF in an overlay. You
can also set the viewer's width and height, and optionally add a **Download**
link above or below the embedded viewer.

Typical uses are embedding product datasheets on product pages, showing policy or
terms PDFs inline instead of forcing a download, or building a document library
where each uploaded PDF renders as an inline reader. Because the display is
configured per field and view mode, you can use different renderers for a teaser
versus a full page, and swap renderers at any time without touching the stored
file.

PDF Reader has no dependencies beyond Drupal core (Colorbox and Libraries are
optional, only needed for the Colorbox renderer). It defines an "administer pdf
reader" permission but has no central admin settings page — all configuration is
done on the field's display settings.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (plus the optional Colorbox extras).
2. [Configuration](configuration/index.md) — how to apply the PDF Reader format
   to a field and every viewer option, field by field.

## Where it lives in the admin menu

PDF Reader has no menu entry of its own. You configure it inside the **Manage
display** screen of whichever entity holds your PDF field — for example
**Structure → Content types → Article → Manage display**
(`/admin/structure/types/manage/article/display`).

## How to use it

On a **Manage display** screen, find the field that holds your PDF, set its
**Format** to **PDF Reader**, click the gear to choose a renderer and set the
size and download options, then save. The full walkthrough is in
[Configuration](configuration/index.md).
