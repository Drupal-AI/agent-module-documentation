<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Acquia CMS Search is the search feature module of the Acquia CMS (Acquia Drupal Starter Kit) distribution. It ships a complete Search API stack as installed config — a database search server, a `content` index, a `/search` results view with an exposed keyword filter, autocomplete, and content-type/category facets — and then keeps that index in sync as new node types and fields are added.

---

Rather than expose a settings form, the module wires the site's search together through installed configuration and entity-reaction hooks. It ships a `search_api_db` server (`database`) and a disabled `content` index that opts into a server through an `acquia_cms_common.search_server` third-party setting; when a matching server is created the index is attached and enabled. Internal facades react to new node types and fields, adding them to the index (bundles, taxonomy references as id + name, and string/date/text fields) and setting the right view modes on the `search` view. It provides a `search` view (page path `search`) backed by `search_fallback` for when the server is down, `search_content_type` / dynamically-created `search_category` facets with pretty-path URLs, a `clear_facet_filters` block, and a Views query override that adds the `url.path` cache context under Facets Pretty Paths. An Acquia CMS Tour tile lets an admin enter Acquia subscription details to switch the index from the database backend to Acquia Search (Solr). It is distribution glue: it assumes the rest of the acquia_cms family and a configured search backend, and is not meant to be cherry-picked onto an unrelated site.

---
- Add a full-text site search page at `/search` to an Acquia CMS site.
- Ship a ready-made Search API database server and content index.
- Auto-index new content types as they are created.
- Auto-index taxonomy-reference, string, date, email, phone and address fields.
- Index the node body field for full-text search.
- Provide an exposed keyword search box as a block.
- Provide a "Content Type" facet on search results.
- Add a "Category" facet automatically when a content submodule installs.
- Use Facets Pretty Paths for clean facet URLs.
- Offer a "Clear filter(s)" block to reset active facets.
- Fall back to a plain node listing when the search server is down.
- Enable search autocomplete for anonymous and authenticated users.
- Switch the content index to Acquia Search (Solr) from the Tour dashboard.
- Re-index content automatically when moving to Solr.
- Opt a specific content type into a specific index via a third-party setting.
- Opt a specific index into a specific server via a third-party setting.
- Render search results using the teaser view mode.
- Provide backward-compatible Views caching across search_api versions.
- Ship Site Studio (Cohesion) view templates for the search views.
- Standardise the search experience across the Acquia CMS family.
- Reuse a curated Search API processor pipeline (stopwords, tokenizer, transliteration, html filter).
- Add the search stack without writing custom search code.
- Programmatically force a node type into the index via the SearchFacade.
- Serve autocomplete suggestions from the content index.
