<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# file_resup upload protocol & assembly

All chunk traffic goes to route **`file_resup.upload`** → path `file-resup/upload`
(`UploadController::build`), requirement `_permission: 'access content'`. The client
(`js/resup.js`) drives it; you rarely call it by hand, but this is the contract.

## Request identifiers

- `resup_file_id` — client token, must match `^[1-9]\d*-\d+-[\w%]+$`. Server derives the
  storage `upload_id` via `FileFormAlterBase::uploadIdFromFileId()`: it is prefixed with the
  current **user id**, or (for anonymous) the client IP with `.`→`_`, then transliterated to
  ASCII and truncated to 240 chars. So each user/IP gets its own namespace of upload ids —
  one user cannot address another user's in-progress upload by guessing the id.
- `form_type` (`file_widget` or `media_library`), plus `entity_type_id`, `operation`,
  `bundle`, `form_parents` — used on GET to rebuild the target form and read its validators.
- `resup_file_name`, `resup_file_size` — declared name/size (GET, for validation).
- `resup_chunk_number` (1-based), `resup_chunk` (the file part, POST body).

## GET — initialise / report progress

1. If a `file_resup` record already exists for the `upload_id`, returns the count of
   `uploaded_chunks` (plain text) so the client resumes from there.
2. Otherwise it dispatches `BuildFormEvent` (an event subscriber rebuilds the target entity
   form) to obtain the widget element, then validates against **that field's** settings:
   filename length ≤ 240; extension against `#upload_validators` FileExtension list; size is a
   positive int ≤ the field's `FileSizeLimit`; `#upload_location` scheme is a valid stream
   wrapper. Spaces (incl. NNBSP/NBSP) in the name are collapsed to `_`.
3. Prepares `<scheme>://file_resup_temporary/`, writes an `.htaccess` deny (`file.htaccess_writer`),
   inserts the `file_resup` tracking entity, deletes any stale temp file, returns `0`.

## POST — append a chunk

- Rejects a missing/oversized part (`> file_resup_chunksize()`), a non-`is_uploaded_file`, a
  bad `resup_chunk_number` format, or a chunk number past `ceil(filesize / chunksize)`.
- If the chunk number isn't exactly `uploaded_chunks + 1`, returns the current count (client
  re-syncs) — chunks must arrive in order.
- Opens `<scheme>://file_resup_temporary/<upload_id>` `ab`, takes an **exclusive `flock`**,
  bumps `uploaded_chunks` inside a DB transaction, appends the bytes, returns the new count.

## Assembly into a real `file` entity

Assembly happens **only when the actual entity form is submitted** — not from the upload
route. `FileFormAlterBase::saveUpload()` (`fileValue` / `fileResupValue` value callbacks):

1. Re-derives `upload_id`, loads the `file_resup` record, checks `uploaded_chunks` equals the
   expected total and the temp file exists; verifies the destination scheme still matches.
2. Creates a `File` entity (uid = current user, mime guessed), dispatches
   `FileUploadSanitizeNameEvent` to munge the name against the field's extension list.
3. **Executable rename** — unless `system.file:allow_insecure_uploads` is set, a name matching
   `/\.(php|pl|py|cgi|asp|js)(\.|$)/i` (and not ending `.txt`) is forced to `text/plain` and
   gets `.txt` appended (mirrors core's protection).
4. Runs `file.validator` with the field's `#upload_validators` (a default extension list
   `jpg jpeg gif png txt doc xls pdf ppt pps odt ods odp` is applied if the field declares none);
   on violation it sets a form error and aborts.
5. `prepareDirectory` on the field's real `#upload_location`, `getDestinationFilename(... EXISTS_RENAME)`,
   `rename()` the temp file into place, `chmod`, `File::save()`.
6. If `prevent_duplicates` is on, stores `fid` on the tracking record; otherwise deletes it.

## Notes for callers

- The internal `file_resup` entity is `internal = TRUE`, keyed by `upload_id`; `filesize` is a
  `big` int (see `file_resup_update_91001`).
- There is no server-side garbage collection of abandoned temp files / records in this version
  — orphaned `file_resup_temporary` files persist until finalised or manually cleared.
