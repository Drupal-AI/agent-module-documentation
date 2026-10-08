<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `content_export_csv.export` service

Service id **`content_export_csv.export`** → class `Drupal\content_export_csv\ContentExport`
(constructed with `@entity_type.manager`, `@entity_field.manager`). Call it to build CSV data
without the form.

## Public methods

| Method | Returns | Purpose |
|---|---|---|
| `getContentTypes()` | `array` | `[bundle => label]` of all node types. |
| `getValidFieldList(string $type)` | `string[]` | Field machine names for the bundle, minus a fixed blocklist. |
| `getNodeIds(string $type, int $status = 1)` | `array` | Node ids of that type filtered by status (`1`=published, `0`=unpublished). Access-checked query. |
| `getNodeData(EntityInterface $node, array $fields = [], int $includeUrls = 0, int $stripTags = 1)` | `array` | One node → array of quoted cell values. Empty `$fields` = all valid fields. |
| `getNodeDataList(array $ids, array $fields = [], int $includeUrls = 0, int $stripTags = 1)` | `string[]` | Loads ids and returns one comma-joined CSV line per node. |
| `getNodeCsvData(string $type, int $status = 1, array $fields = [], int $includeUrls = 0, int $stripTags = 1)` | `string[]` | Convenience: ids for `$type`/`$status` → array of CSV lines. The main entry point. |
| `getData(EntityInterface $node, string $field, string $option)` | `string` | Pipe-joins one `$option` (e.g. `value`, `uri`, `target_id`) across a field's deltas. |

### Blocklisted fields (never in `getValidFieldList()`)

`comment`, `content_translation_source`, `content_translation_outdated`, `sticky`,
`revision_default`, `revision_translation_affected`, `revision_timestamp`, `revision_uid`,
`revision_log`, `vid`, `uuid`, `promote`.

### Value handling

Each cell is wrapped in `"..."`. Multi-value fields are joined with `|`. For a field with a
scalar `value` that is used; else a `LinkItemInterface` exports `uri`, an entity reference
exports `target_id`, otherwise `langcode`. With `$stripTags = 1` values are `strip_tags()` +
`htmlspecialchars()`. With `$includeUrls = 1` the node's absolute URL is appended as a trailing
cell.

## Example: write a CSV file in code

```php
$svc = \Drupal::service('content_export_csv.export');
$fields = $svc->getValidFieldList('article');          // or a chosen subset
$rows   = $svc->getNodeCsvData('article', 1, [], 0, 1); // published, all fields, strip tags
$header = implode(',', $fields);
$path   = \Drupal::service('file_system')->realpath('public://') . '/my_export.csv';
file_put_contents($path, $header . "\n" . implode("\n", $rows) . "\n");
```

Note: the header from the form uses the *selected* field names (or all valid fields), and
appends `url` when `include_node_urls` is set — mirror that if you need an exact match.
