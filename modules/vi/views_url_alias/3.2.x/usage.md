<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views URL alias lets a View be filtered and sorted by content entities' URL (path) aliases by maintaining a dedicated `views_url_alias` mapping table and exposing it to Views as a relationship, filter and sort.

---

The module keeps a separate database table, `views_url_alias`, that maps each content entity (`entity_type`, `entity_id`, `langcode`) to its path alias string. The table is kept in sync automatically: `hook_ENTITY_TYPE_insert/update/delete` on the `path_alias` entity resolve the aliased system path back to its content entity (via the router) and insert, update or delete the matching row through `views_url_alias_save()`. It also hooks the Pathauto bulk-delete and the core path-alias delete forms so those removals propagate to the table. `hook_views_data()` registers the table as a Views base table with an `alias` field (sortable, string-filterable) and, for every content entity type, a **"{Label} URL Alias"** relationship joining that entity's data table to `views_url_alias`. So in a View you add the relationship, then add a **URL Alias** filter/sort — useful for filtering a listing to a section of the site by alias prefix, especially combined with Views Bulk Operations. Because the table can drift if aliases change without firing the hooks (or right after install), the module tracks a `views_url_alias.needs_rebuild` state flag and offers a **Rebuild** confirm form at `/admin/config/search/views-url-alias` (permission: core `administer views`) that truncates and repopulates the table via a batch over all path aliases. Only entities with numeric IDs are indexed; the module installs with weight 2 so it runs after Pathauto.

---

- Filter a content View to only nodes whose URL alias starts with a given section prefix (e.g. `/products/…`).
- Sort a listing View alphabetically by URL alias.
- Combine with Views Bulk Operations to run operations on all content under a path branch.
- Build a sitemap-style View grouped by alias hierarchy.
- Expose a URL-alias filter to visitors so they can narrow a listing by path.
- Add a "{Type} URL Alias" relationship to any content-entity View (nodes, taxonomy terms, media, users, etc.).
- Show each row's URL alias as a sortable, clickable Views column.
- Restrict a View of articles to those under a particular multilingual alias path.
- Provide fast SQL joins between an entity's base table and its alias without runtime alias lookups.
- Filter media entities in a View by their alias.
- Filter taxonomy term listings by their alias path.
- Drive a "content in this subsite/section" block from a URL-alias-filtered View.
- Rebuild the alias index after a bulk import or migration that set aliases directly in the DB.
- Rebuild the table right after installing the module on a site that already has aliases.
- Keep the alias index correct automatically as editors add, edit and delete aliases.
- Propagate Pathauto "delete all aliases" bulk operations to the Views alias index.
- Filter a View by exact alias to locate the content behind a specific URL.
- Support hierarchical-path websites where navigation and listings mirror the URL structure.
- Provide an alias-based contextual filter source for section landing pages.
- Sort search-result Views by alias for predictable ordering.
- Detect alias drift via the runtime "needs rebuild" status warning on admin pages.
- Filter per-language alias rows using the relationship's langcode join.
- Expose alias filtering to editors building custom moderation dashboards as Views.
- Avoid per-row `Url::fromRoute()` alias resolution by joining the precomputed table instead.
