# TCPDF — manual setup guide

**TCPDF** (`tcpdf`) is a thin Drupal wrapper around the well-known `tecnickcom/tcpdf` PHP
library for generating PDF documents — including HTML-to-PDF — from your own module code. It is
a **developer API**: there is no admin UI, no settings form, no permissions, and no blocks. You
enable it so that the TCPDF library is available and configured the Drupal way, then you call
its factory function from custom code to build invoices, receipts, certificates, tickets, or
multi-page reports.

The module ships the `tecnickcom/tcpdf` library via Composer and exposes one procedural factory,
`tcpdf_get_instance()`, which returns a fresh `TCPDFDrupal` object (a subclass of TCPDF) with
sensible A4 / portrait / UTF-8 defaults already merged in. From there you use the normal TCPDF
API — `AddPage()`, `writeHTML()`, `Output()` — plus a Drupal-friendly helper,
`DrupalInitialize()`, for quickly setting a title and building a header/footer without
subclassing. Working files are cached under the site's temporary directory
(`temporary://tcpdf/cache`), and a runtime requirements check confirms the library is present
and that cache directory is writable.

Because the module is purely a library wrapper, this guide covers installation and the basic
code pattern rather than clicking through screens. An optional `tcpdf_example` submodule adds a
permission-gated route that streams a sample PDF, which is the quickest way to confirm
everything works and to see the integration pattern.

This guide is written for a **human** developer. If you want terse, token‑cheap references for
an AI coding agent — the full factory signature, the config constants, and override points —
read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and the TCPDF library) with
   Composer, enable it, and optionally enable the example submodule.

## How to use it

There is nothing to configure in the UI. You generate PDFs from PHP:

```php
// Always use the factory instead of `new TCPDF(...)`.
$pdf = tcpdf_get_instance();

// Optional: set a title and a header/footer without subclassing.
$pdf->DrupalInitialize([
  'footer' => ['html' => 'Confidential — page footer'],
]);

$pdf->AddPage();
$pdf->writeHTML($rendered_html);        // HTML-to-PDF
$binary = $pdf->Output('doc.pdf', 'S'); // 'S' = return the PDF as a string
```

`tcpdf_get_instance()` accepts optional parameters to change orientation, page format,
encoding, or to use your own `TCPDFDrupal` subclass and config include — the defaults are A4,
portrait, UTF-8. Page size, margins, fonts, and the cache directory come from the module's
`tcpdf.config.inc`, which only defines each constant *if it is not already defined*, so you can
override any of them by pre-defining the constant earlier. The full list of parameters and
constants is in the [`agent/api/usage.md`](../agent/api/usage.md) doc.

## Where it lives in the admin menu

Nowhere — it has no admin pages of its own. The only visible surface is the optional
`tcpdf_example` submodule's sample-PDF route (see Installation).
