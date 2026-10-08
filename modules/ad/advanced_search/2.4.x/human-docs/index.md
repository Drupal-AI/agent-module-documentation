# Advanced Search — manual setup guide

**Advanced Search** (`advanced_search`) provides an **Advanced Search block** and
a set of enhancements that sit on top of your existing search stack, giving
visitors a richer entry point than a bare keyword box. A single search field is
fine until people need to narrow by more than words — by content type, a date
range, a category — and building that yourself means wiring together facets, a
facets summary, and a search form into one coherent block. This module packages
that assembly so the richer search UI is a ready-made component instead of a
bespoke build.

It is not a standalone search engine. It sits on a real search stack and depends
on the **Facets**, **Facets Summary**, and **Search API Solr** modules — so it is
for sites that are already running Search API against a Solr index. The block
*enhances* a Solr-backed index; it does not provide one. That dependency set is
the thing to have working first.

For a content-heavy site where visitors need to filter as much as they search, it
turns a pile of search-related configuration into a single block you can place.
Because the block surfaces whatever Search API and Facets are configured to
expose, confirm your index actually offers the facets you want to present.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and satisfy its Search API / Facets / Solr dependencies.

## Where it lives in the admin menu

Advanced Search adds its **Advanced Search block** to Drupal's block system. You
place and configure it under **Structure → Block layout**
(`/admin/structure/block`), like any other block. Its behaviour is driven by the
underlying Search API index, Facets, and Facets Summary configuration, which you
manage under **Configuration → Search and metadata**.

## How to use it

1. Get the foundation working first: a **Search API** index backed by **Solr**,
   with **Facets** (and optionally **Facets Summary**) configured to expose the
   filters you want — content type, date, category, and so on.
2. Enable Advanced Search.
3. Go to **Structure → Block layout**, place the **Advanced Search** block in the
   region where you want the search UI to appear, and configure it.
4. Visit the page as a user — the block presents the search form together with
   faceted narrowing and a summary of the active filters, so visitors can search
   and then refine their results.

Because the block reflects your Search API and Facets setup, the filters it offers
are exactly the ones your index is configured to provide — adjust the underlying
facets to change what appears.
