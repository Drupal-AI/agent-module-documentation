# Entity PDF — manual setup guide

**Entity PDF** (`entity_pdf`) turns any content entity into a PDF. Point it at a
node (or any entity) in a chosen view mode and it renders that content to a PDF —
served at a URL, opened in the browser, or streamed as a download. It's the tool you
reach for to produce invoices, tickets, certificates, reports, or a print-ready
export of an article or landing page, all from your existing structured content.

You have full control over how the PDF looks. Rather than dragging your site's
theme (and its CSS/JS) into the document, Entity PDF renders through a single Twig
template, `htmlpdf.html.twig`, that *is* the whole PDF document — so you style it
with inline CSS and get consistent, branded output with no Drupal markup leaking in.
A common pattern is to design a dedicated "pdf" view mode and theme the fields
specifically for print. Filenames are token-based (for example
`[node:title]-[node:nid].pdf`), so each generated file is named from the entity it
came from.

Under the hood the HTML-to-PDF step is pluggable. The default engine is
[mPDF 8](https://mpdf.github.io/), but the rendering engine is a plugin type, so
another module can supply a different PDF back-end. Developers get extension points
too: `hook_mpdf_config_alter()` to tune margins/fonts/page size, and
`hook_entity_pdf_filename_alter()` to change the computed filename per entity. There's
also a **bulk Views/VBO action** ("Entity Pdf Download") that streams a single
multi-page PDF for a set of selected nodes, and a **Display Suite** field that adds a
"Download PDF" link to node view modes.

It depends on core's Node module, requires the `mpdf/mpdf` library (installed via
Composer), and runs on Drupal 9.3, 10, or 11.

This guide is written for a **human** setting the module up through the UI. If you
want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead — they cover the routes, the generator
service, the rendering-engine plugin type, and the full access model in depth.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the mPDF
   library) and enable the module.
2. [Configuration](configuration/index.md) — the settings form field by field, the
   PDF template, and permissions.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → Entity PDF**
(`/admin/config/system/entity_pdf`), gated by the restricted **Administer entity PDF
settings** permission.

## How to use it

Once configured, generate a PDF by visiting the entity's PDF route — for a node,
`/node/pdf/{nid}/{view_mode}` (for example `/node/pdf/5/pdf`), or for any entity type
`/entity_pdf/{entity_type}/{id}/{view_mode}`. Add `?inline=1` to open it in the
browser instead of downloading. You can also add a "Download PDF" link to node
templates via the Display Suite field, or select multiple nodes in a view and use the
bulk **Entity Pdf Download** action to get one combined PDF. See
[Configuration](configuration/index.md) for the settings and permissions.
