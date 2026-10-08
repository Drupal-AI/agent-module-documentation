# PDF Slideshow — manual setup guide

**PDF Slideshow** (`pdf_slideshow`) presents a PDF document as a navigable
**slideshow of images** — one image per page — so visitors can browse a PDF
page‑by‑page directly on your site without downloading it. It is a **field
formatter** for file fields: attach a PDF to a file field, switch that field's
display format to PDF Slideshow, and the module converts the PDF's pages into
images and shows them as a slideshow.

Two display options are available on the formatter: the **image size** to render
the pages at, and the **number of pages** to show. Because the module rasterises
the PDF into images, it needs the **`imagick` PHP extension** installed on the
server (see [Installation](installation/index.md)).

The rendered PDF is your own authored content, and access to the underlying file
follows Drupal's normal file access — the module adds no special access rules of
its own beyond its permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm the `imagick` PHP extension is present.

There is **no field‑by‑field settings page** to document — the display options live
on the formatter itself, in the Field UI, described in "How to use it" below.

## Where it lives in the admin menu

PDF Slideshow is set up on a file field's display under **Structure → Content
types → *(your type)* → Manage display**. It also registers an admin route
(`pdf_slideshow.list_controller_list`) under the site's administration section for
its own listing; the day‑to‑day setup, though, happens on Manage display.

## How to use it

1. Make sure the field holding your document is a **File** field that accepts PDFs.
2. Go to **Structure → Content types → *(your type)* → Manage display**.
3. Set that field's **Format** to **PDF Slideshow**.
4. Open the formatter settings (the gear icon) and choose:
   - the **image size** to render the pages at, and
   - the **number of pages** to display.
5. Save. View a piece of content with a PDF in that field — its pages should appear
   as a browsable image slideshow instead of a download link.
