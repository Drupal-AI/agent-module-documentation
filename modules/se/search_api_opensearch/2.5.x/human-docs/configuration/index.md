# Configuration

There is no module settings page. You configure Search API OpenSearch on a **Search
API server** entity, then attach an **index** to it. This is the normal Search API
workflow.

## Step 1 — Create a server with the OpenSearch backend

1. Go to **Configuration → Search and metadata → Search API**
   (`/admin/config/search/search-api`) and click **Add server**.
2. Give the server a name and, under **Backend**, choose **OpenSearch**.

### Choose a connector

The **connector** tells the backend how to reach your cluster:

- **Standard** — no authentication. You provide the cluster **URL** (the full
  address, for example `https://os.example.com:9200`) and whether to do **SSL
  verification**.
- **Basic auth** — as standard, plus a **username** and **password** for HTTP basic
  authentication against a secured cluster.
- **AWS Signature** — available only when the AWS Signature Connector submodule is
  enabled. Adds an **AWS region** and API key/secret so you can reach Amazon
  OpenSearch Service with signed requests.

### Advanced settings

The backend also exposes advanced options:

- **Fuzziness** — the default query fuzziness for typo‑tolerant search. The default
  is **auto**.
- **Prefix** — a string prepended to every index name created on this server. Use it
  so several Drupal sites can safely share one OpenSearch cluster without colliding.
- **Synonyms** — a list of synonym strings applied at query time so related terms
  match.

Save the server. If the cluster is reachable, Search API reports the connection
status on the server page.

## Step 2 — Create an index and add fields

1. Back on the Search API overview, click **Add index**.
2. Choose the content to index (for example Content/nodes) and select the OpenSearch
   **server** you just created.
3. On the index's **Fields** tab, add the fields you want searchable and pick a data
   type for each.

Beyond the usual Search API data types, this backend adds several specialised ones
you can assign to fields:

- **Ngram** and **Edge ngram** — partial‑word and prefix matching.
- **Search as you type** — autocomplete / type‑ahead.
- **Rank feature** — boost documents for relevance tuning.
- **Date range** — index date‑range fields (backed by a Date Range processor).
- **Object** — index nested/object structures.
- **Spellcheck** — power "did you mean" suggestions.

If the Location submodule is enabled, a **location** (geo_point) type is also
available for geofield data.

4. Index your content (from the index page, or with `drush search-api:index`).

## Storing credentials per environment

Rather than committing cluster URLs or credentials to config, override them per
environment in `settings.php`, for example:

```php
$config['search_api.server.opensearch']['backend_config']['connector_config']['url']
  = 'https://os.internal:9200';
```

The same approach works for the AWS connector's region and keys.

## For developers

The backend dispatches a rich set of events (for field mappings, index and query
parameters, client options, data‑type support, and more) and provides a
`hook_index_param_value_alter()` hook, so other modules can customize how Search API
operations are translated into OpenSearch. It also defines two plugin types —
**OpenSearch connectors** and **OpenSearch analysers** (ships `ngram` and
`edge_ngram`) — for adding bespoke auth schemes or tokenizers. See the sibling
[`agent/`](../agent/start.md) docs for the specifics.
