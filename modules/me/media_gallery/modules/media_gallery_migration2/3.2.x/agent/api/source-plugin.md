<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `d7_media_gallery_file` source plugin

`Drupal\media_gallery_migration2\Plugin\migrate\source\MediaGalleryFile`, annotated
`@MigrateSource(id = "d7_media_gallery_file", source_module = "file")`, extends
`DrupalSqlBase`. Both `d7_media_gallery_files` and `d7_media_gallery_media` use it.

## What it does

- `query()` — selects all rows from the D7 **`file_managed`** table, excludes `temporary://`
  uris, orders by `timestamp`, and (if `scheme` is configured) filters uris by scheme.
- `getIds()` — id is `fid` (integer).
- `fields()` — `fid`, `uid`, `filename`, `filepath`, `filemime`, `status`, `timestamp`.
- `prepareRow(Row $row)` — the gallery-specific logic:
  - Looks the file's `fid` up in the **Media 7.x-2.x** table **`field_data_media_gallery_file`**
    (column **`media_gallery_file_fid`**). **If the file is not part of any gallery, the row is
    skipped** (`return FALSE`).
  - Reads alt text from `field_data_media_title` (`media_title_value`), defaulting to
    `"media image"`.
  - Computes a `filepath` relative to the source root and strips `source_base_path`.

## The 7.x-2.x vs 7.x-1.x difference

This is the **only** meaningful code difference between the two migration submodules. This
(7.x-2.x) plugin joins `field_data_media_gallery_file` / `media_gallery_file_fid`. The
`media_gallery_migration` (7.x-1.x) copy joins `field_data_media_gallery_media` /
`media_gallery_media_fid`, and its `d7_media_gallery_entity` reads the `images` sub-process from
source `media_gallery_media` rather than `media_gallery_file`. Choose the submodule that matches
the Media module version your D7 site ran.

## Reuse / override

The class is a standard `DrupalSqlBase`; subclass it or point another migration's `source.plugin`
at `d7_media_gallery_file` (with a `scheme` and a `constants.source_base_path`) to reuse the
gallery-membership filtering.
