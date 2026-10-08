# Search API Elasticsearch Client — manual setup guide

**Search API Elasticsearch Client** (`search_api_elasticsearch_client`) is a
Search API *backend* that serves your indexes from an **Elasticsearch** cluster.
It is built on the official Elasticsearch PHP client and is compatible with any
Elasticsearch version 8 or newer, so it is a natural choice for sites that want to
run search on Elasticsearch rather than Solr.

Once configured, Search API sends indexing and query work to your Elasticsearch
cluster the same way it would to any other backend. The module supports the
features you'd expect from a serious search backend: field mapping and indexing,
Views integration, facets, "More Like This", geo-data (it depends on the
**Geofield** module for that), NGram analyzer support, and a connector plugin
type so external connector extensions can be added. It is heavily based on the
Search API OpenSearch module.

One important installation detail: to let you pick the Elasticsearch version
yourself, the module does **not** bundle the Elasticsearch PHP client as a Composer
dependency. You install the client separately with a version matching your
cluster — for example `composer require elasticsearch/elasticsearch ^8.11`. See
the [installation guide](installation/index.md) for the exact steps.

On the security side, the module needs an Elasticsearch cluster to connect to,
and if that cluster is secured the connection credentials are configuration you
should keep out of plain, committed config. Restrict who can administer the search
server, and treat the cluster's endpoint and credentials as sensitive. The module
slots into Search API's server and index configuration like any other backend and
has no access surface of its own.

This guide is written for a **human** working through the admin UI. If you are an
AI agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module *and* the
   Elasticsearch PHP client with Composer, then enable it.

## How to use it

The module has no standalone settings page; you configure it through Search API's
server and index screens:

1. Go to **Configuration → Search and metadata → Search API**.
2. **Add a server** and choose the **Elasticsearch** backend, then supply your
   cluster's connection details (and credentials, if the cluster is secured).
3. **Add an index** attached to that server, add your fields, and index your
   content.
4. Build a search View or page against the index. Enable Geofield if you need
   geo-data support.
