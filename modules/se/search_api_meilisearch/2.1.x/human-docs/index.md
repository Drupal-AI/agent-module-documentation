# Search API Meilisearch — manual setup guide

**Search API Meilisearch** (`search_api_meilisearch`) connects Drupal's Search API
to [Meilisearch](https://www.meilisearch.com), an open-source search engine
designed to be fast, relevant, and light to run. For a decade the practical Search
API backend choices have been Solr or Elasticsearch — both capable, but both heavy:
a JVM, a schema, and a memory footprint measured in gigabytes. Meilisearch is the
newer, lighter alternative: a single Rust binary with sensible defaults, and with
**typo tolerance and prefix (search-as-you-type) matching turned on by default**
rather than something you configure in. That default matters, because
"search as you type, and forgive my spelling" is exactly the behavior users now
expect and the hardest thing to get right on Solr.

This module supplies the Search API integration. It can create and delete indexes
on the Meilisearch server, index your selected entities, and handle filtering,
sorting, synonyms, and stop words. Two optional submodules cover the features a
site notices immediately if they're missing: **Autocomplete**
(`search_api_meilisearch_autocomplete`, which also needs the Search API
Autocomplete module) and **Facets** (`search_api_meilisearch_facets`, which needs
the Facets module). The base module depends on the **Search API** module and works
on Drupal 9.3+, 10, and 11.

Three things are worth establishing before you commit to it. **Facets and complex
filtering** are historically where lighter engines fall short of Solr, so test your
site's *actual* facet set rather than a simple keyword query. **Scale**: Meilisearch
is designed to hold its index in memory — that's the source of its speed, and it's
why a very large corpus becomes an infrastructure question rather than just a
configuration one. And **access**: the Meilisearch server must not be reachable from
the internet, and the API key Drupal uses should be a **scoped search key, not the
master key**. Exposing the server or using the master key is the standard mistake
with every search engine and the reason unprotected instances turn up in scans.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and pick the submodules you need.
2. [Configuration](configuration/index.md) — point Drupal at the Meilisearch
   server, create the index, and add facets and autocomplete.

## How to use it

Search API Meilisearch appears as a backend option when you add a Search API
server. Once you point it at a running Meilisearch instance and index your content,
you build search pages with Views and — with the submodules enabled — add facets
and autocomplete. See [Configuration](configuration/index.md) for the walkthrough.
