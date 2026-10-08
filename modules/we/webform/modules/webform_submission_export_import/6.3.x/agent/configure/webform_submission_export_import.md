# Import/export submissions

No settings form — the module adds an upload flow and an exporter to each webform. Access is
gated by core Webform results permissions.

## Import via UI
`/admin/structure/webform/manage/{webform}/results/upload`
(route `entity.webform_submission_export_import.results_import`; node variant
`entity.node.webform_submission_export_import.results_import`) — upload a CSV to create/update
submissions. Build a correctly shaped file from:
- Example download: `…/results/upload/example/download`
- Example view: `…/results/upload/example/view`

## Exporter plugin
`WebformExporter` plugin
`Drupal\webform_submission_export_import\Plugin\WebformExporter\WebformSubmissionExportImportWebformExporter`
appears in the normal results **Download** exporter list and produces an import-compatible CSV.

## Importer service (API)
`webform_submission_export_import.importer` →
`WebformSubmissionExportImportImporterInterface`
(`Drupal\webform_submission_export_import\WebformSubmissionExportImportImporter`). Maps CSV
columns to elements, validates rows, resolves source-entity/file references, and returns
created/updated/skipped totals. Injected deps: `config.factory`, `logger.factory`,
`entity_type.manager`, `plugin.manager.webform.element`, `file_system`.
Get it with `\Drupal::service('webform_submission_export_import.importer')`.
