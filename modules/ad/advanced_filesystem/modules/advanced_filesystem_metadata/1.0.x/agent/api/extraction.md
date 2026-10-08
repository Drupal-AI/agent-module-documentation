<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Metadata — extractor, field manager, media source, Views fields

## MetadataExtractor

Service `advanced_filesystem_metadata.extractor` = `Drupal\advanced_filesystem_metadata\MetadataExtractor`
(`@file_system`, `@logger.channel.advanced_filesystem_metadata`, `@config.factory`).

- `extract(FileInterface $file): array` — dispatches by MIME/type to the readers:
  EXIF via the PHP `exif` extension; **XMP** via `extractXmp()` (reads first 2 MB with
  `file_get_contents(..., 0, 2*1024*1024)`, locates the `<x:xmpmeta>`/`rdf:RDF` packet, parses with
  `DOMDocument` under `libxml_use_internal_errors`); **PDF** via `extractPdf()` (bounded 512 KB tail +
  4 KB head read, regex over the `/Info` dictionary, literal/hex string decode); **audio/video** via
  `extractWithFfprobe()` and `extractEmbeddedCaptions()`.
- `applyToEntity(FileInterface $file, array $data, bool $overwrite): bool` — writes each value into
  its `adfs_*` field (respecting `$overwrite`).
- `extractAndSave(FileInterface $file, bool $overwrite=FALSE): bool` — `extract()` + `applyToEntity()`
  + `save()`, guarded by a static recursion map so the save-triggered `hook_file_update` cannot loop.

### Shell-out safety (audio/video)

`extractWithFfprobe()` and `extractEmbeddedCaptions()` first probe `which ffprobe`/`which ffmpeg`
and return early if absent. The file path is passed as `escapeshellarg($path)`; the subtitle stream
index in `-map 0:s:{$si}` is an `(int)` cast. No unescaped/request-derived value reaches the shell.
All reads are of the local managed file's own path — no remote fetch, no request-supplied path.

## MetadataFieldManager

Service `advanced_filesystem_metadata.field_manager` (`@entity_type.manager`, logger). Installs and
removes the `adfs_*` base field storage definitions on the `file` entity to match the
`enabled_groups` setting (called from the settings form when groups change).

## Queue worker

`Plugin/QueueWorker/MetadataExtractionWorker` (id `metadata_extraction`, `cron={"time"=30}`) reads
`['fid', 'overwrite']`, loads the file and calls `MetadataExtractor::extractAndSave()`. Fed by the
`.module` auto-extract helper when `async_extraction` is on.

## Media source

`Plugin/media/Source/MetadataSource` (label "File (ADFS Metadata)") extends core `File`. Reads the
source field's file entity and exposes its `adfs_*` attribute values (`$file->get($attr)->value`) as
media-source metadata attributes for use on media types.

## Views integration

`hook_views_data_alter` adds three computed fields to `file_managed`:

| Field id | Class | Renders |
|---|---|---|
| `adfs_gps_map_link` | `GpsMapLinkField` | Link to OpenStreetMap/Google Maps from `adfs_exif_gps_lat/lon` cast to float (option: provider, link text, new tab). Returns `''` when no/zero coords. |
| `adfs_thumbnail` | `ThumbnailField` | Inline `<img>` thumbnail for image files. |
| `adfs_metadata_score` | `MetadataScoreField` | Percentage of `adfs_*` fields that have a value. |

The GPS field builds a normal link (`Url::fromUri`) — there is no server-side geolocation lookup or
outbound request; coordinates are numeric-cast before interpolation.

## Detail page rendering

`FileViewController::view()` groups every `adfs_*` field by `MetadataDefinitions` group into
`#type details` + `#type table` sections. Field values are placed in table cells as
`['data' => (string) $value]`, so the table theme auto-escapes them; file URI / thumbnail URL / map
markup emitted as `#markup` are wrapped in `htmlspecialchars(..., ENT_QUOTES)`.
