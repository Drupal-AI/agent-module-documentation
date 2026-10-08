# Configuration

Elasticsearch Connector has no settings page of its own. You configure it by
creating a **Search API server** that uses the Elasticsearch backend, then indexing
content through Search API as usual. This page covers the server setup — the part
this module is responsible for.

## Create a Search API server

1. Go to **Configuration → Search and metadata → Search API**
   (`/admin/config/search/search-api`) and click **Add server**.
2. Give the server a name, and under **Backend** choose **ElasticSearch**.
3. Choose a **connector** and fill in its fields (see below).
4. Set the **advanced options** (see below).
5. Save.

Creating and saving the server does **not** contact your cluster — Search API only
connects when you actually enable the server and start indexing. So you can build
the configuration even before the cluster is reachable.

## Choose a connector

The connector decides *how* Drupal authenticates to your Elasticsearch cluster. Four
ship with the module:

| Connector | Use it for | Fields you provide |
|---|---|---|
| **Standard** | A cluster with no authentication. | Cluster URL (e.g. `http://localhost:9200`). |
| **HTTP Basic Authentication** | A cluster protected by username/password. | Cluster URL, username, password. |
| **Elastic Cloud ID** | Elastic's managed Elastic Cloud, addressed by Cloud ID. | Cloud ID, and an API key stored in the Key module. |
| **Elastic Cloud Endpoint** | Elastic Cloud, addressed by its endpoint URL. | Endpoint URL, and an API key stored in the Key module. |

Every connector also has an **Enable debug logging** option, which routes the raw
Elasticsearch HTTP traffic to a log channel. It is noisy and may record sensitive
data, so use it only temporarily while troubleshooting.

> **Elastic Cloud connectors need the Key module.** The API key is referenced from a
> Key entity, so install and enable `drupal/key` first and create a key to hold your
> API key value. Without Key, the Elastic Cloud connector forms show an error and no
> working client can be built.

## Advanced options

Under the server's advanced settings you can tune how queries and indexes behave:

- **Fuzziness** — how tolerant matching is of typos: `auto`, disabled (`0`), or a
  fixed edit distance from `1` to `5`.
- **Index prefix / suffix** — text added to the front or back of each
  Elasticsearch index name. This lets several environments (dev, stage, prod) safely
  share one cluster by keeping their index names distinct.
- **Synonyms** — a Solr-format synonyms list, so search treats configured word
  groups as equivalent.

## Index your content

Once the server is saved and enabled, create a Search API **index** pointing at it,
add the fields you want searchable, and index your content — all through the normal
Search API screens. That part is standard Search API and is not specific to this
module.

## Optional: the two bundled processors

The module ships two Search API **processor** plugins that you enable on an *index*
(not the server), from the index's **Processors** tab:

- **Type boost** (`elasticsearch_type_boost`) — boost results at query time by
  datasource and/or content-type bundle, so (say) Articles rank above Basic pages.
- **Highlight** (`elasticsearch_highlight`) — produce result excerpts using
  Elasticsearch's own native highlighter instead of Search API's default excerpting.
  Its settings control fragment size, number of fragments, the boundary scanner, and
  the tags/joiner used around matched terms.

## Inspecting the configuration

A server's settings are stored in the `search_api.server.<id>` config entity. You
can read them back from the command line, for example:

```bash
drush config:get search_api.server.my_server
drush config:get search_api.server.my_server backend_config.connector
```
