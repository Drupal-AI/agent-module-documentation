<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# facets_pretty_paths — agent start

Swaps Facets' query-string URLs (`?f[0]=color:blue`) for clean **pretty paths**
(`/color/blue`). It is a single Facets **URL processor** plugin (id `facets_pretty_paths`)
that a **facet source** is switched to, plus a pluggable **coder** plugin type that
formats each value as a URL segment. Depends on `facets` and `pathauto`. **No admin
settings page of its own** (`configure: null`) — you configure it on the Facets
facet-source and facet edit forms, or directly on the `facets_facet_source` config entity.

- Switch a facet source to pretty paths + pick a per-facet coder (config keys, drush) → [configure/pretty-paths.md](configure/pretty-paths.md)
- The coder plugin type: bundled coders + how to write your own → [plugins/coder.md](plugins/coder.md)

Key facts an agent usually needs:
- URL processor plugin id: **`facets_pretty_paths`** (`@FacetsUrlProcessor`, in `Plugin/facets/url_processor/`). Default facets processor it replaces is `query_string`.
- The processor is selected via the `url_processor` property of a **`facets_facet_source`** config entity (`facets.facet_source.<id>`).
- Coder plugin type id/dir: **`facets_pretty_paths_coder`** — annotation `@FacetsPrettyPathsCoder`, namespace `Plugin/facets_pretty_paths/coder`, manager service `plugin.manager.facets_pretty_paths.coder`, interface `CoderInterface` (`encode()`/`decode()`), base `CoderPluginBase`.
- Per-facet coder is stored as a third-party setting: `facets.facet.<id>.third_party.facets_pretty_paths.coder` (default `default_coder`).
- Bundled coders: `default_coder`, `url_encoded_coder`, `taxonomy_term_coder`, `taxonomy_term_name_coder`, `node_title_coder`, `list_item_coder`.
