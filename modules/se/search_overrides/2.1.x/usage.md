<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API Solr Overrides lets editors manually **elevate** (force to the top) or **exclude** (hide) specific content for a given search query in a Search API Solr index, via `search_override` config-style entities keyed by the exact search string.

---

The module defines a `search_override` content entity (base table, not config export) — each override stores a `query` string plus reference lists of elevated node ids (`elnid`) and excluded node ids (`exnid`). A `SolrQueryAlterEventSubscriber` listens to `search_api_solr`'s `PreQueryEvent` (`SearchApiSolrEvents::PRE_QUERY`): for each incoming Solr query it looks up an override whose `query` matches the user's search keys (optionally only the entire string, per the `match_entire_string` setting), then adds Solr's native `elevateIds` and `excludeIds` params built from the referenced nodes (via `search_overrides_make_solr_id()`, which builds the per-index/per-language Solr document id). Appending `?ignore_overrides=1` to a search URL bypasses all overrides so an admin can review unmodified results. Overrides are managed at `admin/config/search/search_override` (collection, add/edit/delete forms provided by the entity route provider). A settings form (`search_override.settings`, config `search_overrides.settings`) configures a preview search **path** and query **parameter**, whether to match the entire string, and whether content is picked from nodes or directly from a Solr **index** (with an autocomplete controller `/search_overrides/autocomplete/{index_id}/{count}` returning index hits as JSON). Permissions are `add`/`edit`/`delete`/`administer search overrides` (none `restrict access: true` except `configure search overrides`). Requires `search_api` + `search_api_solr` and a working Solr backend.

---

- Force a specific landing page or article to the top of Solr results for a chosen keyword.
- Exclude an outdated or irrelevant node from results for a particular query.
- Curate "best bets" / promoted results for high-value search terms (brand names, campaigns).
- Pin an official announcement above organic results during an event.
- Hide a deprecated product page from a product-name search without unpublishing it.
- Boost seasonal content (e.g. "sale", "holiday") to the top for the duration of a campaign.
- Match overrides only against the user's entire search string to avoid over-triggering.
- Match overrides against individual terms as well as the full phrase (default behavior).
- Preview how an override changes results using a configured search path + query parameter.
- Review the un-overridden ranking by appending `?ignore_overrides=1` to the search URL.
- Pick content to elevate/exclude by selecting nodes, or directly from a Solr index.
- Use the autocomplete endpoint to search a Solr index by keyword when building an override.
- Remove a single elevated/excluded entity from an override via the remove route (with AJAX table refresh).
- Auto-delete an override when its last elevated/excluded entity is removed.
- Elevate/exclude content per interface language (Solr ids are built per current language).
- Delegate ranking tweaks to editors without touching Solr config or reindexing.
- Manage all overrides from one admin collection page under Configuration → Search.
- Grant a limited "add/edit search overrides" role to marketing without full search admin.
- Add a "Manage search overrides" operation link on node forms/rows (entity operations integration).
- Keep manual result tuning in the database (portable) rather than in Solr's `elevate.xml`.
- Apply Solr's native `elevateIds`/`excludeIds` mechanism without writing Solr XML by hand.
