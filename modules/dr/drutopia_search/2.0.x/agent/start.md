<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drutopia Search (drutopia_search) — agent index

**Bundles a Search API DB index, a search View, and facets as installable config for Drutopia sites.**

- **Version:** 2.0.x
- **Core:** ^10.2 || ^11 || ^12
- **Type:** Feature module (`bundle: drutopia`, required: true) — config only, no PHP
- **Requires:** search_api, search_api_db, facets, views, node, block, block_visibility_groups, drutopia_core, system, user
- **Provides (config/install):** `search_api.index.content`, `views.view.search`, facets (content type / date / topics) + facet source, search block visibility group

**Security:** No custom code, routes, or permissions — access is governed entirely by the standard Search API, Views and Facets configuration it ships. No mutating endpoints.

See [configure/drutopia_search.md](configure/drutopia_search.md)