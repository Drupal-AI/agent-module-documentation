# Search API Manticore — manual setup guide

**Search API Manticore** (`search_api_manticore`) lets you use
[Manticore Search](https://manticoresearch.com) — a fast, lightweight,
open-source full-text search engine — as the backend behind Drupal's Search API.
It connects to Manticore over the engine's HTTP JSON API and is built as a thin,
well-tested wrapper around the official `manticoresoftware/manticoresearch-php`
SDK. Once configured, you index any Search API datasource into Manticore, build
search pages with Views, and add facets with the Facets module, just as you would
with any other Search API backend.

Manticore is aimed at sites that have outgrown database search but don't want the
operational weight of a Java-based stack: it has a low memory footprint, columnar
storage, both SQL and JSON APIs, and deploys as a single binary. Beyond classic
keyword search it also does **semantic and hybrid search** — matching by meaning
using Manticore's native vector embeddings, either on their own or fused with
keyword relevance, all configurable in Views with no custom code. Notably,
Manticore generates those embeddings itself from local sentence-transformer models
at index and query time, so **Drupal never computes or transmits a vector and no
external embedding API or API key is involved**; the models run on CPU without a
GPU.

The module supports the standard Search API feature set — facets (including the OR
operator and per-element counts on multi-value fields), autocomplete, More Like
This (fulfilled by vector similarity), random sort, full-text search through Views
and the query API, all six built-in field types, filtering, and sorting.
Spellcheck, grouping, and location data types are not supported yet. It depends on
core's **Key**, **Language**, and the **Search API** modules, provides its own
permission, and works on Drupal 10.5+ and 11.

**Credentials note.** Manticore's HTTP Basic Auth password is kept in a **Key
entity** (using Key's configuration, file, or environment providers) rather than in
exported configuration — so your search credentials never end up committed to your
site's config. For write-path integrations, the module also fires six lifecycle
events (pre/alter/post around both indexing and deletion) that other modules can
subscribe to; these are documented in the project README.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.
2. [Configuration](configuration/index.md) — store the credentials in a Key,
   create the Manticore server, and set up your index.

## How to use it

Search API Manticore appears as a backend option when you add a Search API server.
After you point it at your running Manticore instance and index your content, you
build search pages with Views and facets with the Facets module, exactly as with
any Search API backend. See [Configuration](configuration/index.md) for the setup.
