# File Metadata PDF — manual setup guide

**File Metadata PDF** (`file_mdm_pdf`) is a plugin for the **File Metadata
Manager** (`file_mdm`) module that teaches it to read metadata from **PDF files**.
Once enabled, File Metadata Manager can extract PDF properties — page count,
dimensions, title, author, and similar fields — so that other modules on your site
can use them.

It does its work through the `smalot/pdfparser` PHP library, which is why the
module **must be installed with Composer**: Composer is what brings the parser
library in. There is nothing to click and no settings screen — enabling the module
simply registers the PDF plugin with File Metadata Manager, and PDFs are read
through it from then on.

A couple of things worth knowing: uploaded and managed files are untrusted input,
and this module **parses PDF files**, so run it in a trusted, up-to-date
environment and rely on keeping the parser library current. PDF files themselves
continue to follow Drupal's normal core file access; the module adds no
access-control behaviour of its own. And be aware that on certain PDFs
`smalot/pdfparser` can hit memory issues generating very large character tables —
this affects only some files and may need a patch depending on your usage.

It depends on the **File Metadata Manager** module (`file_mdm`) and targets Drupal
11.2.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its PDF parser
   library) with Composer and enable it.

There is no configuration page for this module — it registers a PDF reader plugin
with File Metadata Manager and needs no settings.
