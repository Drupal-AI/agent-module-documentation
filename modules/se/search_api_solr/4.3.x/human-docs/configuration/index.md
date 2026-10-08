# Configuration

Search API Solr is configured through the standard Search API screens plus some
Solr‑specific tabs — there is no single settings page. The overall flow is: create a
**server** that uses the Solr backend, choose a **connector** and point it at your
Solr instance, generate and install the **Solr config set**, then add **indexes** and
index your content. Every Solr screen requires the **Administer Search API**
permission (`administer search_api`).

## 1. Create a Solr server

1. Go to **Configuration → Search and metadata → Search API**
   (`/admin/config/search/search-api`) and click **Add server**
   (`/admin/config/search/search-api/add-server`).
2. Give the server a name, and under **Backend** choose **Solr**.

## 2. Choose and configure a connector

The **connector** decides *how* Drupal reaches Solr. Pick one on the server form:

- **Standard** — a single, standalone Solr node.
- **Basic Auth** — a standalone node protected with HTTP Basic authentication.
- **Solr Cloud** — a SolrCloud cluster (uses collections / ZooKeeper).
- **Solr Cloud with Basic Auth** — a SolrCloud cluster behind HTTP Basic auth.

Each connector asks for the connection details it needs — host, port, path, and the
Solr core or collection name, plus a username and password for the Basic‑Auth
variants. Fill these in to match your Solr server.

The server form also exposes backend options such as whether to retrieve result data
from Solr, highlighting behavior, a "commit within" delay, and fallback settings.
The defaults are sensible for a first setup; save the server when you're done.

## 3. Generate and install the Solr config set

Solr needs a matching configuration (schema and `solrconfig.xml`) that this module
generates for you from its field‑type and config entities:

1. On the saved server, open its **Files** / config‑set tab
   (`/admin/config/search/search-api/server/{server}/files`). You can download the
   full config set as a zip, or view individual generated files.
2. Alternatively, generate it from the command line:
   `drush search-api-solr:get-server-config {server_id}`.
3. Install that config set into your Solr server (copy it into the core/collection's
   config directory, or — with the **Solr Admin** submodule and SolrCloud — upload it
   with `drush solr-upload-conf`). Reload/restart Solr so it picks up the config.

Once the config set is in place, the server's status should report a healthy
connection to Solr.

## 4. Manage Solr config entities (optional, advanced)

The module ships a set of **config entities** that together make up the config set.
You manage them from the server's Solr tabs at
`/admin/config/search/search-api/server/{server}/…`, and each can be enabled or
disabled per server:

- **Solr field types** — language‑specific field types (analyzers, tokenizers,
  stemming). Field types are shipped for many languages; you can add or edit them at
  `/…/solr_field_type/add`.
- **Solr caches** — the filter/query/document cache definitions written into
  `solrconfig.xml`.
- **Solr request handlers** — custom request handlers (for example `/select` or
  `/mlt`).
- **Solr request dispatchers** — the `requestDispatcher` settings in `solrconfig.xml`.

Enabling or disabling an entity for a server changes what ends up in the generated
config set — so after changing these, regenerate and reinstall the config set. You
can refresh the shipped field types with the Drush commands
`search-api-solr:reinstall-fieldtypes` or `search-api-solr:install-missing-fieldtypes`.

## 5. Add an index and index your content

Create a Search API **index** the same way you would for any backend: choose the
entity types/bundles to index, add fields, point the index at your Solr server, and
run indexing. The correct Solr field type is chosen automatically per language from
the installed field‑type entities. Index from the UI, or with `drush
search-api-index`.

## Handy Drush commands

Search API Solr provides several commands to run this flow from the command line:

| Command | What it does |
|---------|--------------|
| `search-api-solr:get-server-config {server_id}` | Generate/download the Solr config set (zip) for a server. |
| `search-api-solr:reinstall-fieldtypes` | Delete and reinstall all Solr field‑type entities. |
| `search-api-solr:install-missing-fieldtypes` | Install only the field types that are missing. |
| `search-api-solr:finalize-index [indexId]` | Finalize an index (e.g. commit/optimize) before serving queries. |
| `search-api-solr:index-parallel [indexId]` | Index items using multiple threads (`--threads`, `--batch-size`) for speed. |
| `search-api-solr:execute-raw-streaming-expression {indexId} {expression}` | Run a raw Solr streaming expression. |

> **Developers:** the module exposes services (field manager, config‑set controller,
> streaming‑expression helper, command helper), a `SolrConnector` plugin type for
> custom hosted providers, and a rich set of alter hooks for queries, documents,
> results, and generated config files. See the sibling
> [`agent/`](../../agent/start.md) docs.
