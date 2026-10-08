<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Elasticsearch Helper is a framework for indexing Drupal content into Elasticsearch through the official Elasticsearch PHP client, embracing the Elasticsearch API directly rather than abstracting it behind Search API.

---

Where Search API treats Elasticsearch as one interchangeable backend, Elasticsearch Helper hands you the primitives instead: an `ElasticsearchIndex` plugin type you extend, fluent mapping and field definition builders, a configured client service, and an operation pipeline with events. You declare an index plugin with a target index name and (optionally) a Drupal entity type; the module then keeps documents in sync on entity create/update/delete, either synchronously or through a queue. Index creation, dropping, reindexing and truncation run from drush or the queue worker. Connection details (hosts, scheme, pluggable authentication, SSL) live in a single settings form, and pluggable `ElasticsearchAuth` methods (basic auth, API key, or your own) plus a client-builder alter hook let you shape the client. Because you control the mapping and the normalized document shape, it fits document structures that are not plain entities, aggregation-driven dashboards, language-specific analyzers, and indices consumed by other applications. On its own the module indexes nothing until you add an index plugin — the bundled `elasticsearch_helper_example` module shows working plugins and normalizers.

---

- Index Drupal nodes or other entities into Elasticsearch.
- Define an Elasticsearch index and its field mapping in PHP.
- Auto-sync documents on entity insert, update and delete.
- Defer indexing to a queue for large content imports.
- Build documents that are not Drupal entities.
- Drive a dashboard or report from Elasticsearch aggregations.
- Use Elasticsearch features that Search API hides.
- Serve a purpose-built index to a separate application.
- Create per-language indices with language-specific analyzers.
- Add custom multi-fields and object sub-properties to a mapping.
- Provide a custom serializer/normalizer for indexed documents.
- Set up index mappings before bulk indexing with a drush command.
- Reindex all content of an entity type on the next cron run.
- Drop or truncate indices from the command line.
- List all registered index plugins via drush.
- Connect to a multi-node Elasticsearch cluster.
- Authenticate to Elasticsearch with basic auth or an API key.
- Add a bespoke authentication method as a plugin.
- Point the connection at an HTTPS cluster with a custom CA certificate.
- Attach a logger or custom handler to the Elasticsearch client.
- React to index/document operations through events.
- Veto or rewrite a document before it is indexed.
- Suspend the indexing queue when the cluster is unreachable.
- Run search and multi-search queries scoped to a plugin's indices.
- Perform bulk and upsert document operations.
- Auto-create a module's indices when that module is installed.
