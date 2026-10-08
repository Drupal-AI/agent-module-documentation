Facet Range list Item adds a Search API Facets processor that groups a numeric (integer/decimal) field into operator-defined ranges you specify as `start-stop|label` lines, so a facet shows custom buckets (e.g. "0-20 Minutes", "40+ Minutes") instead of individual values.

---

The module provides one Facets build processor plugin (`range_list_item`, "Range List Item Processor") and one Facets query-type plugin (`search_api_range_list`, extending `QueryTypeRangeBase`). Enable the processor on a number facet and enter one range per line in the format `key|label` where the key is a numeric `start-stop` range (e.g. `0-20|0-20 Minutes`, `40-999|40+ Minutes`). At query time the query type maps each indexed value into the range whose `start <= value <= stop` and filters/aggregates on the range start; at display time the processor rewrites each result's display value to your configured label. A `hook_facets_search_api_query_type_mapping_alter` swaps the default `numeric_range` query type for this module's `search_api_range_list`. It requires the Facets and Search API modules, has no config UI of its own (configuration lives on the facet's edit form), no permissions, and no config schema.

---

- Bucket a "duration" field into ranges like 0-20, 20-40, 40+ minutes on a facet.
- Show price ranges (e.g. `0-50|Under $50`) as facet options instead of every price.
- Group an age or year field into decade/range buckets in search facets.
- Provide human-readable labels for numeric range buckets in the facet UI.
- Facet a decimal rating field into ranges (e.g. `4-5|4 stars & up`).
- Filter Search API results by a user-selected numeric range.
- Replace a noisy numeric facet (hundreds of exact values) with a few meaningful ranges.
- Aggregate result counts per range rather than per exact value.
- Configure open-ended top buckets using a large stop value (e.g. `40-999`).
- Define non-uniform ranges (varying widths) per facet.
- Reuse the same range definition across integer and decimal fields.
- Localize/adjust bucket labels without changing indexed data.
- Support any Search API backend via the default range query type.
- Combine range facets with other Search API facets on the same view.
- Present distance/size/weight ranges as filter options.
- Offer "N and above" style filters by setting a high upper bound.
- Keep the underlying field values unchanged while presenting grouped labels.
