# Opensolr Search — manual setup guide

**Opensolr Search** (`opensolr_search`) gives your Drupal site hybrid AI search —
keyword search blended with vector/semantic search — powered by the hosted
[Opensolr](https://opensolr.com/) service rather than a Solr server you run
yourself. Because the indexing and search happen on Opensolr's infrastructure,
there is no Solr schema to edit, no field mapping to maintain, and no indexing
load on your own server. It depends only on core's **Node** module and runs on
Drupal 10.1, 11, or 12 (PHP 8.1+).

There are two ways to get your content into the index. The **web crawler** visits
your pages from the outside — like a search engine would — and indexes HTML, PDFs,
DOCX, XLSX, PPTX, and ODT documents automatically, with zero load on Drupal. The
**Data Ingestion API** pushes content directly from Drupal (working even behind a
firewall), syncing in real time on every save and delete. You can use either or
both. On top of the index you get AI-generated answers, autocomplete, faceted and
hierarchical drill‑down navigation, spellcheck, query elevation, an analytics
dashboard, multilingual and cross-lingual matching, a multi-site shared index,
and — new in the 5.0 release — **search by image**.

The important thing to understand before you turn it on is that Opensolr is an
**external service that stores a copy of your content**. If you use the crawler,
Opensolr fetches your pages and hosts the resulting index on its servers — so your
content leaves your site (an egress consideration), and the crawler will only find
what it can reach, so make sure genuinely non-public content is not crawlable. The
Data Ingestion path only sends content that an anonymous visitor is allowed to
view (published content that is also not hidden by node-access grants), and
everything indexed is served to anonymous searchers on the search page. The module
authenticates to Opensolr with **API credentials** (your account email + API key)
and per-index **Solr HTTP-auth** credentials, which must be handled as secrets. See
[Configuration](configuration/index.md) for how to enter and store those safely.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your Opensolr credentials,
   choose how you index, and set up the search display, facets, and tuning.

## Where it lives in the admin menu

Everything is under one page with ten tabs at **Configuration → Search and
metadata → Opensolr** (`/admin/config/search/opensolr`): Settings, Data Crawler,
Data Ingestion, Facet Mapping, Search Display, Embeddable, Search Tuning,
Analytics, Elevation, and Filters. The public search page lives at
`/opensolr-search`.

## What changed since 4.1

5.0 is a feature release. The headline additions are **search by image** (a camera
button on the search box reads a photo as CLIP labels, OCR text, or a barcode and
turns it into a search), a **per-search AI (hybrid) toggle** that lets a visitor
switch one search between vector and pure-keyword mode, a **Duration** facet slider,
and richer document results. A behind-the-scenes change first shipped in 4.5:
content that an anonymous visitor cannot view (for example, nodes hidden by
Group, Content Access, or Domain Access grants) is no longer indexed even when
published — so after upgrading you may want to re-crawl or re-ingest to refresh
what is in the index.
