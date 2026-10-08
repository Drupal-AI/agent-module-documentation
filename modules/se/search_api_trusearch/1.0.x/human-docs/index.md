# Search API TruSearch — manual setup guide

**Search API TruSearch** (`search_api_trusearch`) is a Search API backend that
connects your site to an external, AI-powered hybrid search engine called
TruSearch. Instead of querying a local database, search requests are routed to the
TruSearch engine, which combines keyword (lexical) and semantic (vector) search
and can even generate AI answers directly from your indexed content using
Retrieval-Augmented Generation (RAG).

The module itself is a thin adapter. All the AI, machine-learning, and analytics
work happens inside the TruSearch engine — your Drupal site never calls
OpenSearch, OpenAI, or any third-party AI service directly. Drupal indexes your
content, proxies search requests, and renders the results. On top of plain
results the engine can return AI-generated answers (with inline helpfulness
feedback), structured "generative UI" cards such as step-by-step guides and
ranked lists, an autocomplete widget, a search overlay showing popular and
trending queries, and click/conversion tracking. A circuit breaker degrades
gracefully if the engine is unavailable rather than exposing errors to your
visitors.

This module does **not** work on enable alone — it needs configuration. You must
enter your engine URL, API key, and tenant ID, then set up a Search API server
and index that use the TruSearch backend, and (for the front-end widgets) place
the engine's widget library files into your theme. It depends on **Search API**,
requires **Drupal 10.3 or 11** and **PHP 8.1+**, and provides two permissions:
`administer trusearch` and `view trusearch debug`.

A data-handling note: because indexing and querying are offloaded to an external
service, your content and your visitors' search queries are **sent to the
TruSearch engine**. Store the API credentials securely (the module supports
env-backed credentials), and weigh this external processing before indexing
confidential content. The module is designed so engine panel IDs and API keys
never reach the browser — a short-lived token is issued per request and validated
server-side.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and confirm requirements.
2. [Configuration](configuration/index.md) — enter your engine credentials, set
   up the Search API server and index, register the widget library, and place
   the search widgets.

## Where it lives in the admin menu

The module's own settings form sits under **Configuration → Search and metadata →
TruSearch Settings**. The Search API server and index you connect to it live
under **Configuration → Search and metadata → Search API**.
