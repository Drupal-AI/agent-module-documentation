# other_view_filter — agent start

Adds one Views filter, **"Other view result"** (`other_views_filter`, class `OtherView`
extends core `InOperator`), that filters the current view against the result IDs of one or
more other `view:display` combos. Operator defaults to **not in** (exclude). Registered on
every content-entity base table, Search API index tables, and any base-field table via
`hook_views_data_alter()`. No settings form / permissions / Drush — configured entirely in
the Views UI. Depends on `views`.

- How to add and configure the filter, options, performance, edge cases → [configure/other_view_filter.md](configure/other_view_filter.md)
