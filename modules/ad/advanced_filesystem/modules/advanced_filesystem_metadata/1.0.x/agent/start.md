<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Metadata (advanced_filesystem_metadata) — agent index

Sub-module of **Advanced Filesystem**. Extracts EXIF/IPTC/XMP/PDF/audio/video metadata from
uploaded files and stores each value in a native `adfs_*` field on the **File** entity (Views-ready).
Depends on core `file`, `field`, `user`, `media`, `advanced_filesystem`. Package `Advanced Filesystem`.
Core `^10 || ^11 || ^12`. License GPL-2.0-or-later. Version 1.0.27 (dir 1.0.x).

- **Settings, groups, fields, auto-extract, re-extract, Drush** → [config/settings.md](config/settings.md)
- **Extractor, field manager, media source, Views fields, queue** → [api/extraction.md](api/extraction.md)

## What it provides

- **Services**: `advanced_filesystem_metadata.extractor` (`MetadataExtractor`) and
  `advanced_filesystem_metadata.field_manager` (`MetadataFieldManager`).
- **Static catalogue** `MetadataDefinitions` — `getGroups()` (exif_camera, exif_image,
  exif_exposure, exif_lens, exif_gps, exif_datetime, exif_copyright, iptc, xmp, image_info, pdf,
  audio, video, video_captions) and `getFields()` (every `adfs_*` field → label/group/type).
- **QueueWorker** `metadata_extraction` (`Plugin/QueueWorker/MetadataExtractionWorker`, `cron={"time"=30}`).
- **Media source** `MetadataSource` (`Plugin/media/Source/MetadataSource`, label "File (ADFS Metadata)",
  extends core `File`).
- **Views fields**: `adfs_gps_map_link` (`GpsMapLinkField`), `adfs_thumbnail` (`ThumbnailField`),
  `adfs_metadata_score` (`MetadataScoreField`), wired via `hook_views_data_alter` on `file_managed`.
- **Config object** `advanced_filesystem_metadata.settings` (extract_on_upload,
  overwrite_on_reextract, async_extraction, enabled_groups[]).
- **Drush** (`MetadataCommands`): `metadata:extract`, `metadata:status`, `metadata:missing`.

## Routes / permissions

Single permission `administer advanced_filesystem_metadata` (`restrict access: true`).

- `.file_view` — `FileViewController::view` at `/admin/content/files/{file}` (grouped detail page).
- `.file_reextract` — `FileViewController::reextract` at `…/{file}/reextract` — **`_csrf_token: 'TRUE'`**.
- `.settings` — `MetadataSettingsForm` at `/admin/config/media/advanced_filesystem/metadata`.
- `.reextract` — `MetadataReextractForm` (bulk) at `…/metadata/reextract`.

## Mechanism (from source)

- `hook_file_insert` / `hook_file_update` → `_advanced_filesystem_metadata_auto_extract()`: only for
  permanent files, only when `extract_on_upload` and `enabled_groups` are set. If `async_extraction`,
  pushes to the `metadata_extraction` queue; else calls `MetadataExtractor::extractAndSave()`.
- `MetadataExtractor::extract()` reads the file (EXIF via ext-exif, XMP via a 2 MB head read + DOM,
  PDF via a bounded tail/head regex read, audio/video via `ffprobe`/`ffmpeg`), `applyToEntity()`
  writes fields, `extractAndSave()` wraps both with a recursion guard.
- `MetadataFieldManager` installs/removes the base fields for the enabled groups.
- `hook_entity_operation` adds "View Metadata" / "Re-extract Metadata" ops to file listings.

## Notes / caveats

- Video/audio extraction shells out to `ffprobe`/`ffmpeg`; the file path is passed through
  `escapeshellarg()` and the subtitle stream index is an `(int)` cast — no shell interpolation of
  raw values. Skips silently if the binaries are absent.
- The detail page renders extracted values in `#type table` cells (`['data' => (string)$value]`),
  which the table theme auto-escapes; file URIs/URLs in `#markup` are `htmlspecialchars`-escaped.
- GPS Views field builds an OSM/Google Maps link from `adfs_exif_gps_lat/lon` cast to `float`
  (no server-side fetch).
