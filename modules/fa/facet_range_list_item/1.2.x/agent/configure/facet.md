# Facet Range list Item — setup and internals

## Setup

1. Index a numeric (integer/decimal) field with Search API and create a Facet on it
   (*Configuration > Search and metadata > Facets*).
2. On the facet's edit page enable the **Range List Item Processor** checkbox.
3. In its **Enter Range** textarea, add one range per line as `key|label`, where `key` is a numeric
   `start-stop` range:
   ```
   0-20|0-20 Minutes
   20-40|20-40 Minutes
   40-999|40+ Minutes
   ```
   Validation requires each range's start and stop to be numeric (integer or decimal).
4. Save. The facet now shows your labels; selecting one filters results to that numeric range.

There is no module settings page — everything is on the facet. No permissions are added.

## How it works

- **Processor** `range_list_item` (`RangeListItem`, `BuildProcessorInterface`, build stage weight 35):
  parses `range_list` into `start => label`, then in `build()` rewrites each result's display value to
  the matching label (`setDisplayValue`). Its `getQueryType()` returns `numeric_range`.
- **Query-type mapping**: `facet_range_list_item_facets_search_api_query_type_mapping_alter()` maps
  `numeric_range` -> `search_api_range_list`, so this module's query type is used.
- **Query type** `search_api_range_list` (`SearchApiRangeList` extends `QueryTypeRangeBase`): parses the
  same `range_list` into `start => stop`. `calculateResultFilter($value)` finds the range where
  `start <= value <= stop` and returns that range's start as the display/raw value; `calculateRange()`
  returns `['start' => value, 'stop' => range_list[value]]` for building the backend range filter.

## Notes

- Ranges are inclusive on both ends (`>=` start and `<=` stop). Overlapping ranges resolve to the first
  match in definition order.
- Use a large stop value (e.g. `40-999`) to emulate an open-ended "N and above" bucket.
