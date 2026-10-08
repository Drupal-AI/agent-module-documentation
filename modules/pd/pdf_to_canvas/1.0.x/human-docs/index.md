# PDF To Canvas Formatter — manual setup guide

**PDF To Canvas Formatter** (`pdf_to_canvas`) displays an uploaded PDF directly on
the page by painting it onto an HTML `<canvas>` element with the **pdf.js**
library, instead of offering a download link or an `<iframe>`. It is a **field
formatter** for **file** fields, so any content type with a PDF file field can show
the document inline with a single formatter change.

The rendering happens entirely **client‑side**: the module hands the browser the
URL of the site's own managed PDF file, and pdf.js draws it onto the canvas. It
does not fetch any remote or user‑supplied URL on the server, so it carries no
server‑side fetching risk — the source is always the file already stored in your
field. It has **no dependencies beyond Drupal core**, no permissions, and no
settings form (the formatter has no options to configure).

Because it uses pdf.js rather than the browser's native PDF plugin, the document
renders consistently across browsers. Note the module supports Drupal 8, 9, and 10
(`core_version_requirement: ^8 || ^9 || ^10`); check compatibility before using it
on Drupal 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** and the formatter has **no options** — you
simply select it on a file field's display, described in "How to use it" below.

## Where it lives in the admin menu

PDF To Canvas adds no admin settings page. You use it from **Structure → Content
types → *(your type)* → Manage display**, where the file field's format dropdown
gains a "PDF to canvas" option.

## How to use it

1. Make sure the field holding your document is a **File** field that contains a
   `.pdf` file — the formatter is designed for PDF files specifically.
2. Go to **Structure → Content types → *(your type)* → Manage display**
   (for example, `/admin/structure/types/manage/article/display`).
3. Set that field's **Format** to **PDF to canvas**.
4. Save. View a piece of content with a PDF in that field — the document should
   render inline on a canvas element instead of showing a download link.
