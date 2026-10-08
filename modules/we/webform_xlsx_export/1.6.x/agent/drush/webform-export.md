<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `drush webform:export` with the XLSX exporter

`webform_xlsx_export` adds **no Drush command**. It plugs into Webform's own
`webform:export` (alias `wfx`) through the `--exporter` option.

```bash
drush webform:export <webform_id> --exporter=xlsx --destination=/abs/path/file.xlsx
```

`--destination` is effectively required: without it Webform prints the export to stdout,
which is meaningless for a binary workbook.

## Options worth knowing (all from Webform core)

| Option | Notes for XLSX |
|---|---|
| `--exporter` | `xlsx` selects this module. Others: `delimited`, `table`, `json`, `yaml`. |
| `--destination` | Full path and filename for the resulting `.xlsx` (or archive when `--files=1`). |
| `--file-name` | Name pattern for exported submission/uploaded files; supports tokens (`submission-[webform_submission:serial]`). |
| `--header-format` | `label` (default) or `key` — controls the bolded row 1. |
| `--options-item-format` | `label` (default) or `key` for select-list values. |
| `--options-single-format` / `--options-multiple-format` | `separate` (default) or `compact` column layout for options elements. |
| `--multiple-delimiter` | Joins multi-value elements inside one cell (default `;`). |
| `--excluded-columns` | Comma-separated element keys / column ids to leave out. |
| `--entity-reference-items` | Comma-separated subset of `id,title,url`. |
| `--range-type` | `all`, `latest`, `serial`, `sid`, `date` (+ `--range-latest`, `--range-start`, `--range-end`). |
| `--state` | `completed`, `draft`, `all` (default). |
| `--sticky` | Only flagged/starred submissions. |
| `--uid`, `--langcode`, `--order` | Filter by submitter, language; `asc` (default) / `desc`. |
| `--entity-type`, `--entity-id` | Export submissions made from a specific source entity. |
| `--files` | `1` wraps the workbook plus uploaded files in an archive (`--archive-type=tar|zip`). |

`--delimiter` and `--uuid` are CSV-only concepts and have no effect on the XLSX output.

## Examples

```bash
# everything, straight to a file
drush webform:export contact --exporter=xlsx --destination=/tmp/contact.xlsx

# last 100 completed submissions, machine keys as the header row
drush webform:export contact --exporter=xlsx --header-format=key \
  --range-type=latest --range-latest=100 --state=completed \
  --destination=/tmp/contact-latest.xlsx

# submissions made from node 42
drush webform:export contact --exporter=xlsx \
  --entity-type=node --entity-id=42 --destination=/tmp/contact-node42.xlsx

# nightly cron job
0 2 * * * cd /var/www/html && \
  drush webform:export contact --exporter=xlsx --destination=/backups/contact-$(date +\%F).xlsx
```

## Checking the result

```bash
file /tmp/contact.xlsx          # → Microsoft Excel 2007+
drush php:eval 'print \PhpOffice\PhpSpreadsheet\IOFactory::identify("/tmp/contact.xlsx");'   # → Xlsx
```
