<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Search (localgov_search) — agent index

Sitewide search for LocalGov Drupal. Ships one Search API index
(`localgov_sitewide_search`), one View (`localgov_sitewide_search`) with a page at
`/search`, and a header search block. Every node bundle is indexed and new bundles are
enrolled automatically. No search backend of its own — install the `localgov_search_db`
submodule (Search API DB server) or attach the index to Solr yourself.

- No `configure` route (tune via the Search API index UI / node display modes).
- No permissions, no Drush commands, no config schema, no plugin types of its own.
- Requires `search_api`, `localgov_core`, core `node` + `views`. Composer:
  `drupal/search_api ^1.19`, `drupal/localgov_core ^2.12 || ^3.3`.

Solution docs:
- **Tune what/how content is indexed, swap the backend** → [configure/search-index.md](configure/search-index.md)
- **The `/search` results page + view** → [views/search-page.md](views/search-page.md)
- **The header search block** → [blocks/sitewide-search-block.md](blocks/sitewide-search-block.md)
- **Hooks integrators rely on (auto-enrol bundles, page-title, aria)** → [hooks/integration.md](hooks/integration.md)

Submodule (own docs):
- `localgov_search_db` (Search API DB backend + server) →
  [../../modules/localgov_search_db/1.4.x/agent/start.md](../../modules/localgov_search_db/1.4.x/agent/start.md)

Key facts:
- Config objects: `search_api.index.localgov_sitewide_search`,
  `views.view.localgov_sitewide_search`, blocks
  `block.block.localgov_sitewide_search_block_base` (theme `localgov_base`) and
  `block.block.localgov_sitewide_search_block_scarfolk` (theme `localgov_scarfolk`), both
  in region `search`.
- Block plugin id: `localgov_sitewide_search_block`
  (`Drupal\localgov_search\Plugin\Block\SitewideSearchBlock`).
- View modes are the tuning surface: content is indexed via the node **`search_index`**
  display and rendered in results via **`search_result`**. Change what is searchable by
  editing those displays, not the index fields.
- As shipped the index has `status: false` and `server: ''`; the only indexed field is
  `rendered_item` (node view modes rendered as the **anonymous** role). Installing
  `localgov_search_db` sets the server, flips status to `true`, and adds text processors.
- Exposed search filter identifier is `s` (`search_api_fulltext` on `rendered_item`);
  results page is `/search`, view display `sitewide_search_page`.
- Hooks: `localgov_search_entity_bundle_create()` (auto-enrol node bundles),
  `localgov_search_install()`, `localgov_search_views_pre_render()`,
  `localgov_search_preprocess_form()`, `localgov_search_help()`. Update hooks `8001`/`8002`
  moved the DB server config into the `localgov_search_db` submodule.
