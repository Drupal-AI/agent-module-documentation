<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media source plugin & media types

## The plugin type

Acquia DAM defines its own **`AssetMediaSource`** plugin type (a sub-plugin of the core media
source). Manager: `plugin.manager.acquia_dam.asset_media_source`
(`Drupal\acquia_dam\Plugin\media\acquia_dam\AssetMediaSourceManager`):

- Discovery dir: `Plugin/media/acquia_dam`
- Interface: `MediaSourceTypeInterface`
- Annotation: `Drupal\acquia_dam\Annotation\AssetMediaSource`
- Alter hook: `hook_acquia_dam_media_source_alter()`; cache bin `acquia_dam_media_source_plugins`.

Each derivative maps a DAM asset kind to a Drupal media type. Built-in derivatives (in
`Plugin/media/acquia_dam/`): `Image`, `Video`, `Audio`, `Pdf`, `Documents`, `Archive`,
`SpinSet`, `Generic` (base class `MediaSourceTypeBase`). The core media Source plugin that
Drupal sees is `acquia_dam_asset` (with `AssetDeriver` producing `acquia_dam_asset:<type>`).

To add support for a new asset kind, add a class in that namespace with the `AssetMediaSource`
annotation implementing `MediaSourceTypeInterface`; a matching `media.type.*` config entity
then wires it up.

## The 8 installed media types

Config in `config/install/media.type.acquia_dam_*.yml`. Each uses source
`acquia_dam_asset:<type>` with source field **`acquia_dam_asset_id`**:

| Media type id | Source plugin | Asset kind |
|---|---|---|
| `acquia_dam_image_asset` | `acquia_dam_asset:image` | still image |
| `acquia_dam_video_asset` | `acquia_dam_asset:video` | video |
| `acquia_dam_audio_asset` | `acquia_dam_asset:audio` | audio |
| `acquia_dam_pdf_asset` | `acquia_dam_asset:pdf` | PDF |
| `acquia_dam_documents_asset` | `acquia_dam_asset:documents` | office/documents |
| `acquia_dam_archive_asset` | `acquia_dam_asset:archive` | archive (zip etc.) |
| `acquia_dam_spinset_asset` | `acquia_dam_asset:spinset` | 360° spin set |
| `acquia_dam_generic_asset` | `acquia_dam_asset:generic` | anything else |

Example (`media.type.acquia_dam_image_asset.yml`):

```yaml
id: acquia_dam_image_asset
source: 'acquia_dam_asset:image'
source_configuration:
  source_field: acquia_dam_asset_id
  download_assets: false
  preserve_filename_case: false
  uri_scheme: public
field_map:
  filename: name
```

## Source configuration (per media type)

Schema `media.source.acquia_dam_asset:*` (field-aware):

| Key | Type | Meaning |
|---|---|---|
| `download_assets` | bool | download + sync the file locally (else reference remotely) |
| `preserve_filename_case` | bool | keep the original filename case on download |
| `uri_scheme` | string | upload destination scheme (`public`, `private`, or the module's `acquia-dam://` wrapper) |
| `file_extensions` | string | allowed file extensions |

Read/toggle per type:

```bash
drush cget media.type.acquia_dam_image_asset source_configuration
# enable local download+sync for images:
drush php:eval '$t=\Drupal::entityTypeManager()->getStorage("media_type")->load("acquia_dam_image_asset");
$c=$t->get("source_configuration"); $c["download_assets"]=TRUE; $t->set("source_configuration",$c)->save();'
```

Related services: `acquia_dam.media_type_resolver` (maps an asset to its media type),
`acquia_dam.asset_repository`, `acquia_dam.asset_updater`. There is a stream wrapper
`stream_wrapper.acquia_dam` (`acquia-dam://`).
