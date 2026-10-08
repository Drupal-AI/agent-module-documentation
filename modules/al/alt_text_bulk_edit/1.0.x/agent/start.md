<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alt text bulk edit (alt_text_bulk_edit) — agent index

**Bulk-edits alternative text across image media**, with an editable table, thumbnail previews, and a CSV export/import round-trip applied via Batch API.

- **Version:** 1.0.x
- **Core:** `^10 || ^11 | ^12`  · depends on core `field`, `media`
- **Routes (all `_permission: 'update any media'`):** `.configuration` (`BulkUpdateForm`), `.export` (`ExportForm`), `.import` (`ImportForm`), `.confirm` (`ConfirmForm`), `.preview/{fid}` (`ImagePreview`, param `entity:file`).
- **Update path:** `AltTextUpdate::update()` (Batch API) writes `alt` on each media's configured source field and saves.

**Security:** every route — including CSV import and the batch write — is gated by the core `update any media` permission (a legitimate editor capability); no `_access: TRUE` and no anonymous endpoints. No security findings.

See [configure/bulk-edit.md](configure/bulk-edit.md)
