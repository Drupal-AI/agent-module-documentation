# Simple XML Sitemap Extensions — manual setup guide

**Simple XML Sitemap Extensions** (`simple_sitemap_extensions`) adds support for
**sitemap index files** to the Simple XML Sitemap module, and lets you configure
which sitemap variants belong to each index. Its main job is breaking one very
large sitemap up into several files that are tied together by an index — which is
what search engines expect once a single sitemap gets big.

The concrete feature you'll reach for most is delivered by its bundled submodule,
**Dynamic Monthly** (`sse_dynamic_monthly`): with it enabled, you can generate
individual sitemap files that list nodes by the month in which they were created.
That's a natural way to split a large, mostly-chronological site (a news archive,
a blog with years of posts) into manageable per-month sitemaps under one index.

You need this module when you use Simple XML Sitemap *and* have a sitemap large
enough that you want to split it into multiple files. If a single sitemap file is
enough for your site, you don't need it. It depends on **Simple XML Sitemap**
(`simple_sitemap`) and works on Drupal 10 and 11. Note that the project is marked
"no further development" and is seeking a co-maintainer, so treat it as stable but
not actively growing.

Permissions for this module are handled by Simple XML Sitemap itself: to do the
setup below you need a user with the **Administer sitemap settings** and
**Administer nodes** permissions. As with any sitemap, only public content should
be advertised.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and turn on the Dynamic Monthly submodule if you want per-month sitemaps.

## How to use it

The setup happens inside Simple XML Sitemap's own screens, and **the steps below
alter your site configuration**, so do them deliberately:

1. If you want per-month sitemap files, enable the **`sse_dynamic_monthly`**
   submodule (see [Installation](installation/index.md)).
2. Go to **`/admin/config/search/simplesitemap/variants`** and add one or more
   variants of type **sitemap index**, for example
   `index | sitemap_index | Sitemap Index` — or several, such as
   `site-a_index | sitemap_index | Sitemap Index Site A` and
   `site-b_index | sitemap_index | Sitemap Index Site B`.
3. Go to **`/admin/config/search/simplesitemap/settings`** and set the default
   sitemap variant to your sitemap index.
4. Go to **`/admin/config/search/simplesitemap/sitemap-index`** and enable the
   variants that should appear on the sitemap index.
5. Save and update your project configuration — new items will have been added —
   then fully regenerate your sitemaps.
