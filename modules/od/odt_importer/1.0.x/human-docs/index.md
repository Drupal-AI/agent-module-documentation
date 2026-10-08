# ODT Importer — manual setup guide

**ODT Importer** (`odt_importer`) imports **OpenDocument Text** files — the `.odt`
documents produced by LibreOffice and OpenOffice — straight into Drupal. It reads
the document, converts its content to HTML, and places that HTML into a text field
on a node (article, page, and so on) or any custom entity. It's a fast way for
authors to bring formatted documents into the site without copy‑pasting and
re‑styling by hand.

The conversion covers the common formatting you'd expect: **bold**, *italic*,
underline, blockquotes, headings (h1–h6), links, images (with upload), unordered
lists, and tables (including colspan and rowspan), plus annotations, footnotes, and
spacing. Anything outside that list isn't converted — the feature set above is the
scope.

Because an `.odt` file is really a zip of XML, the module needs PHP's **XMLReader**
and **Zip** extensions (usually present by default on PHP 5+). It depends on core's
Field and File modules and ships in the Fields package.

One data‑handling point worth keeping in mind: the module parses **uploaded
documents**, and the HTML it produces is written into a field. Treat uploads as
untrusted input, and make sure the destination field uses a **text format that
sanitizes on output** (a filtered format, not "Full HTML" for untrusted authors),
so imported markup can't introduce cross‑site scripting when the content is
displayed. The module itself has no access‑control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no central settings page** for this module. You set it up **per field**,
described in "How to use it" below.

## How to use it

ODT Importer works through a dedicated field type. The setup is quick:

1. On the content type or custom entity you want to import into, **add a field of
   type ".odt file importer."**
2. In that field's settings, choose the **Destination field** — an existing text
   field on the same entity that will be populated with the converted HTML.
3. Make sure the destination field's text format **sanitizes on output** (see the
   security note above), so imported markup is safe when rendered.
4. When editing content, upload an `.odt` file to the importer field. On save, the
   module converts the document to HTML and fills the destination field with it.
