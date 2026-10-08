# Configuration

Acquia Search deliberately has **no settings form of its own**. You configure it
in three places: the **Acquia Connector** subscription (for credentials), the
**Search API** interface (for the server and index), and a small config object
(`acquia_search.settings`) that you edit with Drush. This page walks through each.

## 1. Connect the Acquia subscription

Acquia Search signs its Solr requests with your Acquia subscription credentials
(identifier, secret key, and application UUID). Those come from the **Acquia
Connector** module — connect your site to its Acquia subscription there first. Once
connected, Acquia Search can discover the Solr cores available to you and pick the
right one automatically for the current environment (production versus dev/test).

## 2. The default Search API server

On install, the module creates a Search API server called **Acquia Search**
(machine name `acquia_search_server`), already wired to the Acquia Solr connector.
You'll find it under **Configuration → Search and metadata → Search API**
(`/admin/config/search/search-api`). To build a working search you:

1. Add (or attach) a **Search API index** to that server.
2. Choose the datasource(s) — for example Content — and add the fields you want
   searchable.
3. Index your content and connect a search page or Views search to the index.

The default server and its index are protected: Drupal removes the **Delete**
operation for them in the UI so you can't remove them by accident. (If the Solr
field-type entities Search API Solr needs are missing when you enable the module,
Drupal skips creating the server automatically and you create it yourself.)

## 3. The settings object (`acquia_search.settings`)

A handful of behaviours are controlled by config values, which you read and set
with Drush:

| Setting | Default | What it does |
|---|---|---|
| **API host** (`api_host`) | `https://api.sr-prod02.acquia.com` | The Acquia Search API endpoint used to discover cores. Change it only if Acquia directs you to a different host. |
| **Read-only** (`read_only`) | `false` | When `true`, forces the Acquia server into read-only mode — no writes or indexing. |
| **Override search core** (`override_search_core`) | *(none)* | Pin a specific Solr core id (for example `WXYZ-12345.prod.mysite`) instead of letting the module auto-detect one. |
| **Extract handler** (`extract_query_handler_option`) | `update/extract` | The Solr handler used to extract text from file/attachment content. |

Read and change values like this:

```bash
drush cget acquia_search.settings                                          # show all
drush cset acquia_search.settings read_only true -y
drush cset acquia_search.settings override_search_core 'WXYZ-12345.prod.mysite' -y
drush cr
```

> **Legacy note:** older versions stored these under an `acquia_search_solr.settings`
> object. If a legacy `override_search_core` is set there, the module raises a
> requirements warning — move the value to `acquia_search.settings`.

## Read-only mode (protecting shared cores)

Because several environments can point at the same Solr core, Acquia Search
enforces **read-only** mode wherever writing could clobber a shared production
index — that is, on non-production environments, or whenever it cannot confidently
resolve the preferred core. While read-only, the server is prevented from indexing
and reports that Acquia Search has overridden it. You can force read-only on
explicitly by setting `read_only: true`. If the preferred core cannot be resolved
at all, the server is disabled to keep it from misbehaving.

## Choosing which core is used

The module discovers the **possible** cores for your subscription and picks a
**preferred** one for the current environment; setting `override_search_core`
forces a specific id (handy if you deliberately want to share one core across
environments). You can inspect all of this from the command line:

```bash
drush acquia:search-solr:cores                        # list every core available to the subscription
drush acquia:ss:cores:possible acquia_search_server   # possible cores for a server
drush acquia:ss:cores:preferred acquia_search_server  # the single preferred core
drush acquia:ss:cores:cr --id=ABCD-12345              # reset the cached core list after a subscription change
```

## Per-index relevance (eDisMax)

Each Search API index can opt into Solr's **eDisMax** query parser for better
multi-field relevance. This is stored as a third-party setting on the index
(`use_edismax: true`); when enabled, Acquia Search switches queries on that index
to eDisMax. Set it in the index configuration:

```yaml
third_party_settings:
  acquia_search:
    use_edismax: true
```
