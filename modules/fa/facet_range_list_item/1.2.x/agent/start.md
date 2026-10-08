# Facet Range list Item — agent index

Search API Facets add-on: buckets a numeric field into custom `start-stop|label` ranges. Provides a
Facets build processor and a query-type plugin; no config UI, permissions, schema, or Drush. Requires
`facets` and `search_api`.

- **Setting up the processor on a facet, the range-list format, and how the plugins work** →
  [configure/facet.md](configure/facet.md)

Key facts:
- Processor plugin `range_list_item` (`@FacetsProcessor`, `src/Plugin/facets/processor/RangeListItem.php`),
  build stage weight 35; query type `search_api_range_list`
  (`@FacetsQueryType`, extends `QueryTypeRangeBase`).
- `facet_range_list_item.module` alters the `numeric_range` query-type mapping to `search_api_range_list`.
- Range config stored in the processor's `range_list` setting on the facet.
