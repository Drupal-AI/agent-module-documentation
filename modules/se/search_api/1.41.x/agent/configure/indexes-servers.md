# Configure indexes & servers

![Search API overview — servers & indexes](../../../../../../../screenshots/search_api/1.41.x/indexes-servers.png)

Two config entities drive everything (exportable, deployable):

- **Server** (`search_api.server.*`, entity type `search_api_server`) — chooses a **backend**
  plugin (e.g. `search_api_db`, `search_api_solr`) and its connection settings.
- **Index** (`search_api.index.*`, entity type `search_api_index`) — chooses **datasource(s)**,
  the **server** to write to, a **tracker**, the **fields** to index, and the **processor**
  pipeline.

Admin UI: `/admin/config/search/search-api` (route `search_api.overview`).
Typical flow: add a Server → add an Index (pick datasources like `entity:node`, assign the
server, pick a tracker) → **Fields** tab (add entity fields, set type/boost) → **Processors**
tab (enable HTML filter, tokenizer, ignore-case, stemmer, rendered item, aggregated field,
etc., and order the stages) → **View** tab to index the tracked items.

Index config (`config/sync/search_api.index.default_index.yml`), abridged:
```yaml
id: default_index
name: 'Default content index'
server: default_server
datasource_settings:
  'entity:node':
    bundles: { default: true, selected: [] }
tracker_settings:
  default:
    indexing_order: fifo
field_settings:
  title:
    label: Title
    datasource_id: 'entity:node'
    property_path: title
    type: text
    boost: 5.0
processor_settings:
  html_filter: {}
  tokenizer: {}
  ignorecase: {}
options:
  index_directly: true
  cron_limit: 50
```

- `read_only: true` on an index freezes indexing (safe during deploys).
- Indexing runs on cron (`cron_limit`), on save (`index_directly`), via a batch on the
  **View** tab, post-request (`search_api.post_request_indexing`), or Drush — see
  [../drush/commands.md](../drush/commands.md).
- Config schema lives in `config/schema/search_api.*.schema.yml`; defaults in
  `config/install/search_api.settings.yml`.
