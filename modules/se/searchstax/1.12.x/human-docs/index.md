# SearchStax — manual setup guide

**SearchStax** (`searchstax`) connects a Drupal site to the **SearchStax** hosted
Solr / SearchStudio Site Search product. It adds a Search API Solr connector for
SearchStax's managed Solr cluster, plus front-end search tracking, analytics, and
auto-suggest that feed back into the SearchStax dashboard.

The module builds on **Search API**. For indexing content into SearchStax's
cloud-hosted Solr you also need **Search API Solr** (`search_api_solr`); with it,
the module provides a Solr connector called **"SearchStax Cloud with Token
Auth"** that authenticates to the managed cluster with a short-lived token rather
than basic auth. Without Search API Solr, the module still works but provides
only search tracking and analytics — no indexing.

Beyond indexing, SearchStax wires the SearchStudio JavaScript tracker into your
search-results pages so query and click analytics flow to the SearchStax
dashboard, with per-role opt-out and optional consent gating through EU Cookie
Compliance. Optional features include SearchStudio auto-suggest (typeahead) via
Search API Autocomplete, re-routing live queries through SearchStudio, a
per-Views relevance-model choice, PDF/office-document text extraction via a
SearchStax Tika extractor, and built-in flood protection that rate-limits search
and update requests per IP. A version-compatibility check confirms the SearchStax
Solr app matches your Drupal major version, and a bundled submodule migrates an
existing Solr server's configuration into SearchStax.

Note that live indexing, analytics, and the version check require a **SearchStax
subscription** and network access to SearchStax. Credentials can be stored as
**Key** entities to keep secrets out of exported config.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, pick the
   optional Search API companions, and enable the module.
2. [Configuration](configuration/index.md) — the settings forms (analytics,
   SearchStudio, flood protection), the Solr connector, and where credentials
   live.

## Where it lives in the admin menu

- **Settings:** **Configuration → Search and metadata → SearchStax**
  (`/admin/config/search/searchstax`), with an **Advanced settings** subpage and
  a **Version compatibility check** subpage.
- **Solr connector:** configured on your Search API **server** at
  **Configuration → Search and metadata → Search API**.
- **Keys:** managed at **Configuration → System → Keys** if you use the Key
  module.

## How to use it

1. Install and enable the module and its companions (see
   [Installation](installation/index.md)).
2. To index content: create a Search API **server** with the Solr backend and
   choose the **SearchStax Cloud with Token Auth** connector, entering your
   SearchStax cluster credentials.
3. Configure site-wide behavior — analytics key, tracking opt-outs, flood
   protection — on the SearchStax settings form (see
   [Configuration](configuration/index.md)).
4. Optionally add auto-suggest, re-route searches through SearchStudio, or run
   the version-compatibility check.
