# Centarro Search — manual setup guide

**Centarro Search** (`centarro_search`) connects Drupal's
[Search API](https://www.drupal.org/project/search_api) to **Elastic Enterprise
Search** (Elastic App Search), so your site's search is powered by Elastic while
you keep building pages, facets, and listings with Drupal's native tooling. Built
by Centarro (the team behind Drupal Commerce), it's aimed especially at Commerce
sites: it lets business users manage synonyms, tune ranking rules, and curate
results — pinning and ordering products at the top of the results for specific
search terms — all through Elastic's modern UI, without code changes. Elastic's
analytics dashboards then show which queries perform and which return nothing.

Technically it provides a Search API **backend**: it indexes your chosen content
and fields directly into Elastic indices and queries against Elastic App Search
engines. Because it goes through Search API and Views, you can build category and
search pages the Drupal way, and it works with facets. It depends on the
**Search API** module and uses Elastic's official Enterprise Search PHP SDK.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

A few important operational notes:

- **You need Elastic.** Either self-host an Elasticsearch/Enterprise Search
  instance or buy an Elastic Cloud subscription — this module is the connector, not
  the search engine.
- **Content leaves your server.** Indexed content and search queries are sent to
  the Elastic endpoint (external egress). Confirm that's acceptable for your
  content, and index into Elastic only what your audience is allowed to see —
  respect Search API's access handling.
- **Credentials are secrets.** The module authenticates to Elastic with an API
  key/credentials over HTTPS. Store them as secrets (environment variable / Key
  entity), never in committed configuration.

This is a beta release (`1.0.0-beta4`), and the project is **not covered by
Drupal's security advisory policy**.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in the
   Elastic PHP SDK) and enable the module and Search API.
2. [Configuration](configuration/index.md) — create a Search API server on the
   Centarro/Elastic backend, connect your Elastic endpoint and credentials, and
   index content.

## Where it lives in the admin menu

Centarro Search adds no settings page of its own — it appears as a backend option
inside Search API at **Configuration → Search and metadata → Search API**
(`/admin/config/search/search-api`), where you add a server and choose the
Centarro/Elastic backend.
