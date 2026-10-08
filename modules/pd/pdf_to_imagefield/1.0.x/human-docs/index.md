# PDF to ImageField — manual setup guide

**PDF to ImageField** (`pdf_to_imagefield`) takes an uploaded PDF and converts its
pages into images, storing them in an **image field** on the same content type.
You can use it two ways: generate a single image of the front page to serve as a
preview thumbnail, or generate a gallery of images — one per page — so a whole
document can be shown as page images rather than an embedded PDF.

Unlike a display formatter, this module works as a **file‑field widget**: on the
file field where PDFs are uploaded, you choose the "PDF to Image" widget and link
it to the target image field. When a PDF is uploaded, the module rasterises the
pages and creates real image field items from them — actual attached image files,
not a rendered‑on‑the‑fly preview. Larger documents are processed with Drupal's
**batch** system, and the module also ships **Drush commands** for running
conversions from the command line.

The conversion relies on a server‑side PDF rasteriser (typically **Ghostscript**
and **ImageMagick** via PHP). That is worth noting operationally: rasterising
untrusted PDFs is a known risk area — ImageMagick/Ghostscript "delegate"
vulnerabilities have surfaced over the years — so keep that tooling patched and be
deliberate about who is allowed to upload PDFs. The module requires **PHP 8.3+**
and recommends Drupal 10.3 or newer.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm the PHP and rasteriser requirements.

There is **no central settings page** for this module. You configure it per field
by choosing its upload widget and linking it to an image field, described in "How
to use it" below.

## Where it lives in the admin menu

PDF to ImageField adds no admin settings page. You configure it on a content type
under **Structure → Content types → *(your type)* → Manage fields**, where the PDF
file field's **widget** can be set to "PDF to Image".

## How to use it

1. **Add an image field** to your content type — this is where the generated images
   will be stored. Set its allowed values to **1** if you only want a cover page,
   or **Unlimited** if you want every page generated.
2. **Add a file field** to the same content type and choose **PDF to Image** as its
   **widget**.
3. Configure that file field to accept the **PDF** extension (required). You can add
   the same image extensions as the target field alongside it.
4. When configuring the field, **link the uploaded file field to the target image
   field** so the module knows where to place the generated images.
5. Optionally, apply an **image style** to the image field to control the size and
   display of the generated images, as you would with any image field.

Now, when an editor uploads a PDF, its pages are converted into images in the
linked image field. Processing large documents may take a moment and runs as a
batch. You can also trigger conversions in bulk with the module's Drush commands.
