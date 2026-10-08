# Configuration

Audit Files has one settings form, two permissions, and seven reports. This page
covers all three.

## The settings form

Go to **Configuration → System → Audit Files** (`/admin/config/system/auditfiles`).
You need the *Configure Audit Files module* permission. The settings are stored in
the `auditfiles.settings` config object:

| Setting | Default | What it does |
|---|---|---|
| **File system path** (`auditfiles_file_system_path`) | `public` | Which storage scheme to scan — e.g. `public` or `private`. |
| **Exclude files** (`auditfiles_exclude_files`) | `.htaccess` | File names to ignore, separated by semicolons. |
| **Exclude extensions** (`auditfiles_exclude_extensions`) | *(empty)* | File extensions to ignore, separated by semicolons. |
| **Exclude paths** (`auditfiles_exclude_paths`) | `color;css;ctools;js` | Relative paths to skip, separated by semicolons — useful for skipping system-generated directories. |
| **Include domains** (`auditfiles_include_domains`) | *(empty)* | External domain(s) whose references should be treated as local. |
| **Items per page** (`auditfiles_report_options_items_per_page`) | `50` | Report pager size. |
| **Maximum records** (`auditfiles_report_options_maximum_records`) | `250` | Most records a report loads at once. `0` means no limit ("load all records"). |
| **Date format** (`auditfiles_report_options_date_format`) | `long` | Date format used in report columns. |
| **Show single file names in Merge report** (`auditfiles_merge_file_references_show_single_file_names`) | off | Whether the Merge report also lists non-duplicate names. |

On a very large site, if a report struggles to load, raise or clear the **Maximum
records** limit and use the report's own *Load all records* button. You can also
read and change settings from the command line:

```bash
drush config:get auditfiles.settings
drush config:set auditfiles.settings auditfiles_report_options_items_per_page 25 -y
```

## The two permissions

| Permission | Machine name | Gates |
|---|---|---|
| **Access Audit Files reports** | `access audit files reports` | Viewing and running all seven reports under `/admin/reports/auditfiles`. |
| **Configure Audit Files module** | `configure audit files reports` | The settings form above. Flagged as security-sensitive. |

Because the fix actions can permanently delete files and database records, treat
**both** permissions as sensitive and grant them only to trusted roles.

## The seven reports

All live under **Reports → Audit Files** (`/admin/reports/auditfiles/…`). Each
report is a form that lists the mismatches it finds and offers batch fix actions.

| Report | What it finds | How you fix it |
|---|---|---|
| **Not in database** | Files on disk with no `file_managed` record. | Delete the file, or add it to the database so Drupal tracks it. |
| **Not on server** | Database file records whose actual file is missing from disk. | Delete the stale database record. |
| **Managed not used** | Managed files that no content uses. | Delete the managed file. |
| **Used not managed** | Usage records with no matching managed-file record. | Delete the usage record. |
| **Used not referenced** | Files marked used but no longer referenced by any content field. | Delete the usage record. |
| **Referenced not used** | File references on content that have no usage record. | Delete the reference, or add the missing usage record. |
| **Merge file references** | Duplicate managed-file records pointing at the same file name. | Merge them into one. |

`/admin/reports/auditfiles` itself is just the landing page linking to these seven.

Remember that fixes run through Drupal's batch system and write to the file tables
**directly** (not through the File API) — a deliberate design choice so a repair
does not cascade into new problems. Always back up before a large clean-up.
