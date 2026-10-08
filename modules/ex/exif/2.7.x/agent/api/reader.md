# Exif reader API

Use these to read image metadata programmatically instead of the widgets.

## Get a reader

```php
use Drupal\exif\ExifFactory;
$exif = ExifFactory::getExifInterface(); // honors exif.settings extraction_solution
```

Or via the container services (`exif.services.yml`):
- `exif.metadata.reader_factory` — the `ExifFactory`.
- `exif.metadata.reader` — a ready `ExifInterface`, produced by the factory's `getExifInterface`.

## `ExifInterface` (implemented by `ExifPHPExtension` and `SimpleExifToolFacade`)

```php
// All tag values from a file, grouped by section. $file = a realpath, not a URI.
$metadata = $exif->readMetadataTags(\Drupal::service('file_system')->realpath($uri));

// All selectable section/tag keys (used to build widget dropdowns).
$keys = $exif->getFieldKeys();

// Given field descriptors, resolve which exif tags to read.
$fields = $exif->getMetadataFields($descriptors);
```

`readMetadataTags()` returns `['<section>' => ['<tag>' => value, ...], ...]`. Stream wrappers that are
not local are copied to a temporary local file first (`ExifContent::getDataFromFileUri`).

## `ExifContent`

`\Drupal\exif\ExifContent` is the glue invoked by the entity hooks. Handy public method:

```php
$content = new \Drupal\exif\ExifContent();
$metadata = $content->getMediaMetadata($mediaEntity); // array of all tags for a media entity's image
```

`entityInsertUpdate($entityType, $entity)` and `checkTitle(...)` are what the module calls on save; you
normally rely on the hooks rather than calling them directly.

Reminder: values from `readMetadataTags()` are file content — escape before rendering as markup.
