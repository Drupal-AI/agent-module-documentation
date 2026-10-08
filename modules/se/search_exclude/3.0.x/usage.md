<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search Exclude adds a replacement for core's "Content" search page whose settings form lets you tick content types that should be kept out of the core search index entirely.

---

Core's Search module indexes every node type and only lets you *filter* by type at query time; Search Exclude stops the excluded types from ever entering the index. It does this with a single search plugin, `search_exclude_node_search` ("Content (Exclude)"), that extends core's `NodeSearch`. The plugin adds one configuration key, `excluded_bundles`, exposed on the search page's configuration form as an "Exclude content types" checkbox group, and overrides `updateIndex()` so the cron indexing query adds `node.type NOT IN (:excluded_bundles)`. It also overrides `indexStatus()` so the *Search pages* screen reports "x of y indexed" against the reduced total, and `searchFormAlter()` so the excluded types disappear from the advanced search form's "Only of the type(s)" checkboxes. `search_exclude.module` adds `hook_node_update()` plus comment insert/update/delete hooks that call `SearchIndex::markForReindex()` for the affected node — but only when the node's type is *not* excluded, so edits to excluded content never dirty the index. Because it is a search plugin, you use it by creating a **new search page** (`/admin/config/search/pages`, `configure: entity.search_page.collection`) with the "Content (Exclude)" plugin, then disabling core's default Content search and making the new page the default. The module ships no permissions, no Drush commands, no services and no config schema of its own.

---

- Keep a "Landing page" or "Component" content type out of site search results.
- Stop legal/boilerplate nodes (privacy policy, terms) from crowding search results.
- Exclude an imported catalogue content type with tens of thousands of nodes to keep the index small.
- Cut cron indexing time by excluding the bulk content type that nobody searches for.
- Prevent a "Webform" or "Form page" content type from appearing in results.
- Hide staff-only content types from public search without touching node access.
- Remove excluded types from the advanced search form's "Only of the type(s)" options as well.
- Exclude paragraphs-host or wrapper node types that render no useful text.
- Keep a "Redirect" or "Alias stub" content type out of the index.
- Stop comments on excluded node types from triggering pointless reindex queues.
- Report accurate "n of m indexed" progress after excluding types.
- Run two search pages side by side: one full index, one narrowed, at different paths.
- Give editors a search page that indexes only editorial content types.
- Replace the default Content search page so `/search/node` uses the exclusion rules.
- Reduce search_dataset table growth on a large multi-type site.
- Exclude a content type used purely for configuration-like data (settings nodes).
- Prevent duplicate results when a content type mirrors another (e.g. a translation stub type).
- Keep event/agenda item types out of the general search while keeping them in a Views listing.
- Exclude a "Media page" type whose body is just an embedded asset.
- Stagger a migration by excluding a type until its content is cleaned up.
- Test index size impact by toggling one content type on and off.
- Deploy the exclusion list as config (`search.page.<id>:configuration.excluded_bundles`).
- Combine with core's content ranking settings on the same search page.
- Avoid writing a custom `hook_search_plugin_alter()` or a custom search plugin.
- Keep the core Search module (no Search API/Solr) on a small site while still controlling scope.
