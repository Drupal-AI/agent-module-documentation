# Entity Print Browserless PDF — manual setup guide

**Entity Print Browserless PDF** (`entity_print_browserless_pdf`) adds a new PDF
**print engine** to the [Entity Print](https://www.drupal.org/project/entity_print)
module that offloads PDF generation to a remote **Browserless** instance — a
hosted or self‑hosted headless‑Chrome service. Instead of rendering PDFs with a
local PHP library (like Dompdf or wkhtmltopdf), your site sends its own
Entity‑Print HTML to the Browserless endpoint over HTTP, and Browserless returns
a high‑fidelity PDF rendered by a real Chrome browser.

This is useful when you want modern CSS support (flexbox, grid, web fonts) in
printed PDFs without installing and maintaining Chrome on your web server. Page
selection, print links, routing, and access control all continue to come from
Entity Print itself — this module only supplies the engine and the connection to
Browserless.

The module needs configuration before it will do anything: you must point it at a
Browserless endpoint and (for hosted/paid Browserless) provide an access token.
It depends on **Entity Print** and supports Drupal 10 and 11. The endpoint and
token are set on Entity Print's settings form — see
[Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it and
   Entity Print.
2. [Configuration](configuration/index.md) — select the engine and configure the
   Browserless endpoint and token.

## Where it lives in the admin menu

You configure the print engine through Entity Print's own settings at
**Configuration → Content authoring → Entity Print**
(`/admin/config/content/entityprint`). This module adds the *Browserless* engine
choice and its connection fields there.
