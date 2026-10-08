<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Better File, Better Image & Better Media widgets

Tile-based replacements for core's file/image/media upload widgets. Picked files show as
draggable thumbnail tiles; a round "+" opens an upload dropzone (chunked, per-file progress) or,
for file/image, a File Browser of existing files. All require JavaScript.

## The widgets

- **`better_file`** — `BetterFileWidget` (`src/Plugin/Field/FieldWidget/BetterFileWidget.php`),
  file fields.
- **`better_image`** — `BetterImageWidget` (`BetterImageWidget.php`), image fields.
- **`better_media`** — `BetterMediaWidget` (`BetterMediaWidget.php`), media-reference fields.

## Settings (schema `field.widget.settings.better_file` / `.better_image` / `.better_media`)

- File/Image: `add_mode` (`upload` | `browser`), `own_files_only` (off), `preview_image_style`
  (image only, `thumbnail`), `show_tooltips`/`show_tag_tooltips` (on), `confirm_remove` (off),
  `show_clear_all`/`enable_undo` (on), `undo_timeout` (10).
- Media adds: `preview_image_style`, `show_search`/`show_sort`/`show_filter`/`glossary`/
  `group_by_type` (on), `show_edit_links` (on), `draggable` (on), `items_limit` (24, page size).

## Chunked upload (`ChunkUploadTrait`, `src/Traits/ChunkUploadTrait.php`)

The JS chunk-uploads to **`better_entity_reference.upload`** (`UploadController`, file/image) or
**`better_entity_reference.media_upload`** (`MediaUploadController`, media). The flow, per
controller `receive()` → `finalize()`:

1. `SignedRequests::validate()` — session CSRF token + field-bound HMAC (see
   `config/endpoints-and-settings.md`).
2. Load a **stub** field item (`SignedRequests::fieldStub`) to read the field's real upload
   validators, extensions, destination scheme/dir, size limit. Image fields add
   `FileIsImage`/`FileImageDimensions` and narrow extensions to the toolkit's supported set
   (`withImageValidators()`).
3. File name is `sanitizeName()`'d then run through core's
   `FileUploadSanitizeNameEvent` (`secureName()`) keyed to the field's extensions, so
   double-extension tricks (`x.php.txt`) are munged.
4. Chunks staged per upload under a **server-derived owner key** (uid + session hash, so two
   anonymous users can't collide) in the staging dir on the field's scheme; guarded against
   oversize totals and too-many-chunks (inode-exhaustion).
5. The reassembled file is validated **in the staging dir** before it is moved, so a rejected file
   never appears at a public URL. On success a temporary managed `File` is created (media: a
   permanent `File` + a `media` entity of the resolved type); the field save makes it permanent.

Media type is chosen from an explicitly requested (allowed + creatable + extension-matching) type,
else detected from the extension (image sources win) — `resolveType()`. `createAccess` on the
media type is enforced. Remote/oEmbed video posts to **`better_entity_reference.media_remote`**
(`MediaUploadController::remote`): each allowed oEmbed-source media type validates the pasted URL
through its own source constraint (provider allowlist), so SSRF/provider policy is enforced by
core's media source, not by this module.

## File Browser (`FileBrowseController`, `MediaBrowseController`)

When `add_mode` = `browser`, file/image widgets pick from existing files via
**`better_entity_reference.file_browse`** (`FileBrowseController::browse`): same CSRF+HMAC as
upload, results limited to permanent files on the field's own scheme and allowed extensions, with
search / name-or-created sort / type filter / paging. `own_files_only` is a **signed HMAC claim**
(`['mine']`), so it cannot be flipped client-side; **private schemes always force it on**. The
query runs `accessCheck(FALSE)` (files have no per-entity grants) but every row is then re-checked
with `$file->access('view')` before listing. Media browsing uses
`better_entity_reference.media_browse` / `better_entity_reference.media_form`.

## Operating notes

- No admin config — everything is per-field on Manage form display.
- Staging dir name is a settings.php value, swept by cron. See
  [config/endpoints-and-settings.md](../config/endpoints-and-settings.md).
- Extend the upload file-type categories/colors with
  `hook_better_entity_reference_file_types_alter()`; the per-file detail fields (alt/title/
  description) with `hook_better_entity_reference_upload_details_alter()` — both in
  `better_entity_reference.api.php`.
