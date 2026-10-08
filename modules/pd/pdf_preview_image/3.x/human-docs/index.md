# PDF Preview Image — manual setup guide

**PDF Preview Image** (`pdf_preview_image`) automatically turns the first page of
an uploaded PDF into a real image and stores it in an image field on the same
content type. Instead of a document library full of generic file icons, you get
cover thumbnails that show what each PDF actually is. It describes itself as a
light version of the *PDF to Image Field* module: it generates one preview image
(the first page) into an image field, rather than a gallery of every page.

The generation happens on the server, so it needs a PDF‑rendering toolkit
installed: the **`spatie/pdf-to-image`** PHP package plus **ImageMagick (Imagick)**
and **Ghostscript** on the host. See [Installation](installation/index.md) for how
to add these.

Setup is done per field, not on a global settings page. On a **File** field that
accepts PDFs you tick a "PDF preview autogeneration" checkbox and point it at the
image field where the generated preview should be stored. Because the toolkit
rasterises PDFs that people upload, keep ImageMagick and Ghostscript reasonably
current — PDF and image parsers have had security issues over the years, and
current tooling is the right precaution when processing uploaded files.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the
   `spatie/pdf-to-image` library, and confirm the ImageMagick/Ghostscript
   requirements.

There is **no central settings page** for this module. You enable the preview
per‑field on the File field's settings, described in "How to use it" below.

## Where it lives in the admin menu

PDF Preview Image adds no admin settings page. You configure it on a File field
under **Structure → Content types → *(your type)* → Manage fields → *(your PDF
file field)***, where a "PDF preview autogeneration" option appears in the field
settings.

## How to use it

1. On your content type, make sure you have an **image field** where the generated
   preview will be stored. If you don't have one yet, add it first
   (**Manage fields → Add field → Image**).
2. Add (or edit) a **File** field for the PDF, and under **Allowed file
   extensions** include `pdf`.
3. At the bottom of that File field's settings, tick **Pdf preview
   autogeneration**.
4. Choose the **image field** where the preview image should be saved (the image
   field from step 1).
5. Save the field settings. From now on, when an editor uploads a PDF to that
   field, the module renders the first page and stores it as the preview image
   automatically.
