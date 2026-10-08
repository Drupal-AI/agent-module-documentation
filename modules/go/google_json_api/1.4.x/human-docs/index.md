# Google JSON API — manual setup guide

**Google JSON API** (`google_json_api`) lets you build Drupal **search pages** whose
results come from a **Google Programmable Search Engine** (formerly Custom Search)
via its JSON API, presented through core Search with familiar paging and term
highlighting. It's a way to give visitors Google‑quality relevance over your own
domain(s) without running and maintaining a local search index.

Under the hood it registers a core Search plugin that queries the Google endpoint
using your **Search Engine ID** (`cx`) and **API key**, merges Google's paged result
sets (Google caps results at 100), and renders them. A modified pager adapts core's
pager to the API's paging model and estimated result counts, and a Twig helper
highlights the query terms in each result. It depends on core **Search** and
**Token**.

There's a small twist in how it's configured: a **global settings form** holds
shared values like endpoint and documentation URLs, while the **per‑search‑page**
settings (the `cx` engine ID, the API key, and endpoint choice) are entered on each
search page you create. Requests go through Drupal's HTTP client with normal TLS
verification, and the endpoint is admin‑configured, so there's no user‑supplied SSRF
surface.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.
2. [Configuration](configuration/index.md) — create a Programmable Search Engine, set
   global options, and add a search page with your engine ID and API key.

## Where it lives in the admin menu

The global settings form is at **Configuration → Search and metadata → Google JSON
API** (`/admin/config/search/google-json-api`), gated by the **Administer Google JSON
API** permission. Search pages are created and managed at **Configuration → Search
and metadata → Search pages** (`/admin/config/search/pages`), where the per‑page
`cx` and API key are entered.
