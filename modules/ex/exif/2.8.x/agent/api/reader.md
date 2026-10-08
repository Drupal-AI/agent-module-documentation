<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Reading metadata from code

## Services (`exif.services.yml`)

- `exif.metadata.reader_factory` → `\Drupal\exif\ExifFactory`.
- `exif.metadata.reader` → an `\Drupal\exif\ExifInterface`, produced by the factory method
  `ExifFactory::getExifInterface`.
- `\Drupal\exif\Hook\ExifHooks` → autowired hook-implementation service (invoked by the
  `#[LegacyHook]` shims in `exif.module`).

## Get a reader

```php
$exif = \Drupal\exif\ExifFactory::getExifInterface();      // static factory
// or the service:
$exif = \Drupal::service('exif.metadata.reader');
$tags = $exif->readMetadataTags('/path/to/photo.jpg');     // ['exif'=>[...], 'iptc'=>[...], ...]
```

## `ExifInterface` (contract)

Implemented by `ExifPHPExtension` (default) and `SimpleExifToolFacade` (exiftool). Methods:

- `readMetadataTags($file, $enable_sections = TRUE)` — returns metadata keyed by section then tag
  (all lowercased). Returns `[]` if the file is missing/unreadable.
- `getMetadataFields(array $arCckFields = [])` — turns field settings (`metadata_field` string) into
  `['section' => ..., 'tag' => ...]` descriptors; drops fields whose section is unknown.
- `getFieldKeys()` — the flat list of selectable tag names (EXIF + `iptc_*`), used to build widget
  option lists. `SimpleExifToolFacade::getFieldKeys()` returns `[]` (exiftool is open-ended).

`ExifFactory::getExtractionSolutions()` returns the backend options
(`php_extensions`, `simple_exiftool`).

## Backends

- `ExifPHPExtension` (singleton) — uses `@exif_read_data()` (JPEG only) + `getimagesize()` /
  `iptcparse()` for IPTC (`APP13`). `reformat()` normalises GPS to decimals, dates to ISO 8601,
  and maps machine values to human labels (`getHumanReadableDescriptions()`); `getFieldKeys()` lists
  hundreds of `section_tag` keys.
- `SimpleExifToolFacade` (singleton) — shells out to the configured `exiftool` binary via `exec()`
  with `-E -n -json -g -struct -fast2` and `escapeshellarg($file)` / `escapeshellcmd(...)`, then
  `json_decode`s and lowercases keys. `checkConfiguration()` verifies the binary is executable.

## `ExifContent` (entity ↔ file glue)

`\Drupal\exif\ExifContent` maps between Drupal entities and file metadata. Key public methods:

- `entityInsertUpdate($entityType, FieldableEntityInterface $entity, $update = TRUE)` — main entry;
  reads images and writes mapped fields.
- `getDataFromFileUri(UriItem|string $uri)` — read all metadata for a file URI (handles remote
  stream wrappers by making a temp local copy).
- `getMediaMetadata(FieldableEntityInterface $entity)` — all metadata for a media entity's first
  image field.
- `checkTitle(...)`, `handleTaxonomyField(...)`, `handleDateField(...)`, `createTerm(...)`.

## `ExifHelper` (static utilities)

`\Drupal\exif\ExifHelper`: `allMetaData()` / `allMetaDataAsElements()` (tags of the bundled
`sample.jpg`), `sampleImagePath()` / `sampleImageUrl()`, `fieldsForMapping($media_type)`,
`fieldsForImages()` / `fieldsForImagesNames()`, `allFields($media_type)`, `getTermByName()`,
`createTerm()`, `announceFieldPreloaded()`.
