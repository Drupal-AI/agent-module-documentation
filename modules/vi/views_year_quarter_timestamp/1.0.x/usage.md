<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Year-Quarter Timestamp provides a global Views field that computes a timestamp from a year value and a quarter value (Q1–Q4), useful for charting or sorting quarterly data sourced from taxonomy terms.
---
The module registers Views data (`hook_views_data`) for a Global field `field_views_year_quarter_timestamp` and a companion sort `views_year_quarter_timestamp_sort`. The field plugin (`YearQuarterTimestamp`, `FieldPluginBase`) exposes two option selects — "Year Provider" and "Quarter Provider" — that point at other fields earlier in the same display. At output it loads the referenced taxonomy terms (interpreting the field option as a term-reference target id), reads their names as the year (e.g. `2024`) and quarter (`Q1`–`Q4`), maps the quarter to a starting month (Q1→01, Q2→04, Q3→07, Q4→10), builds a `YYYY-MM-01` string in UTC and returns the timestamp multiplied by 1000 (JavaScript milliseconds).

The sort plugin is a thin `SortPluginBase` stub with an empty `query()`. Note the field assumes the year/quarter providers resolve to taxonomy term-reference target ids following a specific `entitytype__field_field_target_id` naming convention, so it is tailored to taxonomy-based year/quarter fields.
---
- Add the "Year-Quarter Timestamp Field" (Global) to a View.
- Select a "Year Provider" field that outputs a year value.
- Select a "Quarter Provider" field that outputs Q1–Q4.
- Produce a millisecond JS timestamp for charting libraries.
- Feed quarterly taxonomy data into a timeline/graph.
- Map Q1→January, Q2→April, Q3→July, Q4→October.
- Build the date as `YYYY-MM-01` in the UTC timezone.
- Reference taxonomy term names for the year and quarter values.
- Only choose provider fields that appear earlier in the display.
- Exclude helper fields from output while still using them as providers.
- Add the companion "Year-Quarter Timestamp Sort" to a View.
- Sort rows by the computed quarter timestamp.
- Compute timestamps without writing a custom Views field handler.
- Combine year and quarter taxonomy fields into one sortable value.
- Return 0 when year or quarter is missing.
- Drive quarter-based reporting dashboards.
- Convert fiscal-quarter labels to comparable timestamps.
- Support Drupal 9, 10 and 11 sites using Views.