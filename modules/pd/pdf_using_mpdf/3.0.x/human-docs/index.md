# PDF using mPDF — manual setup guide

**PDF using mPDF** (`pdf_using_mpdf`) turns rendered HTML into downloadable PDFs
using the well‑known `mpdf/mpdf` PHP library. Once enabled, every node gets a
**Generate PDF** tab that renders the node in a view mode of your choice and
streams it as a PDF. Developers also get a reusable conversion service for turning
*any* HTML into a PDF from custom code.

It's a good fit for invoices, certificates, receipts, data sheets, or any
"download this page as a nicely formatted document" feature. A single global
settings page lets you control the output: the filename (with tokens like
`[node:title]`), whether the PDF opens in the browser, downloads, or saves to a
file directory, plus page size, orientation, margins, DPI, document metadata, an
HTML header and footer, a text or image watermark, a password, an optional PDF
template overlay (for letterhead), and where the CSS comes from. Two alter hooks
let other modules rewrite the HTML or the mPDF settings per node.

Access is granted **per content type**: the module creates a `generate <type> pdf`
permission for each node type, so you decide which roles can produce PDFs of which
content.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and the mPDF
   library) with Composer and enable it.
2. [Configuration](configuration/index.md) — the global settings form, field by
   field, plus permissions.

## Where it lives in the admin menu

The global settings form is at **Configuration → User interface → mPDF**
(`/admin/config/user-interface/mpdf`), reachable by users with the **Administer
mPDF settings** permission. The per‑node output is the **Generate PDF** tab on any
node whose type the user is allowed to generate.

## How to use it

1. Set your defaults on the settings form — filename, output mode, page size, and
   so on (see [Configuration](configuration/index.md)).
2. Grant the relevant `generate <type> pdf` permission to the roles that should be
   able to produce PDFs of that content type.
3. Visit a node and click its **Generate PDF** tab to render it.

Developers can bypass the node route entirely and call the
`pdf_using_mpdf.conversion` service (`convert($html, $settings, $context)`) to
convert arbitrary HTML, overriding any setting per call — see the
[agent service docs](../agent/api/service.md).
