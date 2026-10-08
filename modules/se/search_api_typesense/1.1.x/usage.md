<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API Typesense turns a self-hosted or hosted Typesense server into a Search API backend, and lets you create and manage the whole Typesense collection — schema, synonyms, curations, stopwords, API keys, embeddings and conversational search — from the Drupal admin UI.

---

Typesense is a fast, typo-tolerant, open-source search engine that sits between running Solr/Elasticsearch yourself and paying for a hosted SaaS: small operational footprint, instant-search behaviour, and optional built-in or provider-backed vector embeddings for semantic search. This module registers a `search_api_typesense` backend plugin so a Search API server points at one or more Typesense nodes, plus a set of Typesense-specific data types (`typesense_string`, `typesense_int32`, `typesense_float`, `typesense_bool`, `typesense_geopoint`, and their `[]` multi-valued variants).

Unlike most Search API backends it does not build search pages through Views; instead it ships a front-end search experience powered by Typesense InstantSearch.js (a "Search block" plugin and an admin Search/Converse preview), which the maintainers consider faster than server-rendered results. Around indexing it adds admin tabs on each Search API server and index for managing the collection's schema (the `typesense_schema` config entity), synonyms, curations (overrides), stopwords, server/scoped API keys, conversation models, metrics, and collection import/export. Embedding fields can be chunked with a configurable document splitter for semantic and conversational ("Converse") search backed by Typesense's built-in models or an AI-module provider (OpenAI / LiteLLM).

---

- Add Typesense as a Search API backend for an existing index instead of Solr, Elasticsearch or the database backend.
- Run a self-hosted Typesense server (Docker, bare metal, or the `lussoluca/ddev-typesense` DDEV add-on) and connect Drupal to it.
- Point Drupal at Typesense Cloud or another hosted Typesense endpoint using one or more node definitions.
- Configure a nearest-node (geo load-balanced) endpoint with automatic failover for multi-region Typesense clusters.
- Expose a separate public endpoint host/port/protocol for browser-side InstantSearch traffic distinct from the server-side admin connection.
- Get typo-tolerant, instant search results as the user types, without building a Views-based search page.
- Define the Typesense collection schema per index (field types, facet, sort, index, store, infix, stem, locale, weight) through the Schema admin tab.
- Provide a required numeric sort field so results can be ordered, as Typesense requires.
- Place a configurable "Search block" that renders an InstantSearch UI over one or more collections.
- Run federated (multi-index) search across several collections at once when their facet fields match.
- Manage query-time synonyms (one-way and multi-way) per collection from the Synonyms tab.
- Curate/override specific queries to pin or hide documents using Typesense overrides (Curations tab).
- Manage stopword sets on the server and apply them to searches.
- Create, list and delete Typesense API keys (including search-only and scoped keys) from the admin UI.
- Use a search-only API key in the front end so the read-write admin key never reaches the browser.
- Enable vector embeddings on selected fields for semantic search, using Typesense's built-in models or an AI-module provider.
- Chunk long field values with a fixed-length document splitter (configurable chunk size and overlap, with fields prepended to every chunk).
- Run conversational ("Converse") search against a collection using a Typesense conversation model.
- Import and export a collection's synonyms and curations (optionally including the schema) as JSON for staging-to-production moves.
- View live collection metrics, server health and version from the server Metrics tab.
- Delegate synonym, curation and stopword administration to non-server-admins via dedicated permissions.
- Alter the generated collection name or the schema before it is sent to Typesense through dispatched events.
