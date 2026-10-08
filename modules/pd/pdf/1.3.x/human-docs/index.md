# PDF — manual setup guide

**PDF** (`pdf`) displays uploaded PDF files *inline* on your Drupal pages using
Mozilla's [pdf.js](https://mozilla.github.io/pdf.js/) viewer — so visitors read a
datasheet, report, or policy document right on the page instead of being forced to
download it or rely on a browser plugin. It does this entirely in the browser, so you
don't need a server-side PDF-to-image pipeline (ImageMagick/Ghostscript).

The module works by adding three new **display formats** for Drupal's core **File**
field:

- **PDF: Default viewer of PDF.js** — embeds the full pdf.js viewer (with page
  navigation, search, and zoom) in an iframe.
- **PDF: Display the first page** — renders page 1 as a canvas thumbnail, perfect for
  a document-library card or a teaser.
- **PDF: Continuous scroll (experimental)** — renders every page stacked for a
  read-through experience (best kept to short documents).

You pick which format to use per field and per view mode on the standard **Manage
display** screen, so you can show a thumbnail in teasers and the full viewer on the
detail page. Each formatter is smart about mixed file fields: it only kicks in for
actual PDFs, and any other file type falls back to a normal download link. There's a
small settings page for pointing the viewer at a re-skinned copy, and one permission
(`administer pdfjs`) guarding it.

**One important requirement:** the pdf.js library is **not bundled** with the module —
you download it and place it under `/libraries/pdf.js/` yourself. Without it, nothing
renders. See [Installation](installation/index.md) for the exact steps. The module
depends only on core's **File** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and set up the required pdf.js library.
2. [Configuration](configuration/index.md) — choosing a formatter per field, its
   viewer options, and the optional custom-viewer setting.

## Where it lives in the admin menu

- You choose a formatter on each bundle's **Manage display** screen (e.g.
  **Structure → Content types → Article → Manage display**).
- The global settings form is at **Configuration → Media → PDF.js**
  (`/admin/config/media/pdfjs`), gated by the **Administer PDF.js** permission.

## How to use it

After installing the module *and* the pdf.js library (see
[Installation](installation/index.md)), add a core **File** field to a content type
(allowing the `pdf` extension), then go to that type's **Manage display**, set the
field's format to one of the three PDF formats, and adjust the options behind the cog.
Full details are in [Configuration](configuration/index.md).
