# Search API Fusion — manual setup guide

**Search API Fusion** (`search_api_fusion`) is a connector that points **Search API
Solr** at **Lucidworks Fusion** instead of a plain Solr server, and adds a
click-signals endpoint so real user behaviour can feed Fusion's relevance model.
Fusion is Lucidworks' commercial platform built on top of Solr: it speaks the Solr
API but layers on a signals pipeline, machine-learned ranking, and query rewriting.

Because Fusion talks the Solr API, most requests are simply routed to it as if it
were Solr. The exceptions are the interesting parts: **search and autocomplete
queries** are routed to Fusion's Query API, and **signals** are routed to Fusion's
Signals API. The upshot is that an existing Search API index configuration keeps
working — you just change "the Solr server" into a Fusion instance and gain Fusion's
features. Supported capabilities include autocompletion based on Query Pipelines
(via `search_api_autocomplete`), spell checking (via `search_api_spellcheck`),
faceting (via the Facets module), landing pages / promoted results, and request and
click signals.

The distinctive piece is **signals**. Fusion improves ranking by learning which
result a user clicked for which query, and this module exposes a route —
`search_api_fusion/signals/click/{search_api_server}` — that records those click
signals against a configured Fusion server. That endpoint is gated by a **dedicated
permission**, `send signals to any fusion server`, rather than a generic one. That
is the right shape: sending signals is a distinct capability a site grants
deliberately, not something every authenticated user should be able to do by
default. Grant it only to the roles that genuinely need it.

This module only makes sense on a site that **actually runs Fusion** — it is a
connector to a specific commercial product, not a general Solr enhancement. If your
backend is plain Solr, there is nothing for it to connect to. It depends on **Search
API Solr** (`search_api_solr`) and slots into that module's server configuration.

This guide is written for a **human** working through the admin UI. If you are an
AI agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Setup follows the Drupal 8+ workflow from the project's documentation:

1. Enable the module and its requirements (Search API, Search API Solr, plus the
   optional feature modules you want — `search_api_autocomplete`,
   `search_api_spellcheck`, `facets`).
2. Go to **Configuration → Search and metadata → Search API** and **add a server**
   with the **Solr** backend and the **Fusion** Solr connector; provide a Fusion
   app and a search query profile.
3. **Create a search index** based on that server. If your Fusion index is
   populated outside Drupal (via a Fusion index pipeline or another process), you
   may want to mark the Drupal index **read-only**.
4. Build a search View at **Structure → Views**.
5. For autocompletion: enable `search_api_autocomplete`, open your index, click the
   **Autocomplete** tab, and add a **Fusion query profile** suggester.
6. Decide who may send click signals and grant the **`send signals to any fusion
   server`** permission to those roles only.
