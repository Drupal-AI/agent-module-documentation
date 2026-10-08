# Seeds SEO — manual setup guide

**Seeds SEO** (`seeds_seo`) is a starter module that enables and configures a
curated set of SEO modules for the Seeds distribution. It is a convenience
aggregator — an "SEO assistant" that installs and turns on the essential SEO stack
in one step, so a new site starts with search-engine basics already in place.

Good SEO on Drupal usually means enabling and configuring several modules —
metatags, clean URL paths, an XML sitemap, redirects. Seeds SEO bundles that
starting point and applies some baseline configuration. The modules it pulls in
are **Metatag** (`metatag`) with its **Facebook** (`metatag_facebook`) and **Open
Graph** (`metatag_open_graph`) submodules, **Simple XML Sitemap**
(`simple_sitemap`), **Redirect** (`redirect`), **Pathauto** (`pathauto`), **Link
Attributes** (`link_attributes`), and **Length Indicator**
(`length_indicator`). Composer installs them alongside Seeds SEO.

It adds functionality rather than posing a risk. As with the other Seeds starters,
it is an **opinionated bundle**: review which SEO modules it brings and whether
their configuration suits your site — in particular, check the Pathauto URL
patterns and the metatag defaults, since those are the pieces most sites want to
tailor. It is usable as a curated SEO starter on a non-Seeds site too, subject to
that review.

This module has **no configuration screen of its own** — SEO settings live in the
individual modules it enables.

This guide is written for a **human** working through the admin UI. If you want
terse references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   bundle.

## How to use it

There is nothing to configure on Seeds SEO itself. After enabling it, review the
settings of the modules it brought in — Metatag defaults
(`/admin/config/search/metatag`), Pathauto URL patterns
(`/admin/config/search/path/patterns`), the sitemap
(`/admin/config/search/simplesitemap`), and redirects — and adjust them to your
site before going live.
