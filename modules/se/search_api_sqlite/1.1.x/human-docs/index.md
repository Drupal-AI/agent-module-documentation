# Search API SQLite FTS5 — manual setup guide

**Search API SQLite FTS5** (`search_api_sqlite`) is a full-text search backend for
Search API built on **SQLite's FTS5** engine. It gives you noticeably better search
relevance and performance than the core Database Search backend, without you having
to install or maintain an external service like Solr or Elasticsearch.

It uses the industry-standard **BM25** ranking algorithm and is designed for small
to medium sites — up to around 500,000 searchable items. The appeal is that the
whole search engine is built into SQLite: there is no extra infrastructure to run,
the technology is proven and ACID-compliant with crash recovery, and it runs
comfortably on limited or shared hosting. It's the right choice when you've
outgrown Database Search's basic ranking but don't want the operational weight of a
dedicated search server.

Beyond ranking, it supports exact **phrase** and wildcard **prefix** search, a
choice of **tokenizers** (Unicode61, Porter stemming, ASCII, or Trigram for
substring search), **faceted search** via the Facets module, **autocomplete** via
Search API Autocomplete, native FTS5 **highlighting**, and "did you mean?" **spell
check** (with the Search API Spellcheck module). For performance it isolates each
index in its own file, uses WAL mode for unlimited concurrent reads,
memory-mapped I/O and auto-optimization.

It's a search backend with no content or access role of its own — result access
follows Search API and entity access as usual. It depends on core's **SQLite**
(`sqlite`) and **Search API** (`search_api`) modules, needs **PHP 8.3+** and a
writable **private file system**, and runs on Drupal 10.3 and 11. This release is
covered by Drupal's security advisory policy.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements (PHP 8.3, private files),
   install with Composer and enable the module.
2. [Configuration](configuration/index.md) — set up the SQLite FTS5 server and
   tune each index's tokenizer and matching mode.

## Where it lives in the admin menu

Everything happens under **Configuration → Search and metadata → Search API**
(`/admin/config/search/search-api`), where you add a server and choose **SQLite
FTS5** as its backend, then point your indexes at it. See
[Configuration](configuration/index.md).
