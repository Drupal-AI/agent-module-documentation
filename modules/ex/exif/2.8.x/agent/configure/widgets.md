<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Exif field widgets & tag mapping

Metadata is written to a field by attaching one of three form widgets to that field on a scanned
bundle. All extend `ExifWidgetBase` (`src/Plugin/Field/FieldWidget/ExifWidgetBase.php`); the
value-bearing ones extend `ExifFieldWidgetBase`.

## The three widgets

| Widget id | Class | Field types | Behaviour |
|---|---|---|---|
| `exif_readonly` | `ExifReadonlyWidget` | string, string_long, text, text_with_summary, text_long, entity_reference, date, datetime, datestamp | Value shown read-only in the edit form (`formElement()` calls `$items->view()`; hidden if the viewer lacks field `view` access). |
| `exif_hidden` | `ExifHiddenWidget` | same set as above | Value populated but rendered as hidden inputs (`process()` sets `tid`/`value`/`timezone`/`value2`/`display` to hidden). |
| `exif_html` | `ExifHtmlWidget` | text, text_long | Whole-metadata dump; default settings `exif_field = all_all`, producing an HTML table of every tag. |

## Widget settings (schema `field.widget.settings.exif_*`)

`ExifWidgetBase::defaultSettings()` adds `image_field` (which image/file/media field supplies the
bytes). `ExifFieldWidgetBase::defaultSettings()` adds:

- `exif_field` — the metadata tag to read, e.g. `exif_model`, `ifd0_datetime`, `iptc_keywords`, or
  the sentinel `naming_convention`. Options come from `ExifInterface::getFieldKeys()`.
- `exif_field_separator` — a single character; when set, a string tag value is `explode()`-ed into
  multiple field values (useful for multi-value taxonomy/keyword fields).

`settingsForm()` (in `ExifWidgetBase`) renders the `image_field` radios for node/media/photos_image
bundles (hidden value `file` for file entities) and validates it points to an image/file/media field
(`validateImageField`). `ExifFieldWidgetBase::settingsForm()` adds the `exif_field` select and
separator textfield, with `validateExifField` / `validateExifFieldSeparator`. `settingsSummary()`
describes the chosen image field, tag, and separator.

## Naming convention

When `exif_field` is `naming_convention`, the tag is derived from the field name by stripping the
leading `field_` (see `ExifContent::filterFieldsOnSettings()` → `substr($fieldName, 6)`). So
`field_exif_model` reads `exif:model`, `field_ifd0_datetime` reads `ifd0:datetime`. Tag names are
`<section>_<tag>`; sections recognised by the PHP backend are `exif, file, computed, ifd0, gps,
winxp, iptc, xmp` (`ExifPHPExtension::getMetadataSections()`), plus the special `all` (used by
`exif_html`).

## How values are written (`src/ExifContent.php`)

`entityInsertUpdate()` collects the bundle's exif-mapped fields (`filterFieldsOnSettings` +
`ExifInterface::getMetadataFields`), reads each image's metadata (`getDataFromFileUri` →
`ExifInterface::readMetadataTags`), then per field:

- tag `all` → builds an HTML metadata table stored to the field (format `full_html`).
- text/string fields → `handleTextField()`.
- `entity_reference` to `taxonomy_term` → `handleTaxonomyField()` finds/creates a
  `section > tag > value` term hierarchy (`createTerm`).
- `datetime`/`date` → `handleDateField()` parses using core date formats `exif` and `atom`
  (`core.date_format.exif.yml` / `core.date_format.atom.yml`).

`getDataFromFileUri()` copies non-local (remote stream-wrapper) files to a temporary local path
before reading and cleans them up in `__destruct()`.

## Media-type edit form mapping (media only)

For media types, `ExifHooks::formMediaTypeEditFormAlter()` adds an **EXIF configuration** fieldset to
the media-type edit form: choose the image field, optionally pre-load a tag into image `alt`, and map
other fields to tags. These are saved as media-type third-party settings under key `exif`
(`image_field`, `alt`, `field_map`) by `exif_media_type_form_builder()` (schema
`media.type.*.third_party.exif`). On upload, `ExifHooks::entityPresave()` and `formAlter()` fill the
mapped fields/alt only when currently empty. `ExifHooks::entityExtraFieldInfo()` also exposes an
`exif_inline_data_display` pseudo-field showing available metadata as a table on the media form.

## Migration

`src/Plugin/migrate/field/d7/ExifReadOnly.php` (`@MigrateField id = exif_read_only`, core 7) maps the
D7 `exif_readonly` widget to the D8+ `exif_readonly` widget.
