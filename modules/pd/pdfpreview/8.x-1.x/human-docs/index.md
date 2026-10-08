# PDF Preview — manual setup guide

**PDF Preview** (`pdfpreview`) generates a thumbnail image of the **first page** of
a PDF attached to a node and displays it, so a document shows a real cover image
instead of a generic file icon. It uses **ImageMagick** to rasterise that first
page, and it provides a **PDFPreview field formatter** you set on a file field to
display the thumbnail.

This makes document listings and node pages far more scannable: policy documents,
reports, and brochures each show their own cover, which helps visitors find the
right file. The preview is generated from a PDF the site already stores, so there
is no unusual access concern — access to the underlying file follows Drupal's
normal file handling.

The one setup wrinkle to be aware of is on the server side: recent versions of
ImageMagick ship with a security policy that **blocks reading PDF files by
default**, and you must explicitly allow it before previews will generate. See
[Installation](installation/index.md) for how to enable the ImageMagick module and
adjust that policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module
   and its ImageMagick dependency, and adjust the ImageMagick PDF policy.

There is **no field‑by‑field settings chapter** to document here — you display the
preview by selecting the PDFPreview formatter on a file field, described in "How to
use it" below.

## Where it lives in the admin menu

PDF Preview is applied on a file field's display under **Structure → Content types →
*(your type)* → Manage display**, where the field's format dropdown gains a
**PDFPreview** option. Note that ImageMagick does **not** have to be set as
Drupal's default image toolkit for this module to work.

## How to use it

1. Make sure the field holding your document is a **File** field that accepts PDFs,
   attached to your content type.
2. Go to **Structure → Content types → *(your type)* → Manage display**.
3. Set that field's **Format** to **PDFPreview**.
4. Save. When a node with a PDF in that field is viewed, the module renders a
   thumbnail of the PDF's first page in place of the plain file link.

> If thumbnails do not appear, the most common cause is ImageMagick's PDF policy —
> see [Installation](installation/index.md).
