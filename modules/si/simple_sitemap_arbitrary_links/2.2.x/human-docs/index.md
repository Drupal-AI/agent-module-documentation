# Simple XML Sitemap arbitrary links — manual setup guide

**Simple XML Sitemap arbitrary links** (`simple_sitemap_arbitrary_links`) adds an
admin interface for putting *arbitrary* URLs — ones that aren't tied to a Drupal
entity — into your Simple XML Sitemap. The core Simple XML Sitemap module is very
good at listing content it knows about (nodes, taxonomy terms, and other
entities), but it has no built-in way to say "also list this custom path" or "also
list this external-style landing page." This module fills that gap.

Once enabled, it gives you a table where each row is one custom link. For every
link you can set the **URL**, a **priority**, a **change frequency** (daily,
weekly, and so on), a **last-modified date**, and a **language**. Rows are added
and removed with AJAX, so the table updates without a full page reload. You can
type URLs in a few different shapes — `link`, `/link`, or `example.com/link` — and
the module normalizes them for you. When you save, you can optionally trigger a
sitemap regeneration so your new links appear in `sitemap.xml` right away;
otherwise they show up the next time sitemaps are regenerated.

This is an add-on, so it needs the **Simple XML Sitemap** module (`simple_sitemap`,
version 4.x recommended) installed and configured first. Everything it does is
behind a single admin permission — **Administer custom sitemap links** — and it
adds no anonymous or public endpoints. It works on Drupal 10.3 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and grant the permission.
2. [Configuration](configuration/index.md) — manage your custom links, field by
   field.

## Where it lives in the admin menu

Manage your custom links at **Configuration → Search and metadata → Simple XML
Sitemap → Custom Arbitrary Links**
(`/admin/config/search/simplesitemap/custom-arbitrary-links`). The links you add
there are merged into the sitemap output alongside the normal entity URLs.
