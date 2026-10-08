# Printable — manual setup guide

**Printable** (`printable`) generates printer‑friendly versions of your Drupal
content entities — and, with its **printable_pdf** submodule, downloadable PDFs.
It gives each enabled entity a stripped‑down "Printable" render (a clean, themeable
page without the site chrome) reachable at a dedicated URL, plus **Print** and
**PDF** links you can show on the content itself or in a block.

The way it works: for every entity type you enable (nodes, comments, and users by
default) Printable adds a route like `/node/{nid}/printable/print`, which renders
the entity through a **print format** using dedicated templates and a special
`printable` view mode. With the PDF submodule enabled and a PDF toolkit configured,
a second format streams a PDF at `/node/{nid}/printable/pdf`. Print/PDF links are
injected into entity output automatically, and there is also a **Printable Links
Block** you can place in a region.

Printable is configuration‑driven — enabling it exposes the settings, but you
decide which entity types are printable, where the links appear, how in‑content
links are handled in print output, and (for PDF) which toolkit, paper size, and
orientation to use. It depends on the **PDF API** module (`pdf_api`) and the
`wa72/htmlpagedom` PHP library (both pulled in by Composer) and on core's
`path_alias`. Two permissions gate it: **administer printable** and **view printer
friendly versions**. Developers can extend it with two plugin types — output
**formats** and in‑content **link extractors**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and (for PDF) the `printable_pdf` submodule.
2. [Configuration](configuration/index.md) — choose printable entity types, place
   the links, tune print and PDF output, and set permissions.

## Where it lives in the admin menu

The settings live at **Configuration → User interface → Printable**
(`/admin/config/user-interface/printable`), with sub‑forms for the Print format,
the PDF format, and where the Print and PDF links appear. Each printable entity is
reachable at `/{entity_type}/{entity}/printable/{format}` — for example
`/node/12/printable/print` or `/node/12/printable/pdf`.

## How to use it

After enabling, grant the **view printer friendly versions** permission to the
roles (or anonymous) who should see printable pages, pick which entity types are
printable, and choose where the Print/PDF links show. Visitors can then click a
Print or PDF link on your content — or visit the printable URL directly — to get a
clean printable page or a PDF download. See
[Configuration](configuration/index.md) for the full walkthrough.
