Views Aggregator Plus More Functions is a lightweight submodule of Views Aggregator Plus that registers three additional aggregation functions — Group sequence number, Range difference, and Percentage — for the "Table with aggregation options" style.

---

This submodule contains no plugins, config or UI of its own; it simply implements `hook_views_aggregation_functions_info()` to add three more functions to the pool that Views Aggregator Plus offers in its per-field group/column selectors. `views_aggregator_group_seq_number` numbers groups sequentially (as a group function, starting at an optional value) and counts group members (as a column function). `views_aggregator_range_diff` returns the numeric difference between the maximum and minimum values of a group or column. `views_aggregator_percentage` expresses each group's contribution as a percentage of the whole (the column result is 100%). It depends on and only works with the parent `views_aggregator` module, and is configured exactly like the built-in functions — by selecting them in a view's table-aggregation style options. Enable it with `drush en views_aggregator_more_functions`.

---

- Number groups 1, 2, 3… in a grouped, aggregated table.
- Start the group sequence from a custom value using the function's parameter.
- Show a running count of members in each group via the "Group count" column function.
- Compute the spread (max − min) of a numeric column per group with "Range difference".
- Display the overall max-minus-min across the entire column as a totals-row value.
- Express each group's turnover as a percentage of total turnover.
- Show a "% of total" column that sums to 100% across groups.
- Build a Pareto-style breakdown table (share per category).
- Add ordinal numbering to ranked report rows.
- Report the value range width for measurements grouped by sensor or location.
- Compute percentage market share per product line.
- Show how many records fall into each group alongside its percentage.
- Combine "Percentage" with the parent module's Sum to display value and share side by side.
- Provide sequential IDs for exported grouped tables.
- Summarize survey responses as a percentage distribution.
- Display price spread (highest − lowest) per product category.
- Add a numbered index column to a subtotals-style report.
- Extend the aggregation function set without writing your own hook implementation.
- Use as a worked example of `hook_views_aggregation_functions_info()` for building custom functions.
- Count group sizes and show group order in the same view.
