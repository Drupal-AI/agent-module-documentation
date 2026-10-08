# Simple XML Sitemap — manual setup guide

**Simple XML Sitemap** (`simple_sitemap`) generates standards‑compliant XML
sitemaps that tell search engines which pages on your site exist and how often
they change — a foundational piece of SEO. It builds a
[sitemaps.org](https://www.sitemaps.org/)‑compliant sitemap that you turn on **per
entity type and per bundle** (content types, taxonomy terms, users, menu links,
and more), with per‑bundle control over crawl `priority` and `changefreq`. On
multilingual sites it automatically adds `hreflang` alternate links so Google
serves the right language to each visitor.

This guide is written for a **human** clicking through the admin UI. It walks you,
step by step and with screenshots, from installing the module to choosing exactly
which content ends up in your sitemap and regenerating it. Everything lives under
**Configuration → Search and metadata → Simple XML Sitemap**
(`/admin/config/search/simplesitemap`). The finished sitemap is served at
`/sitemap.xml`. If you are looking for terse, token‑cheap references for an AI
coding agent instead, read the sibling [`agent/`](../agent/start.md) docs.

![The Simple XML Sitemap status screen with the sitemap list and regeneration controls](images/status.png)

## What you get out of the box

Enabling the module gives you a single **Default** sitemap of type *Default
hreflang*. It starts empty — nothing is indexed until you enable an entity type on
the **Entities** screen. Once you enable content and regenerate, its URLs appear in
`/sitemap.xml`.

The module also supports multiple named sitemaps ("variants"), sitemap indexes for
very large sites, custom off‑entity links added by path, and background
regeneration on cron.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and find where the sitemap is served.
2. [Configuration](configuration/index.md) — the **Settings** tab: cron
   regeneration, generation interval, XML styling, base URL, and more.
3. [Choosing which content is included](choosing-content/index.md) — the
   **Entities** tab, per‑bundle inclusion, priority and changefreq, then
   regenerating and viewing your sitemap.

## Where it lives in the admin menu

Go to **Configuration → Search and metadata → Simple XML Sitemap**
(`/admin/config/search/simplesitemap`). The screen has two top‑level tabs:

- **Sitemaps** — with sub‑tabs **Status** (the landing page above), **Types**, and
  **Settings**.
- **Inclusion** — with sub‑tabs **Entities** and **Custom links**.

Administering these screens requires the **Administer sitemap settings**
permission.
