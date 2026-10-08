Flag Search API indexes Flag data into Search API so flagged content (and flag counts) can be used in indexes, Views, and facets — including a facet widget that filters a search to the current user's flagged items.

---

The module adds two Search API processors. **Flag indexing** (`flag_indexer`) adds one multi-valued
integer field per selected flag (`flag_<flag_id>`) holding the user IDs of everyone who flagged each
indexed item; **Flag count indexing** (`flag_count_indexer`) adds `flag_<flag_id>_count` fields holding
the number of flaggings. You enable each processor on a Search API index and tick which flags to index;
field values are populated at index time from the Flag service (`getFlaggingUsers`). A
`hook_views_data_alter` turns each indexed `flag_<id>` field into a `search_api_flag` Views field
handler that renders the flag link (via Flag's lazy builder) on search result rows, and a Facets widget
`user_flag` renders a single checkbox that limits results to content the current user has flagged (by
matching their uid against the `flag_<id>` field). An optional setting, "Reindex Item on Flagged
action," makes the module subscribe to Flag's `flag.entity_flagged` / `flag.entity_unflagged` events and
mark the affected item(s) for reindex so flag data stays current without waiting for a full reindex.
Configuration is a single checkbox form at `/admin/config/search/flag-search-api` (permission
`administer search_api`); there are no permissions, plugin types, or Drush commands of its own, and it
depends on both `flag` and `search_api` (plus `facets` to use the widget).

---

- Index which users have flagged each piece of content into a Search API index.
- Index the total flag count per item (e.g. number of bookmarks/likes).
- Expose a "flagged by me" checkbox facet that filters results to the current user's flagged items.
- Show a flag/unflag link on Search API-backed Views result rows.
- Build a "My bookmarks" search page over a Solr/DB Search API index.
- Sort or filter search results by popularity using an indexed flag count.
- Create a facet on flag counts (e.g. items flagged by 10+ users).
- Keep flag data in the index fresh by reindexing items the moment they are flagged/unflagged.
- Support multiple flags in one index (each becomes its own indexed field).
- Filter a view of search results to items flagged by a specific user id.
- Combine flag facets with other Search API facets (categories, tags) on one search page.
- Power a "trending"/"most flagged" block from indexed counts.
- Avoid full reindexes by using event-driven per-item reindex tracking.
- Use flagged-user indexing to build personalized search experiences.
- Add flag-count fields to Search API views for display or aggregation.
- Let editors search only content they have flagged for review.
- Reindex flagged items across all indexes that contain the flagged entity.
- Toggle the reindex-on-flag behavior on or off from one admin checkbox.
