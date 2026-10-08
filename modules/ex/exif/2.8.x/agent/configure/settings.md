<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Exif

Settings form: `\Drupal\exif\Form\ExifSettingsForm` (`getFormId` = `exif_settings`) at
`/admin/config/media/exif` (route `exif.config`, permission `administer image metadata`). Config
object: `exif.settings` (schema `config/schema/exif.schema.yml`, defaults
`config/install/exif.settings.yml`).

![Exif settings form](../../../../../../../screenshots/exif/2.8.x/settings-form.png)

## Settings keys (`exif.settings`)

| Key | Default | Meaning |
|---|---|---|
| `extraction_solution` | `php_extensions` | Backend: `php_extensions` (PHP `exif`/`iptcparse`) or `simple_exiftool` (external `exiftool`). Options come from `ExifFactory::getExtractionSolutions()`. |
| `exiftool_location` | `exiftool` | Path/command for the `exiftool` binary (shown only when backend is `simple_exiftool`, via `#states`). |
| `nodetypes` | `[]` | Node bundles to scan for metadata fields. |
| `mediatypes` | `[]` | Media bundles to scan. |
| `filetypes` | `[]` | File bundles to scan (no UI checkbox; set via config/Drush). |
| `vocabulary` | `"0"` | Default vocabulary used when metadata is written to taxonomy-term fields. |
| `save_alt` | `''` | Metadata tag (`group:tag`) copied into an image's `alt` text on upload (core media uploader). |
| `date_format_exif` | `Y-m-d\TH:i:s` | PHP date pattern used to parse EXIF date strings. |
| `granularity` | `0` | Date granularity (`0` = default/full, `1` = Day). |
| `update_metadata` | `false` | If false, fields are only filled on insert; if true, re-read on every save. |
| `write_empty_values` | `false` | Whether empty metadata overwrites existing field values. |

A bundle is only processed if its type is listed in `nodetypes`/`mediatypes`/`filetypes` (see
`ExifContent::getBundleForExifData()`). The `photos_image` bundle is auto-included when the `photos`
module is present.

The form is organised as vertical tabs: **Global Settings** (granularity, refresh-on-update,
extraction method, exiftool location, write-empty, default vocabulary), **Media types** (checkboxes
+ `save_alt`), and **Content types** (checkboxes). Validation (`validateForm`) requires the
`exiftool_location` to be an executable path when the exiftool backend is selected.

## Drush / config set

```bash
ddev drush cget exif.settings
ddev drush cset exif.settings extraction_solution simple_exiftool -y
ddev drush cset exif.settings nodetypes.0 photography -y
```

## Backend selection

`ExifFactory::getExifInterface()` returns `SimpleExifToolFacade` only when `extraction_solution` is
`simple_exiftool` AND `SimpleExifToolFacade::checkConfiguration()` passes (binary present and
executable); otherwise it falls back to `ExifPHPExtension`. The PHP backend reads only JPEG
(`readExifTags` allows `jpg`/`jpeg`); exiftool exposes many more tags (including GPS) across more
formats. `hook_requirements` (`exif.install`) warns if `exif_read_data`, `iptcparse`,
`GetImageSize`, or `mb_convert_encoding` are unavailable.

## Helper & sample pages (same permission)

Handled by `\Drupal\exif\Controller\ExifSettingsController`:

- `exif.helper` — `/admin/config/media/exif/helper`: quick-start guide (`showGuide()`, theme
  `exif_helper_page`). Sub-routes scaffold config, then redirect back to the helper:
  - `exif.helper.vocabulary` (`/helper/vocabulary`) → `createPhotographyVocabulary()` creates the
    `photographs_metadata` vocabulary.
  - `exif.helper.nodetype` (`/helper/nodetype`) → `createPhotographyNodeType()` creates a
    `photography` node type with a `field_image` and ~20 `exif_readonly` metadata fields.
  - `exif.helper.mediatype` (`/helper/mediatype`) → `createPhotographyMediaType()` creates a
    `photography` media type (image source) with the same field set.
- `exif.sample` — `/admin/config/media/exif/sample`: `showSample()` renders every tag read from the
  bundled `sample.jpg` (theme `exif_sample`).

![Exif quick-start helper page](../../../../../../../screenshots/exif/2.8.x/helper-page.png)

All four helper routes and the sample/settings routes require `administer image metadata`.
