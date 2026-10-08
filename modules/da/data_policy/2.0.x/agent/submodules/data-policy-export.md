<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Submodule: `data_policy_export`

Adds a **Views Bulk Operations (VBO) action** that exports selected `user_consent` records to a
CSV. This is the practical answer to a GDPR subject-access request: "give me the consent record".

## Dependencies

`views_bulk_operations`, `csv_serialization`, and `data_policy`. Core `^10.1 || ^11`. Ships with
version 2.0.9.

## How it wires up

- `hook_install()` (`data_policy_export.install`) injects a `views_bulk_operations_bulk_form` field
  (with the export action pre-selected) into the shipped `data_policy_agreements` view, so the bulk
  action appears on `/admin/reports/data-policy-agreements` (view access =
  `overview user consents`). `hook_uninstall()` removes the field.
- `config/install/system.action.data_policy_export_data_policy_action.yml` registers the action
  (`type: user_consent`).

## The action — `ExportDataPolicy` (`src/Plugin/Action/ExportDataPolicy.php`)

`@Action(id = "data_policy_export_data_policy_action", type = "user_consent", confirm = FALSE)`,
extends `ViewsBulkOperationsActionBase`.

- `access()` returns `$object->access('view', $account, …)` on each `user_consent` entity — i.e.
  the operator must have **view access to the consent entity**, which (no custom access handler)
  means the `overview user consents` admin permission. So a user cannot select-and-export consent
  rows they could not already see in the report.
- `executeMultiple()` batches the selected consents into a CSV with columns **Name / State /
  Datetime** (owner display name, readable state, changed date). It writes to a temp file, then
  copies it to `private://csv/export-data-policies-<12 hex>.csv` and shows a *Download file* link.
- Extra columns can be added by other modules through the plugin type below.

## Private-file download gate — `data_policy_export_file_download()`

`hook_file_download()` in `data_policy_export.module`. For a `private://csv/export-data-policies-<12
hex>.csv` URI it looks up the managed file and grants the download **only** to a user with
`administer users` **or** the file's own owner (the account that ran the export). Everyone else gets
`NULL` (403). The randomised 12-hex filename plus the private stream plus this owner check mean an
exported CSV is not reachable by guessing or by another logged-in user.

## Plugin type — `Plugin/DataPolicyExportPlugin`

The submodule defines its own plugin type (`DataPolicyExportPluginManager`, `@DataPolicyExportPlugin`
annotation, `DataPolicyExportPluginBase` / `DataPolicyExportPluginInterface`) so other modules can
contribute extra CSV columns via `getHeader()` / `getValue(DataPolicyInterface $entity)`. This is
the only custom plugin type in the whole project, and it lives in the submodule, not the main module.
