Views Aggregator Plus (VAgg+) adds a Views table style, "Table with aggregation options", that aggregates the rendered result set *after* the database query runs, enabling grouping and summary functions the SQL layer cannot do.

---

Views Aggregator Plus provides a single Views style plugin, `views_aggregator_plugin_style_table`, that extends the core Table style. Because it works on the rendered results rather than the raw query, it can group rows on the identical value of one column ("Group and compress") while applying summary functions (Sum, Average, Count, Median, Min, Max, Tally, Enumerate, Range, Label, Filter rows, Display first) to the other columns. Each field in the view can independently carry a *group* aggregation function (one row per group) and/or a *column* aggregation function (a totals row shown in the table header, footer or caption). Functions marked with an asterisk take an optional parameter such as a regexp, a rounding precision, or a separator. Instead of collapsing groups you can keep every row and show per-group subtotals with a configurable label prefix/suffix and CSS classes. It works with "Global: Custom text" fields using Twig (e.g. `number_format`) so computed columns aggregate correctly, and cooperates with Webform submission and Commerce fields. There are no permissions and no global settings — everything is configured per view in the style options. Custom aggregation functions can be added by other modules via `hook_views_aggregation_functions_info()`; the bundled `views_aggregator_more_functions` submodule demonstrates this. Note it does not combine with Views' native SQL aggregation ("Use aggregation: No" must be set).

---

- Group table rows on a shared column value (e.g. taxonomy term, industry) and collapse them into one row per group.
- Show a SUM totals row across a numeric column at the bottom (footer), top (header) or caption of a table.
- Compute the AVERAGE of a column, optionally rounded to a chosen number of decimals.
- Display MIN, MAX or MEDIAN of a numeric column per group or across the whole table.
- Produce a TALLY (textual histogram) of values in the form `Value(x)` for each group.
- ENUMERATE all member values of a group as a delimited list, with an option to sort and drop duplicates.
- Count unique values in a column ("Count unique"), optionally restricted by a regexp.
- Filter out result rows whose field matches (or fails to match) a regular expression, before aggregating.
- Count rows per group that match a "having" regexp.
- Show the RANGE of a column as "first/min [separator] last/max".
- Display only the first member of each group.
- Add a static LABEL cell (e.g. "Totals") to a grouped or totals row.
- Keep all rows but insert per-group subtotal rows, like a spreadsheet subtotal report.
- Add configurable prefix/suffix text (e.g. " - Sum") to subtotal labels.
- Aggregate over computed "Global: Custom text" columns written in Twig (multiply/format fields).
- Respect Twig `number_format` decimal and thousand separators when summing formatted values.
- Aggregate Webform submission "Value" fields (with Webform 8.x-5.x).
- Aggregate Commerce 2.x price/product fields.
- Apply case-insensitive grouping via the "Group and compress" `case-insensitive` parameter.
- Compute column totals over the entire result set even when a pager limits the visible page.
- Restrict column totals to just the visible page or offset subset for performance.
- Assign CSS classes to grouped cells, subtotal rows and the totals row for custom styling.
- Combine several Views fields into one render column with a chosen separator, then aggregate.
- Extend the function set with your own group/column functions via `hook_views_aggregation_functions_info()`.
- Alter or remove existing aggregation functions via `hook_views_aggregation_functions_info_alter()`.
- Add "Group sequence number", "Range difference" and "Percentage" functions by enabling the `views_aggregator_more_functions` submodule.
- Build financial or inventory summary tables (turnover per industry, stock per warehouse) without custom code.
