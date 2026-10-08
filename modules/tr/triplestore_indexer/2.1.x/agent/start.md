<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TripleStore Indexer (triplestore_indexer) — agent index

**Indexes nodes, media, and taxonomy terms as RDF (JSON-LD) into a Blazegraph triplestore on content events.**

- **Version:** 2.1.x
- **Core:** ^8.8 || ^9 || ^10 || ^11 — deps: jsonld, advancedqueue, restui, media, file, node, taxonomy, context
- **Flow:** entity CRUD → Context reaction → AdvancedQueue job (`TriplestoreIndexJob`) → `IndexingService`: authenticated Guzzle GET of `/<type>/<id>?_format=jsonld` → raw cURL POST/PUT/DELETE to `<server_url>/namespace/<namespace>/sparql`.
- **Config route:** `/admin/config/triplestore_indexer/configuration` (`TripleStoreIndexerConfigForm`). Config: `server_url`, `namespace`, `method_of_auth`, `admin_username`, `admin_password`, `advancedqueue_id`, retries.
- **Drush:** `triplestore-indexer:queue_triplestore <queue_id> --csv=file.csv`. Bundled Context + system.action config; optional `rest.resource.*` config.

**Notes:**
- Config route permission: `access administration pages`.
- The config form only **warns** and still saves on cURL errno 60 (bad cert) (`:209-214`).
- Entity URIs sent to SPARQL are int-id/machine-name + urlencoded.
- Optional `rest.resource.*` config is shipped (see [api/indexing.md](api/indexing.md)).

See [api/indexing.md](api/indexing.md)
