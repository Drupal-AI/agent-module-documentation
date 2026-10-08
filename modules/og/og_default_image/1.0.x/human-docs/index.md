# OG Default Image — manual setup guide

**OG Default Image** (`og_default_image`) gives your site a single, site‑wide
fallback **Open Graph image** (`og:image`) for the
[Metatag](https://www.drupal.org/project/metatag) module. When someone shares a
link to a page that has no image of its own, social platforms and chat apps —
LinkedIn, Facebook, Slack, WhatsApp, Teams — fall back to this image instead of
rendering a bare line of text.

> **Name note:** in Drupal, "og" usually means *Organic Groups*. Here it stands for
> **Open Graph** — the social‑sharing metadata standard. This module has nothing to
> do with Organic Groups.

The way it works is simple: it adds an image field where you upload one default
picture, and it exposes that image as a Metatag **token** you drop into your Open
Graph image meta tag. Metatag then uses the page's own image where one exists and
falls back to yours where it doesn't. It depends on the Metatag module and adds a
configuration tab under Metatag's own settings, governed by Metatag's `administer
metatags` permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Metatag.

There is **no standalone settings form** — setup happens on a Metatag tab and in
your Metatag defaults, described in "How to use it" below.

## Where it lives in the admin menu

After enabling, a **Default OG Image** tab appears on the Metatag settings page at
**Configuration → Search and metadata → Metatag → Default OG Image**
(`/admin/config/search/metatag/og-default-image`). You need the **Administer
meta tags** permission to reach it.

## How to use it

1. Go to **Configuration → Search and metadata → Metatag → Default OG Image** and
   upload your fallback image. A size of roughly **1200×630 px** is recommended —
   most platforms expect that ratio, and below a minimum size the shared card
   renders small or not at all, so size the image deliberately rather than using
   whatever is to hand.
2. Edit your Metatag defaults (for example the global defaults, or a specific
   content type) at **Configuration → Search and metadata → Metatag**. In the
   **Open Graph → Image** field, insert the token:

   ```
   [og_default_image:og_default_image]
   ```

   Metatag will use a page's own image when it has one and fall back to your
   uploaded default when it doesn't.
3. Save.

> **Heads‑up on caching:** social platforms cache what they scrape aggressively. A
> page that was already scraped without an image keeps its bare card until you ask
> the platform to re‑scrape it (most have a "sharing debugger" that forces a
> refresh). The fallback fixes **future** shares immediately; older shares may need
> a manual re‑scrape.
