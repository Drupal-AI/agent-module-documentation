# Views Aggregator Plus More Functions (views_aggregator_more_functions)

`part_of: views_aggregator`. A one-file submodule that adds three aggregation functions to
Views Aggregator Plus via `hook_views_aggregation_functions_info()`. No config, no plugins,
no permissions. Depends on `views_aggregator`.

Functions added (select them in a view's "Table with aggregation options" style options,
same as the built-ins — see the parent's
[hooks/aggregation-functions.md](../../../../2.1.x/agent/hooks/aggregation-functions.md)):

| Function id | Group label | Column label | Notes |
|---|---|---|---|
| `views_aggregator_group_seq_number` | Group sequence no. * | Group count | group: numbers groups (optional start value, default 1); column: counts members |
| `views_aggregator_range_diff` | Range difference | Range difference | maximum − minimum of the group/column |
| `views_aggregator_percentage` | Percentage | 100% | each group's share of the whole; column result is 100 |

Enable: `drush en views_aggregator_more_functions`.
