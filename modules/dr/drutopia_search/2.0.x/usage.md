<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drutopia Search is a feature module that bundles a complete content-search setup — a Search API database index, a search results View, and facets — as installable configuration for the Drutopia distribution.

---

Rather than shipping PHP, the module delivers config in `config/install`: a `search_api.index.content` index (database backend via `search_api_db`), a `views.view.search` search page, three facets (content type, date, topics) with their facet source, and a `block_visibility_groups` group for the search block. It depends on Search API, Search API DB, Facets, Views, Node, Block Visibility Groups and `drutopia_core`, and is marked as a required feature (`bundle: drutopia`, `required: true`) so the distribution installs it automatically.

Because everything is configuration, operating the module is mostly about the standard Search API workflow: after install, index existing content (via the Search API UI or `drush search-api:index`), then visit the search page and refine with facets. Adjust the index's indexed fields, the View's display/filters, or the facet definitions to fit the site. There is no custom code, no routes, and no permissions beyond what Search API, Views and Facets provide.

---

- Install a ready-made content search index without building Search API config by hand.
- Provide a search results page View out of the box.
- Offer content-type, date, and topics facets on the search page.
- Use the database (search_api_db) backend — no external search server needed.
- Index existing content after install (`drush search-api:index content`).
- Place the search block via the shipped block visibility group.
- Bootstrap search for a Drutopia distribution site automatically.
- Customise which fields are indexed on the `content` index.
- Adjust the search View's filters, sorting, and path.
- Add or remove facets bound to the search page facet source.
- Reindex content when the index configuration changes.
- Serve faceted search UI using the Facets module.
- Restrict searchable content by editing the index datasource/processors.
- Keep search config in code for repeatable deployments.
- Extend to more content types by editing the shipped index.