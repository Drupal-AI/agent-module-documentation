# webform_submission_export_import — agent start

Adds submission **import** (upload CSV to create/update submissions) plus an import-shaped
CSV exporter. Depends only on `webform`. No permissions/drush/config schema. Upload form at
`/admin/structure/webform/manage/{webform}/results/upload`; importer service
`webform_submission_export_import.importer`.

- Upload flow, example CSV & importer service → [configure/webform_submission_export_import.md](configure/webform_submission_export_import.md)
