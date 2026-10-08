<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Product CSV — import/export

## Access
Single permission `administer product csv` (restrict access: true) on all routes; `ProductCsvOverviewController::accessProductType` additionally requires the `{product_type}` to be a real product bundle.

## Import
`ProductCsvImportForm` — `managed_file` field with `#upload_validators => ['FileExtension' => ['extensions' => 'csv']]`. On submit it resolves the file URI with `file_system` realpath, `fopen(..., 'r')`, reads the header row with `fgetcsv`, then iterates rows creating/updating products of the chosen type. `ProductCsvManager` maps columns onto product fields, paragraph sub-fields, taxonomy terms and media.

## Export / sample
`ProductCsvExportController::export($product_type)` → `StreamedResponse` writing to `php://output` with `Content-Disposition: attachment; filename=products-export-{type}-{date}.csv`. `::sample($product_type)` returns a header + example rows so users learn the format.

## Notes for agents
- No user-controlled file path; the only input is the uploaded CSV content.
- Import runs with the admin's privileges — it can create products and resolve taxonomy/media by the CSV's values.
