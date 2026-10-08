# Simple Sitemap Pagination URL — manual setup guide

**Simple Sitemap Pagination URL** (`simple_sitemap_pagination_url`) changes how
Simple XML Sitemap splits and names a large sitemap. Google's rules cap a single
sitemap at 50,000 URLs or 50 MB, so big sites have to break their sitemap into
several files referenced by a sitemap index. Out of the box, Simple XML Sitemap
paginates using a query string — `sitemap.xml?page=1`, `sitemap.xml?page=2`, and so
on — and Google **does not** support paginated sitemap indexes that use query
parameters. Google Search Console flags this as a "nested indexing error," and the
practical result is missed pages and inconsistent crawling.

This module fixes that by splitting a large sitemap into multiple **physical `.xml`
files** — `sitemap-1.xml`, `sitemap-2.xml`, and so on — and generating a sitemap
index (`sitemap.xml`) that references them correctly, in the distinct-file form
Google expects. That eliminates the nested-indexing error and lets Googlebot
discover and crawl every page, keeping large sites SEO-compliant.

It depends on **Simple XML Sitemap** (`simple_sitemap`) and works on Drupal 10 and
11. It's a behind-the-scenes configuration enhancement — it adds no content and has
no access-control role; the fix is in how sitemap files are named and served.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There's nothing to click through for the core behaviour — once the module is
enabled alongside Simple XML Sitemap and your sitemaps are (re)generated, the large
sitemap is written out as separate `sitemap-1.xml`, `sitemap-2.xml`, … files with a
correct `sitemap.xml` index pointing at them. Regenerate your sitemaps after
enabling, then check `sitemap.xml` to confirm it references the distinct files.
