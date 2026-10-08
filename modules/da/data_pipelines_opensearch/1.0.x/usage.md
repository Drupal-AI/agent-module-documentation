Data Pipelines - OpenSearch adds an "opensearch" destination plugin that writes a Data Pipelines dataset into an OpenSearch cluster.

---

The module extends the [Data Pipelines](https://www.drupal.org/project/data_pipelines) framework with a single `DatasetDestination` plugin (`opensearch`). It uses the official `opensearch-project/opensearch-php` client (via a Drupal service `data_pipelines_opensearch.client_factory`) to talk to a cluster over HTTP(S) with basic auth. Configuration lives on the pipeline's destination settings — a cluster URL, optional username/password, and an index prefix — entered through the Data Pipelines destination UI (there is no standalone module settings form). At run time the plugin maps each dataset to one index named `<prefix><dataset machine name>`. When processing begins it creates the index (optionally applying `mappings`/settings declared in the pipeline's `destinationSettings.opensearch`), then bulk-indexes each processed chunk as documents whose id is `<dataset>:<delta>` and whose body is the row array plus an `@delta` field for ordering. Cleanup passes bulk-delete invalid deltas, deleting the dataset removes the index, and `getLastDelta()` runs a sorted search on `@delta` to resume from the last written row. Thin value objects (`Index`, `Document`) and request proxies (`IndexRequest`, `DocumentRequest`, `DocumentsRequest`) wrap the underlying client calls (`indices()->create/delete/exists`, `bulk`, `index`, `search`).

---

- Push a Data Pipelines dataset into an OpenSearch cluster for search or analytics.
- Add an OpenSearch destination to an existing pipeline from the Data Pipelines destination screen.
- Index Drupal-derived content (nodes, users, custom data) transformed by a pipeline into OpenSearch.
- Keep an OpenSearch index in sync with a dataset across repeated pipeline runs (resume by last delta).
- Bulk-index processed chunks efficiently using the OpenSearch `_bulk` API.
- Automatically create a per-dataset index named with a configurable prefix plus the dataset machine name.
- Apply custom index `mappings` and settings by declaring them under `destinationSettings.opensearch` in the pipeline YAML/config.
- Authenticate to a secured OpenSearch cluster with HTTP basic auth (username/password).
- Point multiple pipelines at the same cluster while isolating their data by index prefix.
- Remove an index cleanly when a dataset or its destination is deleted.
- Prune rows that fail validation from the index during cleanup (bulk delete by delta).
- Verify connectivity and see the resolved URL, prefix, and a ping status on the destination view screen.
- Feed an OpenSearch Dashboards / visualization layer from Drupal content pipelines.
- Build an external search index without running Search API on the same infrastructure.
- Stream large datasets to OpenSearch chunk-by-chunk without holding the whole set in memory.
- Store a `@delta` ordering field on each document so the last processed position can be recovered.
- Use OpenSearch as a downstream analytics sink for imported/transformed CSV or API data.
- Target a self-managed or managed (AWS/other) OpenSearch endpoint over HTTPS.
- Reuse a single shared OpenSearch client instance per request via the client-factory service.
- Extend or wrap the shipped request proxies to issue additional OpenSearch operations from custom code.
