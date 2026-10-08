<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search Exclude — agent index

Adds one core-Search plugin, **`search_exclude_node_search`** (label *"Content (Exclude)"*),
that extends `NodeSearch` and skips selected node bundles when building the index.

Key facts:

- No config object, no permissions, no Drush commands, no services, no config schema.
  All state is one key on a **`search.page.*` config entity**:
  `configuration.excluded_bundles` (a map `bundle => bundle`).
- `configure` route is **`entity.search_page.collection`** → `/admin/config/search/pages`.
- You must **create a new search page** with this plugin; enabling the module changes nothing
  on its own. Then disable core's *Content* page and set the new one as default.
- Depends on core `search`. Comment hooks only fire if the `comment` module is on.

Docs:

- **Create/inspect the search page, the config keys, drush recipes** →
  [configure/search-page.md](configure/search-page.md)
- **What the plugin overrides (indexing query, index status, form alter, reindex)** →
  [plugins/search-exclude-node-search.md](plugins/search-exclude-node-search.md)
