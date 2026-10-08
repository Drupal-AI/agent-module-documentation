# Aggregation functions & hooks

Functions are contributed via `hook_views_aggregation_functions_info()` (see
`views_aggregator.api.php`) and gathered by `views_aggregator_get_aggregation_functions_info()`.
Each entry is keyed by the **function name** (also the callback) and maps to a definition:

```php
'views_aggregator_variance' => [
  'group'  => t('Variance'),   // label in the group select; NULL = not offered as a group function
  'column' => t('Variance'),   // label in the column select; NULL = not offered as a column function
  'is_renderable' => TRUE,     // default TRUE; set FALSE when the result is no longer a single
                               // value the field's original renderer can handle (e.g. enumerations)
],
```

## Hooks

- `hook_views_aggregation_functions_info()` — return the array above to add functions.
- `hook_views_aggregation_functions_info_alter(array &$aggregation_functions)` — modify or
  remove existing definitions. Called after collection and `ksort` by function name.

## Built-in functions (from `views_aggregator_functions.inc`)

Two special functions run first: `views_aggregator_row_filter` ("Filter rows (by regexp) *",
group-only) and `views_aggregator_group_and_compress` ("Group and compress", group-only,
param `case-insensitive`).

Regular functions (offered as both group and column unless noted):

| Function id | Label | Notes |
|---|---|---|
| `views_aggregator_average` | Average * | param = decimal precision |
| `views_aggregator_count` | Count (having regexp) * | `is_renderable=FALSE`; param = regexp |
| `views_aggregator_count_unique` | Count unique (having regexp) * | `is_renderable=FALSE` |
| `views_aggregator_first` | Display first member | group-only (`column`=NULL) |
| `views_aggregator_enumerate_raw` | Enumerate * | `is_renderable=FALSE`; param = separator |
| `views_aggregator_enumerate` | Enumerate (sort, no dupl.) * | `is_renderable=FALSE` |
| `views_aggregator_replace` | Label (enter below) * | `is_renderable=FALSE`; param = text |
| `views_aggregator_maximum` | Maximum | |
| `views_aggregator_median` | Median | |
| `views_aggregator_minimum` | Minimum | |
| `views_aggregator_range` | Range * | param = separator (default ` - `) |
| `views_aggregator_sum` | Sum | |
| `views_aggregator_tally` | Tally members * | `is_renderable=FALSE`; param = separator (default `<br/>`) |

The `views_aggregator_more_functions` submodule adds `views_aggregator_group_seq_number`,
`views_aggregator_range_diff`, and `views_aggregator_percentage`.

See [../api/functions.md](../api/functions.md) for the callback signatures your custom
function must implement.
