<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HTML Tag Usage — configure & operate

Analyzes formatted-text field content across the site and reports which HTML
tags/attributes are actually in use per text format. Best run in a dev/staging
environment (the results table can grow large) and uninstalled when done.

## Configure which fields to scan
Route `html_tag_usage.configure` — `/admin/config/development/html_tag_usage`
(permission `administer html tag usage`). Select the **field types** to analyze;
defaults to the formatted-text field types provided by core `text`. Stored in
`html_tag_usage.configuration:field_types`.

## Generate the report
1. Go to *Reports > HTML Tag Usage* (`/admin/reports/html_tag_usage`,
   permission `view html tag usage report`).
2. Click **Generate report** (route `html_tag_usage.analyze`, permission
   `generate html tag usage report`, protected by a CSRF token). A Batch loads
   every field of the selected types, parses each value with
   `Html::load()` and records tag/attribute counts into the `html_tag_usage`
   table (truncated at the start of each run).
3. The report lists, per text format, each tag+attribute with a count. `*` as the
   attribute means "tag used with no attributes".

## Inspect and tighten formats
- Click a count to open a dialog (`html_tag_usage.report.inspect`, CSRF-protected)
  listing the entities that use that tag/attribute, linked to their edit forms.
- The report also emits a suggested **HTML filter configuration** string per text
  format (all tags/attributes currently used), as a starting point for a "Limit
  allowed HTML tags" filter. The module explicitly warns this generated config may
  be insecure and must be reviewed before use.

## Permissions
- `view html tag usage report` — read the report and inspection dialogs.
- `generate html tag usage report` — (re)generate the report.
- `administer html tag usage` — change which field types are scanned.
