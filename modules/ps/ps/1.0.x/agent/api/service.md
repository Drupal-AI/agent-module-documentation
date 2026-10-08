# `ps.service` — the `ParagraphsStats` service

`Drupal\ps\ParagraphsStats` (service id `ps.service`) holds all report logic; the controller just
dispatches to it. Constructor deps: `config.factory`, `entity_field.manager`, `entity_type.manager`,
`path.current`, `path_alias.manager`, `pager.manager`, `database`.

## Useful public methods

| Method | Returns | Purpose |
|---|---|---|
| `updateStructure()` | render array | Rebuild `paragraphs_stats_inuse` from fields with `target_type == paragraph`. Call before reporting. |
| `showUtilizationReport()` | render array | The main matrix table + export/update buttons. |
| `showUtilizationDrillDown($contentType, $paragraph, $bundle)` | render array | Parent entities for one cell. |
| `showParagraphUsage(ParagraphInterface $paragraph)` | render array | Everywhere a specific paragraph id is used. |
| `exportCsv()` | Symfony `Response` | The matrix as a CSV download. |
| `getParaTypes()` | array | `machine_name => label` of all paragraph types (`paragraphs_type_get_types()`). |

## Programmatic example

```php
// drush php:eval — rebuild metrics then dump the paragraph usage matrix as plain counts.
$svc = \Drupal::service('ps.service');
$svc->updateStructure();               // populate paragraphs_stats_inuse
$build = $svc->showUtilizationReport(); // render array (rows carry v-<level> classes)
```

## Data model & queries

- Metrics table `paragraphs_stats_inuse` columns: `paragraph_name`, `entity_type`, `bundle`,
  `field_name`. Populated only by `updateStructure()`.
- Report counts come from `getSqlCore()` which UNIONs one `getSqlBundle($type)` per parent type in
  `{node, paragraph, block_content}` over `paragraphs_item_field_data`, left-joined to the parent table
  and to each paragraph source field table.
- `getMinMax()` derives the count thresholds that map a cell count to `usage_level` 0-4.
- All user-supplied route args (`contentType`/`paragraph`/`bundle`) are `Xss::filter()`-ed and passed as
  bound `:placeholders`; the interpolated `parent_type` is whitelist-restricted.
