# Exif field widgets

The module ships three **form widgets** (not display formatters) that populate a field from image
metadata. Assign one on *Manage form display* of a bundle that is enabled on the settings page. Each
widget instance is bound to an **image field** and to a **metadata tag**.

| Widget id | Field types it supports | Behavior |
|---|---|---|
| `exif_readonly` | string, string_long, text, text_with_summary, text_long, entity_reference, date, datetime, datestamp | Value shown read-only on the form. |
| `exif_hidden` | text, text_long | Value populated but hidden from the form. |
| `exif_html` | text, text_long | Stores a full HTML `<table>` of **all** tags; default tag `all_all`. |

Source: `src/Plugin/Field/FieldWidget/Exif*Widget*.php`.

## Widget settings (schema `field.widget.settings.exif_*`)

- `image_field` — which image/file/media field on the bundle supplies the metadata (radio list; for
  `file` entities it is fixed to `file`).
- `exif_field` — the metadata tag to read, or `naming_convention` to derive it from the Drupal field
  name (see below). `exif_html` defaults to `all_all` (dump everything).
- `exif_field_separator` — optional single character; when set, a metadata string is `explode()`d into
  multiple field values.

## Naming convention

When `exif_field` = `naming_convention`, the tag is taken from the field machine name with the
`field_` prefix stripped, as `<section>_<tag>`:

- `field_exif_model` → EXIF section, tag `model`
- `field_ifd0_datetime` → IFD0 section, tag `datetime`
- `field_gps_gpslatitude` → GPS section

`ExifInterface::getFieldKeys()` lists every selectable section/tag; the dropdown is populated from it.

## How values are written (`ExifContent::entityInsertUpdate`)

- Runs on `hook_entity_presave` (and title fill on `hook_entity_create`); only for bundles listed in
  the settings, and only on insert unless `update_metadata` is on.
- **Text/string fields** → the tag value.
- **`entity_reference` to taxonomy** → looks up or creates a term, auto-building a
  `section > tag > value` parent hierarchy in the configured vocabulary.
- **date/datetime** → parses with the `exif`/`atom` date format entities into storage format.
- **`all` tag (`exif_html`)** → builds `<table class="metadata-table">…</table>` and stores it with
  `format => full_html`.
