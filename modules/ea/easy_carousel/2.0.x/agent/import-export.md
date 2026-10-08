<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Export / Import

Two admin forms, both gated by `administer site configuration`.

## Export — `easy_carousel.export_form` (`/admin/easy_carousel/export`)

`ExportForm::exportJson()` loads every `carousel_item` and `carousel`, calls `->toArray()` on each,
JSON-encodes them into `items.json` and `carousels.json`, zips them in the system temp dir, and streams
the ZIP as a download (`easy_carousel_export_<ddmmYYYY_Hi>.zip`), then `unlink()`s the temp file and `exit`s.

## Import — `easy_carousel.import_form` (`/admin/easy_carousel/import`)

`ImportForm` accepts a `managed_file` restricted to `.zip`. `submitProcess()` → `processZipFile()`:

1. `ZipArchive::extractTo(sys_get_temp_dir())` — extracts the uploaded archive.
2. Reads `items.json` and `carousels.json` from the temp dir.
3. **Destructive:** `deletePreviousEntities()` deletes ALL existing `carousel_item` then `carousel` entities.
4. `createNewEntities()` calls `->create($entity)->save()` for each decoded array.

**Operational warnings for agents:**
- Import wipes the entire carousel/slide set first; there is no merge and no undo. Always export a backup first.
- Entity values are created verbatim from the ZIP's JSON (`->create()` on decoded arrays). Only trusted `administer site configuration` users can reach this route; do not import ZIPs from untrusted sources.
- A sample export ZIP ships at `samples/easy_carousel_export_28022025_1503.zip`.
