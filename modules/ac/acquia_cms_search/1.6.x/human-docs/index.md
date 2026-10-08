# Acquia CMS Search — manual setup guide

**Acquia CMS Search** (`acquia_cms_search`) adds site-wide **search** to an
Acquia CMS site, built on **Search API**. It ships a pre-built search
configuration — an index over the Acquia CMS content types, a search results
page, and **faceted** filtering (via Facets and Facets Pretty Paths) with
autocomplete — so editors and visitors get working search without assembling it
by hand.

It is part of the **Acquia CMS** family and depends on `acquia_cms_common`. One
important caveat: it **expects a configured search index to be present**. In the
full distribution that means Solr; the module also depends on Search API's
database backend (`search_api_db`). Because the configuration references an index,
the module will not enable cleanly unless that index/server is in place — this is
the usual reason it fails to turn on in a minimal setup.

Like the rest of the family this is distribution configuration and glue, best
adopted together with the other `acquia_cms_*` modules rather than cherry-picked.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.
2. [Configuration](configuration/index.md) — make sure a Search API server/index
   exists, index your content, and tune facets.

## Where it lives in the admin menu

Once enabled, the search configuration lives in the standard Search API and
Facets locations:

- **Configuration → Search and metadata → Search API**
  (`/admin/config/search/search-api`) — the server(s) and index it provides.
- **Configuration → Search and metadata → Facets** — the facet definitions.
- The **search results page** it defines (a View) on the front end, plus a search
  block/form.

## How to use it

After the index is built (see [Configuration](configuration/index.md)), visitors
search from the search form and narrow results using the facets in the sidebar.
Editors don't manage search directly — content is indexed automatically as it is
saved, provided the Search API server is available.
