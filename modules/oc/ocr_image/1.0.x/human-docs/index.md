# OCR image, document parser — manual setup guide

**OCR image, document parser** (`ocr_image`) reads the text out of an uploaded
image or document and drops that text into a field automatically. Upload a scanned
JPG, PNG, or TIFF and the module runs OCR on it; upload a PDF, Word, Excel, or
PowerPoint file (`doc`, `docx`, `xls`, `xlsx`, `ppt`, `pptx`, `pdf`) and it
extracts the document's text content. The result can populate an image field's
**title** and **alt** text, a file field's **description**, or any **text field**
you map — which makes otherwise‑opaque uploads searchable and filterable, including
through Views.

A key selling point is that it does this **without an external OCR service**. Image
OCR runs through [Tesseract](https://github.com/tesseract-ocr/tesseract) installed
on your own server, and document parsing uses PHP libraries the module pulls in via
Composer. There are no API keys to manage and no third‑party service to send your
files to — the trade‑off is that you must install Tesseract on the host and make
sure PHP is allowed to run it.

It also supports bulk backfilling: with **Views Bulk Operations**, you can select
existing images and run "Update empty image text (Image OCR)" across them. And for
developers, it exposes services (`ocr_image.OcrImage`, `ocr_image.DocParser`) you
can call from your own code.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install Tesseract, then install the
   module with Composer (which pulls in the parsing libraries) and enable it.
2. [Configuration](configuration/index.md) — switch your image/file field to the
   OCR widget on *Manage form display* and choose its options.

## Where it lives in the admin menu

There is no central settings page. You configure OCR **per field**, on the
**Manage form display** tab of whatever content type or entity holds your image or
file field — see [Configuration](configuration/index.md). Because OCR runs on
uploaded files server‑side, make sure the Tesseract tooling is appropriately
resourced and that only trusted roles can upload the files you'll process.
