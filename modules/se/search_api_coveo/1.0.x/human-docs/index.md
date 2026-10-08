# Search API Coveo Integration — manual setup guide

**Search API Coveo Integration** (`search_api_coveo`) is a Search API *backend*
that connects Drupal to **Coveo**, the enterprise, AI-powered search platform.
With it in place, your Drupal content is indexed into Coveo and your site's search
queries are answered by Coveo rather than by the database or Solr.

You would reach for this when you want to power site search with Coveo's
enterprise search and relevance features instead of a self-hosted engine. Setting
it up means creating a Search API **server** that uses the Coveo backend, pointing
it at your Coveo organization, and then attaching an index. The module ships a
`search_api_coveo_keys` submodule to help manage the API credentials Coveo
requires. It depends on the **Search API** module (`search_api`).

A few security points are worth keeping in mind. The module authenticates to
Coveo with **API keys** — treat those as secrets. The bundled keys submodule (and
Drupal's Key module, where supported) is the right place to store them, rather
than pasting them into plain configuration. Operate over **HTTPS**, and make sure
your search respects content access so that results never surface content the
person searching isn't allowed to see. Whether that holds depends on Coveo's own
security model plus how you configure the index; the module has no access-control
role of its own.

Note that this is a connector to a specific commercial product: it only makes
sense on a site that actually uses Coveo. Also, at the time of writing this
release (`1.0.0-alpha9`) is an alpha and the project is **not covered** by
Drupal's security advisory policy — factor that into a production decision.

This guide is written for a **human** working through the admin UI. If you are an
AI agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its keys submodule.

## How to use it

The module has no standalone settings page; you configure it through Search API's
own server and index screens:

1. Go to **Configuration → Search and metadata → Search API**.
2. **Add a server** and choose the **Coveo** backend, then supply your Coveo
   connection details and API key (store the key as a secret — see the keys
   submodule).
3. **Add an index** attached to that server and select the content you want
   indexed into Coveo.
4. Index your content, then build a search View or page against the index.
