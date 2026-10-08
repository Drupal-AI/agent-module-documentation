<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Unused Media Cleaner is an admin tool that reports large media, shows where each item is used, exports the report to CSV, and batch-deletes media that is unused anywhere.

---

The report form (`/admin/config/media/cleaner/report`) runs a Batch over all media entities (`accessCheck(TRUE)`), keeps those whose image/file field exceeds a chosen size threshold, and marks an item "Not used" when `findMediaUsages()` finds no `entity_reference` field (target_type media) pointing at it across all content entity types. Results are stored in Drupal `state` (`unused_media_cleaner.report_data`) and shown in a table with a WebP-size estimate. A CSV export controller streams the stored report as a download, and a delete controller batch-deletes every item flagged "Not used" (also deleting the referenced file), then clears the stored report. Each of the three routes is gated by its own restricted permission: `access unused media cleaner`, `export unused media report`, `delete unused media`.

Access: deletion is gated by the dedicated `delete unused media` permission (report and usage queries use `accessCheck(TRUE)`). The delete action (`unused_media_cleaner.delete_unused`) is triggered by a link with a JS `confirm()`. Typical use: generate a report at a threshold, review "Not used" rows, optionally export CSV, then delete.

---

- Generate a report of media larger than a chosen size threshold (1–10 Mo).
- See which entities reference each large media item.
- Identify media that is not referenced anywhere ('Not used').
- Read an estimated WebP size for each large file.
- Export the current report to a timestamped CSV download.
- Batch-delete every media item flagged 'Not used'.
- Delete the underlying file entity together with the media.
- Run report generation as a resumable Batch over all media.
- Adjust the size threshold to focus on the heaviest assets.
- Reclaim storage by pruning orphaned uploads.
- Restrict report access to the `access unused media cleaner` role.
- Restrict CSV export to the `export unused media report` role.
- Restrict deletion to the `delete unused media` role.
- Reach the tool from Configuration → Media → Unused Media Cleaner.
- Confirm deletion via the JS confirm prompt before it runs.
- Regenerate the report before deleting to reflect current usage.
- Audit storage growth periodically via repeated reports.
- Feed the CSV into a spreadsheet for offline review.
