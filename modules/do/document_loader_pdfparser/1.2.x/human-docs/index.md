# Document Loader: PDF Parser — manual setup guide

**Document Loader: PDF Parser** (`document_loader_pdfparser`) is a **loader plugin
for [Document Loader](../../../document_loader/2.0.x/human-docs/index.md)** that
extracts text and content from **PDF files**. It uses the pure-PHP
`smalot/pdfparser` library, so it needs no external service and no system binaries —
just PHP — which makes it a lightweight way to pull text out of PDFs and feed them
into content or AI pipelines.

Given a PDF (referenced by its file URI), the plugin can produce several output
shapes: plain **text**, semantic **HTML**, or **Markdown** (HTML converted to
Markdown). It can also retrieve **metadata** from the PDF such as page count and
author. Because it plugs into Document Loader, once enabled it simply becomes one of
the available loaders — anything built on Document Loader can ask for a PDF to be
loaded and get back normalized output.

This is a web-services / developer feature with **no admin form and no permissions
of its own**; it is configured through Document Loader and driven in code. One
data-handling note worth keeping in mind: PDF parsing runs on **uploaded or
supplied files**, so treat input PDFs as **untrusted** — malformed files can stress a
parser, and extracted content may itself contain sensitive data. Keep the parser
library patched.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in the
   `smalot/pdfparser` library) and enable the module.

There is **no configuration page** for this module. After enabling it, the PDF
Parser plugin appears at **Configuration → Media → Document Loader**
(`/admin/config/media/document-loader`); there is no per-plugin form to fill in.

## Where it lives in the admin menu

The plugin is visible in the Document Loader configuration at **Configuration →
Media → Document Loader** as an available loader. It adds no settings page of its
own — set it as the handler for the PDF loader type on Document Loader's own
settings page if needed.
