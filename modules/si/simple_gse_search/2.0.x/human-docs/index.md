# Simple GSE Search — manual setup guide

**Simple GSE Search** (`simple_gse_search`) puts a **Google Programmable Search
Engine** (formerly Google Custom Search) on your Drupal site, so search results come
from Google's index of your pages rather than from Drupal's own search. You create a
Programmable Search Engine on Google's side, paste its ID into a settings form, place
the search block, and you are done — Google handles crawling, relevance ranking, and
typo tolerance for you.

There is a real case for this. Drupal's core search is weak, and running Search API
with a Solr backend is a substantial piece of infrastructure for a small site.
Google has already crawled your public pages and needs no indexing pipeline at all,
so for a brochure site, a documentation site, or anything mostly public, this is a
cheap, low‑maintenance way to get usable search. The module works by embedding
Google's JavaScript search widget and rendering results inside a themed Drupal page.
It depends only on Drupal core and supports a wide range of versions.

**Three constraints are worth stating up front**, because they decide whether this
module fits your site at all:

- **Results are limited to what Google has indexed.** Brand‑new content lags until
  Google re‑crawls, unpublished content never appears, and anything behind a login is
  invisible — so this cannot power an intranet or a members‑only area.
- **Cost and branding.** The free Programmable Search tier shows Google branding and
  has query limits; the paid tier is billed per thousand queries.
- **Privacy.** Search terms are sent to Google. On a site where queries could be
  sensitive, note that data flow in any privacy assessment.

One more practical detail: the results page claims the path **`/search`**, which is
also core Search's path. On a site with core Search enabled the two collide, so the
module's own documentation recommends uninstalling core's Search module (or moving
one of them).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter your search engine ID, place the
   block, and control who can reach the results page.

## Where it lives in the admin menu

The settings form sits at **Configuration → Search and metadata → Simple GSE
Search** (`/admin/config/search/simple_gse_search`), behind the *administer gse
search* permission. The search results themselves are served at **`/search`**,
gated by a separate *access gse search page* permission.
