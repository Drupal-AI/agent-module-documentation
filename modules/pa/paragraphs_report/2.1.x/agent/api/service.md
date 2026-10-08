<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `paragraphs_report.report` service & data storage

Service `paragraphs_report.report` → `Drupal\paragraphs_report\ParagraphsReport` holds all logic.

## Where report data lives

**Not in config.** The computed report is stored in the **key-value** collection
`paragraph_report.report_data` under key `data` (constant `ParagraphsReport::COLLECTION`). Shape:

```
data[<paragraph_type>][<parent>][] = <nid>   // parent is 'top' for node-level, or the parent paragraph bundle
```

Read it directly:

```php
$data = \Drupal::keyValue('paragraph_report.report_data')->get('data', []);
```

`hook_install` seeds it to `[]`; `hook_uninstall` clears it and deletes `paragraphs_report.settings`.
(History: older versions kept this in config `report`, then State; update hooks 10001/10002 migrated it to
key-value.)

## Useful methods

- `getNodes()` — node ids of the configured `content_types`.
- `batchPrep(array $nids)` — builds the batch used by the report rebuild.
- `getParasFromNid($nid, array $current = [])` — recursively collects paragraph usage for one node.
- `getParaFieldsOnType($entity_type, $bundle)` — paragraph-reference field names on a bundle.
- `getParaUseCounts($filter = 'all')` — usage counts per paragraph type (`'empty'` → unused types).
- `insertParagraphs()/updateParagraphs()/deleteParagraphs()` — called from node hooks when `watch_content`
  is on (guarded by `checkWatch()`: only for configured content types).
- `configSaveReport(array)` — writes the `data` key; `exportReport()` streams the CSV.

## Automatic updates

`paragraphs_report.module` implements `hook_node_insert/update/delete`, each delegating to the service. They
only mutate report data when `watch_content` is TRUE **and** the node's bundle is in `content_types`
(`checkWatch()`); otherwise the report only changes when you run `paragraphs_report:update`.
