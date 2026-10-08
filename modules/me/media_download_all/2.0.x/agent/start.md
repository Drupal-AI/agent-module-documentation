<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Download All (media_download_all) — agent index

Four "(MDA)" **entity-reference field formatters** that render like their core counterparts but
append a **"Download All Files"** link. The link hits one controller route that ZIPs every file
behind the referenced **media** items (batch-built, cached, streamed from `private://`). Package
`Media`. Depends only on core **`media`**. Core `^10 || ^11`. License GPL-2.0-or-later. Version
`2.0.0-alpha6`.

- **Formatters — the four plugins, what they extend, how to enable, the appended link** →
  [fields/formatters.md](fields/formatters.md)
- **Download route, batch/ZIP build, caching, private temp files, Aliyun OSS path** →
  [api/download.md](api/download.md)

## What it actually is (from source)

- **No new plugin types, no permissions, no Drush, no config form.** `provides_config_schema` is
  true only for the four formatters' settings schemas (`config/schema/media_download_all.schema.yml`).
- **Four field formatters** (`src/Plugin/Field/FieldFormatter/`), all `field_types = {"entity_reference"}`,
  each extending the matching core formatter and mixing in `Traits\MdaFormatterTrait`:
  - `MediaDownloadAllThumbnailFormatter` (id `media_download_all_thumbnail`, "Thumbnail (MDA)") — extends core `MediaThumbnailFormatter`.
  - `MediaDownloadAllEntityFormatter` (id `media_download_all_entity_view`, "Rendered entity (MDA)") — extends `EntityReferenceEntityFormatter`.
  - `MediaDownloadAllLabelFormatter` (id `media_download_all_label`, "Label (MDA)") — extends `EntityReferenceLabelFormatter`.
  - `MediaDownloadAllIdFormatter` (id `media_download_all_entity_id`, "Entity ID (MDA)") — extends `EntityReferenceIdFormatter`.
- **One route** `media_download_all.download_path`:
  `/media_download_all/{entity_type}/{entity_id}/{field_name}` →
  `Controller\DownloadController::download`, access via `DownloadController::access`
  (custom access callback).
- **One archiver plugin** `Plugin\Archiver\Zip` (`@Archiver` id `media_download_all_files_zip_archiver`),
  extends core `Drupal\Core\Archiver\Zip`; adds files by **file id** and supports Aliyun OSS URIs.
- **One tagged service** `media_download_all.cache_tags_invalidator`
  (`Cache\MdaCacheTagsInvalidator`, `cache_tags_invalidator` priority 100) — deletes the cached
  ZIP + cache entry when the source entity's cache tag is invalidated.
- **Two procedural batch callbacks** in `media_download_all.module`:
  `media_download_all_operation` (adds one file to the ZIP) and
  `media_download_all_operation_finished` (caches the path, prints a "click here to download" link).

## Mechanism in one paragraph

`MdaFormatterTrait::appendMdaLink()` appends a `Link` to
`/media_download_all/{entity_type}/{entity_id}/{field_name}` after the core-rendered field.
`download()` checks a permanent cache entry `media_download_all:{entity_type}:{entity_id}` for a
prior ZIP at `[field_name]`; if present and the file exists it is streamed via `BinaryFileResponse`.
Otherwise `getFiles()` loads the entity, reads `{field_name}`'s `target_id`s, loads those **media**
entities, and collects the file ids of every non-`thumbnail` file-reference field on each media
bundle. A `BatchBuilder` adds each file to the ZIP (one op per file), then
`media_download_all_operation_finished` writes the path into cache (tags
`['media_download_all', "{entity_type}:{entity_id}"]`) and shows the download link.

## Notes

- Temp ZIPs live in `private://media_download_all/` named `{entity_type}-{entity_id}-{field_name}.zip`.
- README warns to use the **private** file system (public would expose temp ZIPs).
- `MdaFormatterTrait` uses `Url::fromUserInput(...)` to build the link (a fixed internal path, not
  request data). Formatters are display-only; the download itself is the route above.
