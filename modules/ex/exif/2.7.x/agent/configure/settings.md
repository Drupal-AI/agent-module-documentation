# Configuring Exif

Settings form: `\Drupal\exif\Form\ExifSettingsForm` at `/admin/config/media/exif` (route `exif.config`,
permission `administer image metadata`). Config object: `exif.settings`.

## Settings keys (`exif.settings`)

| Key | Default | Meaning |
|---|---|---|
| `extraction_solution` | `php_extensions` | Backend: `php_extensions` (PHP `exif`/`iptcparse`) or `simple_exiftool` (external `exiftool`). |
| `exiftool_location` | `exiftool` | Path/command for the `exiftool` binary (only used when backend is `simple_exiftool`). |
| `nodetypes` | `[]` | Node bundles to scan for metadata fields. |
| `mediatypes` | `[]` | Media bundles to scan. |
| `filetypes` | `[]` | File bundles to scan. |
| `vocabulary` | `"0"` | Vocabulary used when metadata is written to taxonomy-term fields. |
| `date_format_exif` | `Y-m-d\TH:i:s` | PHP date pattern used to parse EXIF date strings. |
| `granularity` | `0` | Date granularity. |
| `update_metadata` | `false` | If false, fields are only filled on insert; if true, re-read on every save. |
| `write_empty_values` | `false` | Whether empty metadata overwrites existing field values. |

A bundle is only processed if its type is listed in `nodetypes`/`mediatypes`/`filetypes` (see
`ExifContent::getBundleForExifData`). The `photos_image` bundle is auto-included when the `photos`
module is present.

## Drush / config set

```bash
ddev drush cget exif.settings
ddev drush cset exif.settings extraction_solution simple_exiftool -y
ddev drush cset exif.settings nodetypes.0 photography -y
```

## Backend selection

`ExifFactory::getExifInterface()` returns `SimpleExifToolFacade` only when `extraction_solution` is
`simple_exiftool` AND `SimpleExifToolFacade::checkConfiguration()` passes; otherwise it falls back to
`ExifPHPExtension`. exiftool exposes many more tags (including GPS) than the PHP extension.

## Helper & sample pages (same permission)

- `exif.helper` — `/admin/config/media/exif/helper`: quick-start guide; sub-routes scaffold a
  "photography" vocabulary (`.../helper/vocabulary`), node type (`.../helper/nodetype`), or media type
  (`.../helper/mediatype`).
- `exif.sample` — `/admin/config/media/exif/sample`: renders every tag read from the bundled
  `sample.jpg` (replace that file to inspect your own image's tags).

Only JPEG is supported. With GD, some tags (GPS latitude/longitude) get stripped on derivative
generation — use ImageMagick as the image toolkit when GPS data matters.
