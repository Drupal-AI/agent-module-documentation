# BrightEdge Autopilot Page Publisher — manual setup guide

**BrightEdge Autopilot Page Publisher** (`brightedge_autopilot_page_publisher`)
connects your Drupal site to [BrightEdge](https://www.brightedge.com/) Autopilot
and applies its SEO recommendations to your pages automatically. Specifically, it
updates a page's **Title**, **Meta description**, and **H1** based on the
recommendations BrightEdge Autopilot returns — so the SEO changes BrightEdge
suggests are pushed into your content's metadata without an editor copying them by
hand.

Be aware of what that means in practice: this module **changes the metadata that is
published on your pages** using recommendations fetched from an external service.
That is the point of the module, but it also means you should review how it is
configured and confirm you are comfortable with content being adjusted from
BrightEdge's data before running it against production pages.

It integrates with the **Metatag** module to apply the title and description, and
depends on Metatag, core **Node**, and **Token**. It works across Drupal 8 through
11.

Because it calls the BrightEdge API, you will need BrightEdge API credentials.
Treat those as secrets — see [Installation](installation/index.md) for the
recommended way to store them in an environment variable rather than committing
them to configuration.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, installing with Composer,
   enabling the module, and where to keep your BrightEdge credentials.

## Where it lives in the admin menu

The module defines its own permissions (grant them under **People → Permissions**,
`/admin/people/permissions`) and applies its changes through **Metatag**, whose
own settings live under **Configuration → Search and metadata → Metatag**. Because
it acts on nodes and their metatag/token values, you configure the behavior in the
context of your content types and Metatag defaults rather than through a single
standalone screen.

## How to use it

1. Install and enable the module and its dependencies (see
   [Installation](installation/index.md)).
2. Store your BrightEdge API credentials in an environment variable so they are
   never committed to the repository.
3. With Metatag configured for your content, the module applies BrightEdge
   Autopilot's recommended title, meta description, and H1 to the relevant pages.
   Review the results on a small set of pages before relying on it site‑wide.
