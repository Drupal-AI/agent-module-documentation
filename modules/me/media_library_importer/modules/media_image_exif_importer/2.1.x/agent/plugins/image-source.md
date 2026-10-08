# `ImageWithExif` media source

Class `Drupal\media_image_exif_importer\Plugin\media\Source\ImageWithExif` extends core
`Drupal\media\Plugin\media\Source\Image`. It is installed by `hook_media_source_info_alter()` overriding the
core `image` source's `class` — so there is no new source plugin id; every Image media type uses this class.

## Per-media-type setting

`buildConfigurationForm()` adds `gather_exif` (select No/Yes, default No). It is `#disabled` when
`function_exists('exif_read_data')` is FALSE. Stored in the media type's source configuration
(`defaultConfiguration()` seeds `gather_exif = 0`). Set it on the Image media type edit form
(*Structure → Media types → Image → Edit*, "Whether to gather exif data").

## Metadata attributes (`getMetadataAttributes()`)

Always adds `width`, `height`. When `gather_exif` is truthy AND `exif_read_data` exists, also adds:

| Attribute | EXIF source | Notes |
|---|---|---|
| `model` | `Model` | camera model string |
| `created` | `DateTimeOriginal` | parsed to a `DrupalDateTime`, formatted to `DATETIME_STORAGE_FORMAT` |
| `iso` | `ISOSpeedRatings` | |
| `exposure` | `ExposureTime` | fraction normalized via `normaliseFraction()` |
| `aperture` | `FNumber` | fraction normalized |
| `focal_length` | `FocalLength` | fraction normalized |

Map these to fields the same way as core metadata mappings on the media type's *Field mapping* section.

## Reading (`getMetadata()`)

- Loads the file from the source field, gets the image via the image factory for width/height/`thumbnail_uri`.
- For EXIF attributes calls `getExifField($uri, $Field)`, which lazily runs
  `exif_read_data(\Drupal::service('file_system')->realpath($uri), 'EXIF')` once per source instance and caches it.
- Falls back to `parent::getMetadata()` for anything it doesn't handle or when the source field is empty.

## Caveat

Enabling the module changes the Image source class **globally**; it does not scope to one bundle. EXIF is only
parsed when the media type has `gather_exif` on and the PHP `exif` extension is present.
