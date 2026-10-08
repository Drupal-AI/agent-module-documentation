# Soapbox PDF — manual setup guide

**Soapbox PDF** (`page_to_pdf`) generates high‑quality PDF versions of your page
content. It reads a node's rendered page and produces a PDF that preserves the
content and broad look of the site, but adjusted for the PDF format so it reads and
prints well. Behind the scenes it uses **Puppeteer** (headless Chrome) via a managed
**PDF generator service** to render the page, and the open‑source **Paged.js**
library to break the content into a print‑friendly grid (header, sides, footer, and
body).

Importantly, the module handles the **infrastructure** — connecting to the PDF
service, generating the file, and saving it to a field on your node. Preparing the
content for print is up to you as a developer: configure the node's PDF display
appropriately (for example, replace videos, accordions, and other non‑print content
with fallbacks, and add front/back covers as desired).

Because rendering runs through a managed service, you do not need to install a
headless browser on your own server — which makes it a good fit for hosts where you
do not control the server. The maintainers recommend **Doppio.sh** as the provider
(low cost, no server configuration); **Browserless.io** is also supported.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — store the PDF service API key, create a
   field to hold the PDF, and enable Page to PDF on a content type.

## Where it lives in the admin menu

Setup happens in three places: the PDF service **API key** goes in your
`settings.php`; you add a **field** to store the generated PDF on the content type
(**Structure → Content types → *(type)* → Manage fields**); and you enable Page to
PDF on that content type, selecting the field as the target. See
[Configuration](configuration/index.md).
