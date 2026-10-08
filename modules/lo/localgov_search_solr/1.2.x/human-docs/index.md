# LocalGov Search Solr — manual setup guide

**LocalGov Search Solr** (`localgov_search_solr`) gives a **LocalGov Drupal** site a
ready‑made **Apache Solr** backend and index configuration for its sitewide search.
Out of the box LocalGov's sitewide search runs against the database; this module
swaps in Solr instead, for much better full‑text relevance and the ability to scale
search on large sites.

It is a **configuration‑only** module — it contains no PHP, routes, permissions or
services. On install it imports a Search API **Solr server**, a matching **index**,
and the field types and processors that go with them, and it ships the generated Solr
**config‑set** (for several Solr schema versions) so your Solr core uses a schema
that matches. In short, it wires Search API up to a Solr server that you provide and
run.

Because it is only configuration, the actual work is operational: you stand up a Solr
core, point the imported Search API server at it, apply the shipped config‑set, and
re‑index your content.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module together with LocalGov Search and Search API Solr.

This module has **no settings form of its own**. You do all configuration through the
standard **Search API** admin screens on the server and index it installs — there is
no LocalGov‑specific form to fill in.

## Where it lives in the admin menu

Everything is managed through **Search API** at **Configuration → Search and metadata
→ Search API** (`/admin/config/search/search-api`). There you will find the Solr
**server** and **index** this module imported: edit the server to enter your Solr
connection details, and use the index to run indexing.

## How to use it

1. Install and enable the module and its dependencies (see
   [Installation](installation/index.md)).
2. **Stand up a Solr core/collection** compatible with Search API Solr, and apply
   the Solr **config‑set** this module ships (choose the version matching your Solr).
3. In **Search API**, edit the imported **server** and point it at your Solr
   **host, port and core**.
4. Confirm the connection from the Search API server report, then **index** (or
   re‑index) your content.
5. Combine it with **LocalGov Search**'s facets and blocks for the search UI.

### Keep the Solr endpoint secure

Because the Solr endpoint holds your indexed content and the server configuration can
contain connection **credentials**, keep the Solr endpoint **firewalled** so it is
not reachable from the public internet, and protect (and rotate) any credentials
stored in the exported Search API server configuration. This is inherited from Search
API Solr and your Solr deployment rather than added by this module.
