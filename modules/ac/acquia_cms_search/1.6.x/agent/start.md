<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# acquia_cms_search — agent index

Search feature module of the **Acquia CMS** distribution (rebranded "Acquia Drupal Starter Kit").
It has no code feature of its own to "turn on" — instead it **ships the site's search stack as
installed config** (a Search API DB server + `content` index, a `search` results view at `/search`
with an exposed keyword filter and facets, autocomplete, a `search_fallback` view) and **auto-wires
new content into that index** through internal facades reacting to entity-insert hooks. It also
provides a Solr switch-over path (Acquia Search) and a small facet UI block. `container_rebuild_required: true`.

Core `^10.1 || ^11`. No settings page (`configure` is null). No permissions or Drush of its own.
Depends on: `acquia_cms_common`, `collapsiblock`, `facets`, `facets_pretty_paths`, `search_api`
(with `search_api_db`), `search_api_autocomplete`, `node`, `views`. `composer.json` additionally
pulls `drupal/acquia_search ^3.1` for the optional Solr path.

- **The shipped search stack (server/index/views/facets/autocomplete), the third-party settings that
  opt content in, and the switch to Acquia Search Solr** → [configure/search.md](configure/search.md)
- **The entity-reaction hooks that auto-index new node types/fields and attach servers** →
  [hooks/hooks.md](hooks/hooks.md)
- **The views it powers: `search`, the `view_fallback` area, the query & cache overrides** →
  [views/views.md](views/views.md)
- **The `clear_facet_filters` block and the shipped facet blocks** → [blocks/blocks.md](blocks/blocks.md)

Key facts:
- Shipped config entities: search_api server `database` (backend `search_api_db`), search_api index
  `content` (disabled on install; opts into a server via its third-party setting), views `search`
  (page path `search`) / `search_fallback` / `acquia_search` (disabled), autocomplete search `search`,
  facet `search_content_type` (+ `search_category` created dynamically), facet_source
  `search_api__views_page__search__search`.
- Third-party settings, all under the `acquia_cms_common` namespace: `search_server` on a search_api
  index (schema in `acquia_cms_search.schema.yml`), `search_index` on a `node.type` (schema added via
  `hook_config_schema_info_alter`), `search_index` + `search_label` on a field storage.
- Provided plugins: block `clear_facet_filters` (`ClearFacetFilters`), views area `view_fallback`
  (`FallbackView`), views query override `SearchApiQuery`, views cache BC shim `search_api_none_bc`
  (`SearchApiNoneCacheBC`), and two Acquia CMS Tour tiles (`acquia_search`, `acquia_connector`).
- Internal facades (invoked via `Drupal::classResolver`, marked `@internal`):
  `SearchFacade`, `AcquiaSearchFacade`, `FacetFacade`.
- Install grants `use search_api_autocomplete for search` to anonymous + authenticated so the search
  box autocomplete works for everyone.
