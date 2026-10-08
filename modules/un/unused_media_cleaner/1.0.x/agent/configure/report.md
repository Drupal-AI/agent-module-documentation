<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Operate Unused Media Cleaner

## Permissions (all `restrict: TRUE`)
- `access unused media cleaner` — view/generate the report form.
- `export unused media report` — download the CSV.
- `delete unused media` — batch-delete unused items.

## Generate a report
Go to **Configuration → Media → Unused Media Cleaner** (`/admin/config/media/cleaner/report`). Pick a **Size threshold** (1–10 Mo) and **Generate Report**. A Batch scans all media (`accessCheck(TRUE)`), keeps items whose `field_media_image`/`field_media_file` exceeds the threshold, and marks an item "Not used" when no `entity_reference`→media field on any content entity references it. Results are stored in `state` key `unused_media_cleaner.report_data` (+ `..._timestamp`).

## Export
"Export to CSV" (`unused_media_cleaner.export_csv`) streams the stored report (name, id, size, usage) as a download; filename is `<site>_heavy_media_usage_<datetime>.csv`.

## Delete
"Delete Unused Media (N)" links to `unused_media_cleaner.delete_unused`, which batch-deletes every "Not used" item (25 per op), deletes the referenced file entity, then clears the stored report. Irreversible.

## Caveats
- Deletion works off the *stored* report; regenerate before deleting so it reflects current usage.
- Only grant `delete unused media` to trusted admins.
