# ReportGenerator service (entity_reports.generator)

Service id `entity_reports.generator` = `\Drupal\entity_reports\ReportGenerator`. Injects
`entity_field.manager`, `entity_type.manager`, `entity_type.bundle.info`, `language_manager`,
`config.factory`. Use it to obtain the same structure/statistics data the report pages render.

## Public methods

| Method | Returns |
|---|---|
| `getEntityTypeStructure(string $entity_type)` | Array keyed by bundle machine name; each value is `['label' => ..., 'fields' => [...], 'statistics' => [...]]`. Bundles sorted by label. |
| `generateEntityFieldsReport(string $entity_type, string $bundle)` | Array of per-field data keyed by field name. Skips base fields and any field without a target bundle (i.e. only configured/bundle fields). Adds a `field_name.column_name` row for each column of multi-column field storage. Sorted by label. |
| `generateEntityStatisticsReport(string $entity_type, string $bundle)` | One statistics row: `label`, `id` (bundle), `translatable`, `count`, plus a count per language keyed by langcode (or `N/A` if the entity type has no `langcode` field). |
| `getBundleNames(array $machine_names, string $entity_type)` | Map machine name -> "Label (machine_name)" for a list of bundles. |
| `getBundleName(string $machine_name, string $entity_type)` | Human bundle label for one machine name (falls back to the machine name). |

## Per-field data shape (`fieldData()`)

Each field entry from `generateEntityFieldsReport()` has: `label`, `machine_name`, `description`,
`type`, `required` (bool) + `required_human`, `translatable` (bool) + `translatable_human`,
`target` (comma-joined target bundle labels for entity references), `cardinality` (int) +
`cardinality_human`. For `entity_reference` fields the `type` is suffixed with the target entity
type, e.g. `entity_reference (taxonomy_term)`. Cardinality `-1` renders as "Unlimited values".

The `_human` variants are the display strings; the controller prefers `{key}_human` when present,
otherwise the raw value.

## Example

```php
/** @var \Drupal\entity_reports\ReportGenerator $gen */
$gen = \Drupal::service('entity_reports.generator');
$structure = $gen->getEntityTypeStructure('node');
foreach ($structure as $bundle => $data) {
  echo $data['label'] . ': ' . count($data['fields']) . " fields, "
    . $data['statistics']['count'] . " entities\n";
}
```

Note: the statistics instance count uses `->accessCheck(FALSE)` — it counts every entity of the
bundle regardless of the current user's access. It is a plain count only, surfaced on the
permission-gated admin pages.
