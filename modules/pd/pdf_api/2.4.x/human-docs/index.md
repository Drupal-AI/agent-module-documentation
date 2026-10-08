# PDF API — manual setup guide

**PDF API** (`pdf_api`) is a backend-agnostic API for turning HTML into PDF
documents from Drupal code. Rather than tying your site to one PDF library, it
defines a `PdfGenerator` plugin type with four bundled backends — **dompdf**,
**mPDF**, **TCPDF** and **wkhtmltopdf** — so calling code can build a document once
and swap the rendering engine without changing. It is the engine that popular
export modules such as **Entity Print / Printable** build on, and most sites drive
it through those rather than calling it directly.

For developers, the workflow is: load a generator from the plugin manager, feed it
HTML (with optional headers, footers, orientation and paper size), then emit the
result — save it to a file, stream it inline to the browser, or send it as a named
download. Each backend wraps a Composer PDF library that ships with the module, so
once the module is installed the libraries are already present. If none of the four
suits you, you can register your own backend as a `PdfGenerator` plugin.

The only bundled admin UI is a **Dompdf settings** form at **Configuration → System →
PDF API**, which tunes the default dompdf backend — its font, DPI, rendering engine,
security toggles (inline PHP / JavaScript / remote assets), filesystem roots, and a
set of debug flags. Those settings apply to the dompdf backend only; the other three
backends do not read them. The module renders nothing on the front end itself and
defines no permissions of its own (the settings form uses core's *Administer site
configuration*). An optional **puphpeteer** submodule adds a fifth headless-Chrome
backend and is off by default because it needs Node.js and the Puppeteer library.

This guide is written for a **human** — a site builder installing the module and a
developer wiring it into code. If you want terse, token-cheap references for an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its PDF
   libraries) with Composer, enable it, and the optional submodule.
2. [Configuration](configuration/index.md) — the Dompdf settings form, field by
   field.

## Where it lives in the admin menu

The module's single settings page is at **Configuration → System → PDF API**
(`/admin/config/system/pdf-api`), gated by core's **Administer site configuration**
permission. It configures the **dompdf** backend only. All other use of the module
is from code — see the sibling
[`agent/api/generate-pdf.md`](../agent/api/generate-pdf.md) doc for generating a PDF,
and [`agent/plugins/pdf-generator.md`](../agent/plugins/pdf-generator.md) for adding
your own backend.
