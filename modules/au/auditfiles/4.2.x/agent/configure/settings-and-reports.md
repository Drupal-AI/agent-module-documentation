<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings and reports

## Settings (config object `auditfiles.settings`)

Configure form at `/admin/config/system/auditfiles` (route **`auditfiles.configuration`**,
permission `configure audit files reports`). Keys and shipped defaults:

| Key | Default | Meaning |
|---|---|---|
| `auditfiles_file_system_path` | `public` | Which stream scheme to scan (e.g. `public`, `private`). |
| `auditfiles_exclude_files` | `.htaccess` | `;`-separated file names to ignore. |
| `auditfiles_exclude_extensions` | `''` | `;`-separated extensions to ignore. |
| `auditfiles_exclude_paths` | `color;css;ctools;js` | `;`-separated relative paths to skip. |
| `auditfiles_include_domains` | `''` | External domain(s) whose references are treated as local. |
| `auditfiles_report_options_items_per_page` | `50` | Report pager size. |
| `auditfiles_report_options_maximum_records` | `250` | Max records loaded (0 = no limit / "Load all records"). |
| `auditfiles_report_options_date_format` | `long` | Date format used in report columns. |
| `auditfiles_merge_file_references_show_single_file_names` | `false` | Show non-duplicate names in the Merge report. |

Read/write:

```bash
drush config:get auditfiles.settings
drush config:set auditfiles.settings auditfiles_report_options_items_per_page 25 -y
```

The `Drupal\auditfiles\Services\AuditFilesConfig` service (interface
`AuditFilesConfigInterface`) wraps these with typed getters — `getFileSystemPath()`,
`getExcludeFiles()`/`getExcludeExtensions()`/`getExcludePaths()` (returned as arrays),
`getReportOptionsItemsPerPage()`, `getReportOptionsMaximumRecords()`, etc.

## The seven reports

All under `/admin/reports/auditfiles/…` (menu *Reports → Audit Files*, permission
`access audit files reports`). Each is a form that lists mismatches and offers batch fixes.

| Report | Route | Path | Finds |
|---|---|---|---|
| Not in database | `auditfiles.reports.notindatabase` | `/admin/reports/auditfiles/notindatabase` | Files on disk missing from `file_managed`. Fix: delete file, or add to `file_managed`. |
| Not on server | `auditfiles.reports.notonserver` | `/admin/reports/auditfiles/notonserver` | `file_managed` rows whose file is missing on disk. Fix: delete the DB record. |
| Managed not used | `auditfiles.reports.managednotused` | `/admin/reports/auditfiles/managednotused` | Files in `file_managed` but not in `file_usage`. Fix: delete managed file. |
| Used not managed | `auditfiles.reports.usednotmanaged` | `/admin/reports/auditfiles/usednotmanaged` | `file_usage` rows with no `file_managed` record. Fix: delete usage. |
| Used not referenced | `auditfiles.reports.usednotreferenced` | `/admin/reports/auditfiles/usednotreferenced` | `file_usage` rows for files no content field references. Fix: delete usage. |
| Referenced not used | `auditfiles.reports.referencednotused` | `/admin/reports/auditfiles/referencednotused` | File-field references on entities with no `file_usage` row. Fix: delete reference, or add usage. |
| Merge file references | `auditfiles.reports.mergefilereferences` | `/admin/reports/auditfiles/mergefilereferences` | Duplicate `file_managed` records with the same file name. Fix: merge into one. |

`auditfiles.reports` (`/admin/reports/auditfiles`) is just the menu landing page.

Fixes run via the Batch API, and — deliberately — write to the `file_managed`/`file_usage`
tables directly rather than through the File API, so a repair doesn't cascade into new problems.
If a report errors out on a large site, raise/clear `auditfiles_report_options_maximum_records`
and use the report's "Load all records" button.
