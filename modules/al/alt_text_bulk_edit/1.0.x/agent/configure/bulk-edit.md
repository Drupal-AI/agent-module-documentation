<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bulk edit media alt text

All routes are gated by the core permission `update any media`.

## Routes
| Route | Path | Purpose |
|-------|------|---------|
| `alt_text_bulk_edit.configuration` | `/admin/content/media/alt-text` | `BulkUpdateForm` — table of image media with editable alt text |
| `alt_text_bulk_edit.export` | `/admin/content/media/alt-text/export` | `ExportForm` — download current alt text as CSV |
| `alt_text_bulk_edit.import` | `/admin/content/media/alt-text/import` | `ImportForm` — upload a CSV of new alt text |
| `alt_text_bulk_edit.confirm` | `/admin/content/media/alt-text/confirm` | `ConfirmForm` — review before applying |
| `alt_text_bulk_edit.preview/{fid}` | `/admin/content/media/alt-text/preview/{fid}` | `ImagePreview::content` — thumbnail preview (param `entity:file`) |

## How updates apply
Edits are applied through the Batch API: `AltTextUpdate::update()` loads each `Media`, reads its source field configuration (`getSource()->getConfiguration()['source_field']`), writes `$image[0]['alt']`, and saves — tallying updated/failed counts, reported by `finishedCallback()`.

## CSV round-trip
1. **Export** the current alt text to CSV.
2. Edit the alt column in a spreadsheet.
3. **Import** the CSV, **Confirm** the diff, then the batch applies the changes.

## Notes
- Operates on the media source image field, so it respects each media type's configured source field.
- Guard the CSV import to trusted editors — `update any media` grants write to every media entity; the module correctly requires it on all five routes.
