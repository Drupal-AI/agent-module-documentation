# Entity Print integration with TypeSet.sh — manual setup guide

**Entity Print integration with TypeSet.sh** (`entity_print_typeset`) adds a
`typeset` PDF **print engine** to the
[Entity Print](https://www.drupal.org/project/entity_print) module, so entities
can be rendered to PDF using the commercial
**[typeset.sh](https://typeset.sh)** HTML‑to‑PDF library instead of the default
engines (Dompdf, wkhtmltopdf). typeset.sh is a high‑fidelity PHP renderer aimed
at print‑quality output — useful for invoices, certificates, and reports.

Entity Print hides PDF generation behind swappable engine plugins, and this
module contributes one more. Once the typeset.sh library is installed, the
*Typeset.sh* engine becomes available wherever Entity Print lets you pick an
engine; from then on your existing Entity Print print links and routes produce
typeset.sh‑rendered PDFs (A4 paper).

Two things to know before you start. First, typeset.sh is a **paid library**:
you need a valid subscription, and you install it by adding typeset.sh's private
Composer repository (with your access token) to your project's `composer.json`
and requiring the package — see [Installation](installation/index.md). Second,
the maintainer describes the module's own state as **between experimental and
proof‑of‑concept**, so evaluate it before relying on it in production. It depends
on **Entity Print** and supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — add the paid typeset.sh Composer
   repository, require the library, install this module, and enable it.

There is **no configuration page** for this module — it has no settings of its
own (only A4 output is offered). You simply select the *Typeset.sh* engine in
Entity Print, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no settings page. You choose the engine through Entity Print's
own settings at **Configuration → Content authoring → Entity Print**
(`/admin/config/content/entityprint`).

## How to use it

1. Install the paid typeset.sh library and this module (see
   [Installation](installation/index.md)).
2. Go to Entity Print's settings and select **Typeset.sh** as the PDF engine.
3. Use your normal Entity Print print links to export entities; the PDF is now
   rendered by typeset.sh as an A4 document (viewable inline or forced to
   download through Entity Print's usual flow). Developers can also retrieve the
   raw bytes programmatically via Entity Print's `getBlob()`.
