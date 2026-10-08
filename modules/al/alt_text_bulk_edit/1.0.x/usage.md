<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Alt text bulk edit lets editors review and update the alternative text of many image media entities at once, including via CSV export/import.

---
Fixing missing or poor image alt text one media entity at a time is slow, yet good alt text is essential for accessibility and SEO. This module gathers image media into a single editable table and applies changes in bulk.

At `/admin/content/media/alt-text` (`BulkUpdateForm`) it lists image media with editable alt-text fields and a per-item thumbnail preview (`ImagePreview::content`, `{fid}` as an `entity:file`). Alongside the in-page table it offers a CSV round-trip: `ExportForm` downloads current alt text, and `ImportForm` uploads a revised CSV that a `ConfirmForm` shows for review before applying. Changes run through the Batch API — `AltTextUpdate::update()` loads each `Media`, resolves its source image field from `getSource()->getConfiguration()['source_field']`, sets `alt` on the first value and saves, tracking updated/failed counts. All five routes require the core `update any media` permission.

Setup: enable the module (needs core `field` and `media`), grant `update any media` to trusted editors, then edit inline or export → edit → import → confirm.
---
- Edit alt text for many image media at once
- Fix missing alt text across a media library
- Improve accessibility (WCAG) coverage of images in bulk
- Improve image SEO with consistent alt text
- Review images with inline thumbnail previews while editing
- Export all current alt text to a CSV file
- Edit alt text in a spreadsheet then re-import
- Import updated alt text from a CSV
- Confirm a diff of changes before applying
- Apply large alt-text updates via the Batch API
- See counts of updated and failed items after a run
- Respect each media type's configured source image field
- Audit which images lack alt text
- Standardize alt-text wording across a site
- Restrict bulk editing to holders of `update any media`
- Preview a specific file by id before editing its alt text
- Batch-process large media libraries without timeouts
- Hand off alt-text authoring to a spreadsheet workflow
- Re-run imports iteratively to refine alt text
- Reduce manual per-entity media editing
