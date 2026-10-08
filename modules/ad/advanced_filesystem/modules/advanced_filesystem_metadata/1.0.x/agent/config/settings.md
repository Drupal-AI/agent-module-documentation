<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Metadata — settings, groups, re-extraction

## Install / enable

```bash
drush pm:install advanced_filesystem_metadata
drush cr
```

Depends on the parent `advanced_filesystem` plus core `file`, `field`, `user`, `media`. EXIF needs
the PHP `exif` extension; image info uses `gd`. Audio/video groups need `ffprobe`/`ffmpeg` on PATH.

## Config object `advanced_filesystem_metadata.settings`

Form `MetadataSettingsForm` at `/admin/config/media/advanced_filesystem/metadata`
(route `.settings`, `_permission: administer advanced_filesystem_metadata`). Schema:
`config/schema/…schema.yml`; defaults: `config/install/…settings.yml`.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `extract_on_upload` | bool | `true` | Auto-extract on file insert/update. |
| `overwrite_on_reextract` | bool | `true` | Re-extract overwrites existing values. |
| `async_extraction` | bool | `false` | Push extraction to the `metadata_extraction` queue instead of running inline. |
| `enabled_groups` | sequence(string) | `[]` | Metadata groups to extract & install fields for. |

Enabling/disabling a group triggers `MetadataFieldManager` to install or remove the corresponding
`adfs_*` base fields on the File entity.

## Metadata groups (`MetadataDefinitions::getGroups()`)

`exif_camera`, `exif_image`, `exif_exposure`, `exif_lens`, `exif_gps`, `exif_datetime`,
`exif_copyright`, `iptc`, `xmp`, `image_info`, `pdf`, `audio`, `video`, `video_captions`.
`getFields()` maps each `adfs_*` field to its `label`, `group` and `type` (string/integer/…).

## Auto-extraction flow

`hook_file_insert` and `hook_file_update` call `_advanced_filesystem_metadata_auto_extract($file)`
(in the `.module`): returns early unless the file is permanent, `extract_on_upload` is true and
`enabled_groups` is non-empty. When `async_extraction` is on it enqueues
`['fid'=>…, 'overwrite'=>FALSE]` on the `metadata_extraction` queue; otherwise it calls
`MetadataExtractor::extractAndSave($file, FALSE)`. `hook_file_update` only fires the extraction when
a file transitions temporary → permanent.

## Re-extraction

- **Per file (UI)** — `hook_entity_operation` adds "Re-extract Metadata" to the file listing; route
  `.file_reextract` → `FileViewController::reextract()` (CSRF-protected) calls
  `extractAndSave($file, overwrite_on_reextract)`.
- **Bulk (UI)** — `MetadataReextractForm` (route `.reextract`) drives `MetadataBatch`.
- **Detail page** — `FileViewController::view()` (route `.file_view`) shows all values grouped, with
  per-group and overall fill-score badges, plus a re-extract button.
- **Drush** — `metadata:extract` (extract now), `metadata:status`, `metadata:missing`.
