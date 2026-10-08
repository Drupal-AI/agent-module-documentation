# Search API Typesense — manual setup guide

**Search API Typesense** (`search_api_typesense`) provides a **Typesense** backend
for Search API, letting you create and manage a Typesense collection directly from
the Drupal admin UI. Typesense is an open-source, typo-tolerant search engine that
gives you instant-search behaviour out of the box, sits comfortably between running
Solr yourself and paying for a hosted SaaS, and has a much smaller operational
footprint than Elasticsearch.

Because it is a Search API backend, the rest of your site does not need to know
anything changed: indexes, fields, processors, Views integration, and facets all
work the way they do with any other backend, and switching backends later is just
configuration. One deliberate design choice to be aware of — the module does
**not** support building a search results page with the Views module the way some
other backends do. That is intentional: the recommended approach is to build the
search experience in the front end, chiefly for speed.

This module does **not** work on enable alone. You need a running Typesense
instance, and you must create a Search API server and index, add fields, and then
complete a required **schema** step from the index's Schema tab before any content
can be indexed. Beyond the basics it also supports synonyms, curations,
stopwords, API-key management, and embedding/semantic search. It depends only on
**Search API** and requires **Drupal 10.3+ or 11**.

Two operational points are worth carrying with you. First, the **Typesense API
key is a credential** with index-write access — keep it out of exported
configuration. Second, the backend is a network service, so decide up front what
your search should do when Typesense is unreachable; a search page that fatals is
worse than one that degrades to a database fallback.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — get Typesense running, install the
   module with Composer, and enable it.
2. [Configuration](configuration/index.md) — create the server and index, define
   the required schema, and manage synonyms, curations, and stopwords.

## Where it lives in the admin menu

Everything is managed under **Configuration → Search and metadata → Search API**:
you create a Typesense **server** and **index** there, and the required **Schema**
tab lives on the index at
`/admin/config/search/search-api/index/{index_name}/schema`. Synonym management is
gated behind its own permission (`administer search_api_typesense synonyms`) so it
can be delegated to whoever understands your content.
