# TCPDF — manual setup guide

**TCPDF** (`tcpdf`) is a thin Drupal wrapper around the well-known `tecnickcom/tcpdf` PHP
library for generating PDF documents — including HTML-to-PDF — from your own module code. It is
a **developer API**: there is no admin UI, no settings form, no permissions, and no blocks. You
enable it so that the TCPDF library is available and configured the Drupal way, then you call
its factory function from custom code to build invoices, receipts, certificates, tickets, or
multi-page reports.

Version **3.0** moves to the **TCPDF 7** library family (a compatibility layer over
`tecnickcom/tc-lib-pdf` 8.x) and requires **Drupal 11.3 or newer, or Drupal 12** — Drupal 9 and 10
support has been dropped. Output is close to the 2.x (TCPDF 6) releases but not identical: line breaks
and font metrics can differ slightly.

The module ships the `tecnickcom/tcpdf` library via Composer and exposes one procedural factory,
`tcpdf_get_instance()`, which returns a fresh `TCPDFDrupal` object (a subclass of TCPDF) with
sensible A4 / portrait / UTF-8 defaults already merged in. From there you use the normal TCPDF
API — `writeHTML()`, `Output()` — plus a Drupal-friendly helper, `DrupalInitialize()`, for
quickly setting a title, author, keywords and a logo and building a header/footer without
subclassing (it also adds the first page for you).

A notable 3.0 change is **fonts**: TCPDF 7 does not ship font files, so they have to be built once
(and rebuilt after Composer updates). The status report tells you whether TCPDF finds them. Almost
all other configuration now comes from TCPDF 7's own defaults rather than the module.

This guide is written for a **human** developer. If you want terse, token‑cheap references for
an AI coding agent — the full factory signature, the config constants, the `FontDirectory`
service, and the override points — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and the TCPDF library) with
   Composer, build the fonts, enable it, and optionally enable the example submodule.

## How to use it

There is nothing to configure in the UI. You generate PDFs from PHP:

```php
// Always use the factory instead of `new TCPDF(...)`.
$pdf = tcpdf_get_instance();

// Optional: set a title and a header/footer without subclassing.
// DrupalInitialize() also adds the first page.
$pdf->DrupalInitialize([
  'title'  => 'My document',
  'footer' => ['html' => 'Confidential — page footer'],
]);

$pdf->writeHTML($rendered_html);        // HTML-to-PDF
$binary = $pdf->Output('doc.pdf', 'S'); // 'S' = return the PDF as a string
```

`tcpdf_get_instance()` accepts optional parameters to change orientation, page format,
encoding, or to use your own `TCPDFDrupal` subclass and config include — the defaults are A4,
portrait, UTF-8. In 3.0 the module's `tcpdf.config.inc` sets only the font directory
(`K_PATH_FONTS`, via the `FontDirectory` service) and the image scale ratio; page size, margins
and fonts come from TCPDF 7's own configuration, and you can still override any constant by
pre-defining it earlier (for example in `settings.php`). The full list of parameters and
constants is in the [`agent/api/usage.md`](../agent/api/usage.md) doc.

## Where it lives in the admin menu

Nowhere — it has no admin pages of its own. The only status surface is **Reports → Status report**,
which shows whether the TCPDF library and its fonts are available. The only visible route is the
optional `tcpdf_example` submodule's sample-PDF page (see Installation).
