# Simple Sitemap XML — manual setup guide

**Simple Sitemap XML** (`simple_sitemap_xml`) generates an XML sitemap
(`/sitemap.xml`) directly from your Drupal content types or menus, so search
engines can discover and index your pages. It aims to sit between a bare
menu-based sitemap tool and a full-blown SEO suite: you get flexible control over
what's included and how it's prioritised, without much configuration overhead.

You choose a **generation mode**. In the default *content types* mode (new in
1.1.0) the sitemap is built from the content types you select, with control over
node status (published, unpublished, or both). In the legacy *menu-based* mode it's
built from any Drupal menu, following the menu hierarchy. Priorities can be set five
ways — one value for everything, per content type, by menu depth, custom per-URL,
or a mixed strategy that combines them intelligently. Each URL's `lastmod` uses the
actual node changed date for accuracy, you can exclude specific URLs (with wildcard
patterns), and the output is human-readable in a browser thanks to XSL styling.
Results are cached for an hour with automatic invalidation.

The module needs only Drupal core — specifically the core **Menu Link Content**
module (`menu_link_content`) — and works on Drupal 9, 10, and 11. One thing to keep
in mind: a sitemap **advertises URLs** to crawlers. It doesn't grant anyone access,
but listing a URL invites crawling, so use the status filtering and URL exclusions
to keep unpublished, private, or admin paths out of it. It pairs well with the
Metatag and Pathauto modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose the generation mode, sources,
   priorities, and exclusions.

## Where it lives in the admin menu

Configure it at **Configuration → Search and metadata → Simple Sitemap XML
Settings** (`simple_sitemap_xml.settings`). Your sitemap is then served at
`/sitemap.xml`.
