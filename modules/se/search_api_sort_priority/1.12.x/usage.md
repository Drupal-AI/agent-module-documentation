Search API Sort Priority adds Search API index processors that inject a hidden integer "weight" field per item, letting you assign arbitrary sort priority to content by bundle, media bundle, paragraph bundle, file MIME type, author role, or view statistics — then sort search results on that weight.

---

The module provides six `@SearchApiProcessor` plugins, each of which, when enabled on a Search API index,
auto-creates a hidden integer field on the index and populates it at index time with a configurable weight:
`contentbundle` (→ `contentbundle_weight`, per node content type), `mediabundle` (→ `mediabundle_weight`),
`paragraphbundle` (→ `paragraphbundle_weight`), `filemime` (→ `filemime_weight`, per file MIME type),
`role` (→ `role_weight`, using the highest-weighted role of the item's author), and `statistics` (→
`statistics_weight`, using the node's total view count from the core Statistics module). Each processor's
config form is a tabledrag table where you drag the bundles/roles into priority order (weights are stored in
`sorttable[<id>].weight`); `preIndexSave()` ensures/hides the field and `addFieldValues()` writes the
resolved weight onto each indexed item. Processors declare `supportsIndex()` so they only appear for indexes
whose datasource matches (node for content/role/statistics, file for filemime, etc.). You then add the
generated `*_weight` field as a sort in a Search API view (or a Solr sort). A submodule,
`search_api_sort_priority_solr`, maps these weight fields to single-valued Solr fields so sorting works on
Solr backends. The module has no settings page, permissions, or Drush commands — all configuration lives on
the index's Processors tab.

---

- Boost one content type above others in search results (e.g. News before Pages).
- Assign an explicit priority order to node content types via a drag-and-drop weight table.
- Sort search results by the author's role (e.g. content by Admins ranks above Editors).
- Prioritise search results by node popularity using the Statistics view count.
- Rank media items by media bundle (e.g. Video before Image).
- Rank paragraph items by paragraph bundle in indexed paragraph content.
- Order file search results by MIME type (e.g. PDFs before spreadsheets).
- Add a hidden `contentbundle_weight` field to an index and sort a Search API view on it.
- Create tiered search relevance without hand-writing Solr boost queries.
- Combine a weight sort with relevance so ties break by editorial priority.
- Feature "important" content types at the top of a global site search.
- Give admin/editor-authored content higher visibility in autocomplete/search.
- Sort a media library search by asset type priority.
- Use the `role_weight` field (highest role weight of the author) as a secondary sort key.
- Sort a document search so the most-viewed pages surface first (statistics).
- Support Solr backends by mapping weight fields to single-valued Solr fields (solr submodule).
- Hide the weight field from display while still using it for sorting (fields are auto-hidden).
- Re-order priorities later by dragging rows on the processor config form and re-indexing.
- Apply different priority schemes on different indexes.
- Drive faceted/sorted search UIs that respect an editorial ranking of bundles.
