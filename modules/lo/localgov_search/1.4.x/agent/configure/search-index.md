# Configure the sitewide search index

There is **no settings form** and no config object owned by this module beyond the shipped
Search API / Views / Block config. You tune search by editing the Search API index and the
node display modes, not through a module settings page.

## Shipped config objects (config/install, config/optional)

| Config | What it is |
| --- | --- |
| `search_api.index.localgov_sitewide_search` | The index. `status: false`, `server: ''` until a backend module is installed. |
| `views.view.localgov_sitewide_search` | Results view + `/search` page (see [views/search-page.md](../views/search-page.md)). |
| `block.block.localgov_sitewide_search_block_base` | Search block placed in `localgov_base` theme, region `search`, weight `-16`. |
| `block.block.localgov_sitewide_search_block_scarfolk` | Same block placed in `localgov_scarfolk` theme. |

Admin UI: `/admin/config/search/search-api/index/localgov_sitewide_search` (and `.../edit`).

## The index (`localgov_sitewide_search`)

- **Datasource** `entity:node` — all bundles, all languages (`default: true`).
- **One field**: `rendered_item` (type `text`, property path `rendered_item`), configured to
  render node view modes as the **anonymous** role (`roles: {anonymous: anonymous}`). Its
  `view_mode` map (`view_mode['entity:node'][<bundle>]`) is populated per bundle with
  `search_index` by `localgov_search_entity_bundle_create()`.
- **Processors** (base install): `add_url`, `aggregated_field`, `entity_status` (skips
  unpublished nodes), `entity_type`, `html_filter` (strips markup, boosts `h1`=5 `h2`=3
  `h3`/`b`/`strong`=2), `language_with_fallback`, `rendered_item`.
- **Tracker**: `default`, `indexing_order: fifo`.
- **Options**: `cron_limit: 50`, `index_directly: true`, `track_changes_in_references: true`.

## The two view modes = the tuning surface

- **`search_index`** node display → controls **what text is indexed** (which fields are
  visible in that display mode).
- **`search_result`** node display → controls **how a result renders** on `/search` (README
  label: "Search result highlighting input").

Edit these under *Manage display* on each content type, then reindex. Do **not** hand-edit
the index field list for per-bundle content changes.

## Add / remove a content type from search

- **Add**: automatic. When any node bundle is created,
  `localgov_search_entity_bundle_create()` adds `search_result` to the view row
  `view_modes` map and `search_index` to the index `rendered_item` field config, then saves
  both. On install, `localgov_search_install()` runs this for every existing bundle.
- **Remove**: manual. Deselect the bundle at
  `/admin/config/search/search-api/index/localgov_sitewide_search/edit`.

## Choose / swap the backend

The index ships with no server, so it does nothing until you give it one:

- **Database** (default LocalGov): install the `localgov_search_db` submodule. Its
  `hook_install` sets `server = localgov_sitewide_search` (backend `search_api_db`,
  `min_chars: 3`, `matching: prefix`), flips the index `status` to `true`, and swaps in the
  DB processor set (`highlight`, `ignorecase`, `stemmer`, `stopwords`, `tokenizer`,
  `transliteration`). Uninstalling it detaches the server and disables the index.
- **Solr**: install `search_api_solr` (dev-suggested), create a Solr server, and set it on
  the index — do **not** install `localgov_search_db`.

Set the server in PHP:

```php
use Drupal\search_api\Entity\Index;
$index = Index::load('localgov_sitewide_search');
$index->setServer(\Drupal\search_api\Entity\Server::load('my_solr'));
$index->setStatus(TRUE);
$index->save();
```

Reindex / operate via Search API's own Drush (not provided by this module):
`drush search-api:index localgov_sitewide_search`, `drush search-api:reset-tracker`,
`drush search-api:clear`.

Config schema: none defined here — the index/view/block objects use the schemas of
`search_api`, `views` and `block`.
