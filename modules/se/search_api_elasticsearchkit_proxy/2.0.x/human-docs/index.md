# Search API ElasticSearchKit Proxy — manual setup guide

**Search API ElasticSearchKit Proxy** (`search_api_elasticsearchkit_proxy`) sits
between a front-end application and Elasticsearch and acts as a secure proxy for
search requests. Instead of letting a decoupled app (React, Vue, or anything else)
talk to Elasticsearch directly — which would mean exposing the cluster and its
credentials to the browser — the app calls Drupal, and Drupal forwards a
controlled query to Elasticsearch through the Elasticsearch Connector.

This is aimed squarely at **decoupled** setups. A front end that needs advanced
Elasticsearch search hits the module's proxy controller; the module adds the
server credentials and any query filters on the server side, runs the query, and
returns the JSON results. The front end never sees the Elasticsearch endpoint or
its secrets. The module is framework-agnostic, so it works with any front end, and
its controller is designed to be **extended** in your own custom module if you need
to modify the outgoing query or reshape the returned JSON. It depends on
**Elasticsearch Connector** (`elasticsearch_connector`) and **Search API**
(`search_api`).

Because the whole point of a proxy is to gate access to the backend, the security
posture matters. Make sure the proxy **constrains what can actually be queried** —
only the indexes and fields you intend to expose — and that results respect content
access, so it can't be turned into a way to read search data beyond the intended
scope. The module forwards queries; it has no access-control role of its own, so
that constraint is something you set up in its configuration and, where needed, in
a custom controller extension. Note this release (`2.0.0`) is **not covered** by
Drupal's security advisory policy.

This guide is written for a **human** working through the admin UI. If you are an
AI agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.

## How to use it

Setup follows the module's own post-installation steps:

1. Go to **Configuration → Search and metadata → Search API**.
2. Select or configure your **Elasticsearch server** (provided by Elasticsearch
   Connector).
3. Set the module up to act as a proxy by specifying the server credentials and the
   query filters you want applied, in its settings form. Keep the filters tight so
   the proxy only exposes the indexes and fields you intend.
4. Point your front-end application at the proxy route to run searches. If you need
   to customise the query or the returned JSON, extend the module's controller in a
   custom module.
