# Settings

Route `entity_reports.settings_form` -> `/admin/config/development/entity-reports`
(`\Drupal\entity_reports\Form\EntityReportsSettingsForm`, form id `entity_reports_settings_form`).
Requires the `administer entity reports` permission. Editable config object: `entity_reports.settings`.

## Config keys

| Key | Type | Purpose |
|---|---|---|
| `reported_entity_types` | sequence of strings | Entity type ids to expose reports for. **Empty = all fieldable entity types are reported** (the form description says "When all available options are unchecked, all fieldable entity types are reported"). Only entity types implementing `FieldableEntityInterface` are offered. |
| `report_fields` | sequence of mappings | The columns shown in each structure table and their order/visibility. Each item is `{machine_name, label, weight, status}`. |

`report_fields` machine names map to data produced by `ReportGenerator` (see api/report-generator.md).
Default install config (`config/install/entity_reports.settings.yml`) ships these 8 rows, all enabled:

| weight | machine_name | label |
|---|---|---|
| 0 | `label` | Field name |
| 1 | `machine_name` | Machine Name |
| 2 | `description` | Description |
| 3 | `type` | Data type |
| 4 | `required` | Required |
| 5 | `translatable` | Translatable |
| 6 | `target` | Target |
| 7 | `cardinality` | Cardinality |

The form lets you drag to reorder (`weight`) and toggle each column (`status` checkbox), and pick the
reported entity types (checkboxes). On submit it re-sorts `report_fields` by weight, saves, then calls
`router.builder->rebuild()` and `cache.render->invalidateAll()` — because the set of generated routes
(and menu/tab links) depends on `reported_entity_types`, changing it rebuilds routing immediately.

## Schema

`config/schema/entity_reports.schema.yml` types `entity_reports.settings` as a `config_object` with
`reported_entity_types` (sequence of string) and `report_fields` (sequence of mapping:
`machine_name` string, `label` string, `weight` integer, `status` boolean).

## Set without the UI

```php
// Report only nodes and taxonomy terms.
\Drupal::configFactory()->getEditable('entity_reports.settings')
  ->set('reported_entity_types', ['node', 'taxonomy_term'])
  ->save();
\Drupal::service('router.builder')->rebuild();
```

```bash
# Reset to "all fieldable entity types".
ddev drush config:set entity_reports.settings reported_entity_types '[]' -y
ddev drush cache:rebuild
```

Note: `entity_reports_update_8101()` (in `.install`) re-installs the default config if `report_fields`
is empty, so an install that predates the field-config gains the default columns on update.
