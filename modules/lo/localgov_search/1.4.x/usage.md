<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocalGov Search is the sitewide search for LocalGov Drupal: a Search API index covering every content type, a `/search` results page, a header search block, and automatic enrolment of new content types into the index as they are created.

---

Install ships two config objects — the `localgov_sitewide_search` Search API index and the `localgov_sitewide_search` view — plus optional search-block placements for the LocalGov Base and Scarfolk themes. Content is indexed through the **`search_index`** node display mode and rendered in results through **`search_result`**, so tuning what gets searched or how a result looks is a *Manage display* task on the content type, not a Search API field edit. The clever part is `localgov_search_entity_bundle_create()`: whenever a new node bundle appears it adds that bundle to the view's row `view_modes` map (`search_result`) and to the index `rendered_item` field configuration (`search_index`) and saves both — so a content type added months later is searchable without anyone remembering to configure it; removing a type from search is the only manual step. The index's single field, `rendered_item`, renders nodes as the anonymous role, and the `entity_status` processor skips unpublished nodes. Two rendering touches polish the results page: `localgov_search_views_pre_render()` blanks the header and empty text until a search has actually been submitted (no `s` parameter) and prefixes the header title with the search term when there are results, while `localgov_search_preprocess_form()` adds `role="search"` to the exposed form. The `localgov_sitewide_search_block` block provides the header search box and falls back to a "enable a backend" notice when the index has no server. As with LocalGov directories, the search **backend** is a separate submodule (`localgov_search_db`, the Search API DB server) so a site can swap in Solr by not installing it.

---

- Provide sitewide search across all content types on a LocalGov site.
- Give visitors a search box in the site header.
- Serve a search results page at a predictable `/search` path.
- Have new content types indexed automatically as they are created.
- Control what is indexed per content type via the `search_index` display mode.
- Control how each result renders via the `search_result` display mode.
- Show a clean, empty search form before any query is entered.
- Put the search term in the results header title.
- Improve accessibility with a proper `role="search"` landmark on the form.
- Swap the database backend for Solr without rewriting the index config.
- Use the shipped Search API DB backend for zero-config search after install.
- Exclude a content type from search by removing it from the index.
- Index only published content (unpublished nodes skipped by `entity_status`).
- Index rendered node output rather than raw fields.
- Reuse the `localgov_sitewide_search` index for other search displays.
- Add facets to sitewide search with the Facets module against the same index.
- Keep all search configuration deployable as config.
- Place the search block in any theme region via Block layout.
- Support multilingual search through Search API language handling.
- Reindex after a display-mode change to refresh what is searchable.
- Boost heading and bold text in relevance via the `html_filter` processor.
- Point the header search block at the `/search` view with the `s` query parameter.
- Give a LocalGov site working search immediately after install.
