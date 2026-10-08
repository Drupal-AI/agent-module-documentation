# Simple Sitemap Page Manager — manual setup guide

**Simple Sitemap Page Manager** (`simple_sitemap_page_manager`) connects the Simple
XML Sitemap module to **Page Manager** (Panels) pages, so the custom-routed pages
you build with Page Manager can be included in your XML sitemap. Ordinarily Simple
XML Sitemap knows about entities like nodes and terms, but a Page Manager page is a
custom route rather than an entity — which means it would otherwise be invisible to
the sitemap and, by extension, to search engines. This module closes that gap.

Once enabled, it adds a new tab to the sitemap settings that lists every Page
Manager page you've marked for indexing. And in each Page Manager page's own
settings — on the *General* tab — you get controls to decide whether that page
should be indexed, and if so, its **priority** and **change frequency**. The module
also respects the language conditions set on a page's *Page access* tab: if a page
is restricted to certain languages, only those languages are indexed (they're the
only ones a visitor can reach); if there's no language condition, all of the site's
languages are listed.

This module depends on **Panels** (`panels`) and **Simple XML Sitemap**
(`simple_sitemap`) — this 2.0.x release is meant for Simple Sitemap 4.x — and works
on Drupal 9, 10, and 11. Sitemap inclusion is entirely admin-configured; the module
adds no content of its own and has no access-control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

After enabling, open any Page Manager page's configuration and look at the
**General** tab: tick to have the page indexed in the sitemap, then choose its
priority and change frequency. To review everything at once, use the new tab that
appears in the Simple XML Sitemap settings, which lists all Page Manager pages
configured for indexing. Remember that a page's language conditions (on its **Page
access** tab) determine which languages of that page appear in the sitemap.
