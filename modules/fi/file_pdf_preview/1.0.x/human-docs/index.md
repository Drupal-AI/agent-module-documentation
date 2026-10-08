# File PDF Preview — manual setup guide

**File PDF Preview** (`file_pdf_preview`) is a **field widget** that generates a
preview image from an uploaded PDF. When someone attaches a PDF to a file field,
the module renders that PDF's **first page** as an image and can save it into an
image field on the same entity — so instead of a bare file icon, your content can
show a real thumbnail of what the document looks like.

It does its work server-side using an imaging library, so it has a couple of
requirements beyond Drupal itself: the PHP **Imagick** extension (`ext-imagick`)
must be available on your server, and the module pulls in the
**`spatie/pdf-to-image`** PHP library via Composer. Installing with `composer
require` (below) brings that library in automatically. The module depends only on
core's **File** module.

A note on safety: rendering PDFs server-side means untrusted PDFs are processed by
image tooling (Imagick/Ghostscript), which has historically had security issues.
Keep the underlying image/PDF libraries patched, and treat PDF processing of
uploads from untrusted users with the usual care. The module itself plays no
access-control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (which brings in
   the PDF-to-image library), confirm the Imagick requirement, and enable the
   module.

There is **no separate configuration page** for this module. You set it up on a
field's display, described in "How to use it" below.

## Where it lives in the admin menu

File PDF Preview adds no admin settings page of its own. You use it from
**Structure → Content types (or Media types) → *(bundle)* → Manage form display**,
where you switch a file (or PDF) field to the File PDF Preview widget.

## How to use it

1. Make sure the entity you're working with (a node, a media item, and so on) has
   a **file field** that accepts PDFs, and an **image field** where the generated
   preview can be stored.
2. Go to that bundle's **Manage form display** tab.
3. Set the file field's widget to the **File PDF Preview** widget and configure its
   options — including which image field should receive the generated preview.
4. Save the form display, then create or edit content and upload a PDF. The
   module renders the first page and stores it as the preview image.
