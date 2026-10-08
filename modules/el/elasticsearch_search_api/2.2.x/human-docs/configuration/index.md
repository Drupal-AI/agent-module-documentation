# Configuration

Elasticsearch Search API is configured entirely through **Search API**: you create
a server that uses the Elasticsearch backend, add an index that stores content on
that server, and then build search pages from it. The connection to the cluster
itself is set up through **Elasticsearch Connector**.

## 1. Set up the connection (Elasticsearch Connector)

First, make sure Elasticsearch Connector has a cluster configured that points at
your Elasticsearch instance. This is where the host, port, and authentication for
the cluster live. Keep the connection over TLS, require authentication, and don't
expose the Elasticsearch host publicly — it should be reachable only by the site.

## 2. Create a Search API server

1. Log in as a user with the **Administer Search API** permission.
2. Go to **Configuration → Search and metadata → Search API**
   (`/admin/config/search/search-api`).
3. Click **Add server**.
4. Give it a name, and choose the **Elasticsearch** backend for the server.
5. Select the Elasticsearch Connector cluster/connection the server should use, and
   save.

## 3. Create an index

1. Back on the Search API page, click **Add index**.
2. Name the index and choose the **data sources** — the entity types (for example
   Content/nodes) you want to make searchable.
3. Select the **server** you just created so the index is stored in Elasticsearch.
4. Save.

## 4. Add fields and index content

1. On the index's **Fields** tab, add the fields you want to be searchable or
   filterable (title, body, taxonomy references, dates, and so on).
2. Save the field configuration.
3. Index your content — from the index page use **Index now**, or let indexing run
   on cron.

## 5. Build the search experience

With content indexed, you can build the front-end search using Search API's tooling
and this module's features — faceted search, autocomplete/search suggestions, "did
you mean" spelling suggestions, and pagination (enable the **ESA Pager** submodule
for paging). The bundled **Elasticsearch Search API Example** submodule is a good
reference for how a custom search page is put together.

## A note on access

Content indexed into Elasticsearch lives outside Drupal's entity access system on
the cluster itself, so protect the cluster (TLS, authentication, no public exposure)
and be deliberate about what you index — especially if any of it is restricted.
Search API applies its own access handling when serving results, but the raw index
should never be directly reachable by untrusted clients.
