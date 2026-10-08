# Configuration

Configuring Exif has three parts: set your options and choose which bundles to
scan on the settings page, add fields to those bundles, and assign an Exif widget
to each field.

## Open the settings page

Go to **Configuration → Media → Exif** (`/admin/config/media/exif`). You need the
**Administer image metadata** permission (marked security‑sensitive).

### Settings

- **Extraction backend** — choose **PHP extensions** (the default, using PHP's
  `exif`/`iptcparse`) or **ExifTool** (the external `exiftool` binary, which
  reads many more tags including GPS). If you pick ExifTool, set the
  **exiftool location** (path or command; defaults to `exiftool`). Exif only
  uses ExifTool if the binary is actually found; otherwise it falls back to the
  PHP extension.
- **Node types / Media types / File types** — tick the bundles you want Exif to
  scan. A bundle is only processed if it is selected here.
- **Vocabulary** — the taxonomy vocabulary used when metadata is written into a
  taxonomy‑term reference field.
- **Date format** — the PHP date pattern used to interpret EXIF date strings
  (default `Y-m-d\TH:i:s`), plus a **granularity** option.
- **Update metadata** — off by default, meaning fields are only filled when an
  entity is first created. Turn it on to re‑read metadata on **every** save.
- **Write empty values** — whether empty metadata should overwrite an existing
  field value.

## Add fields and assign an Exif widget

Once a bundle is enabled on the settings page:

1. Add fields to that bundle (**Manage fields**) to hold the metadata you want —
   for example a text field `field_exif_model`, or a datetime field
   `field_exif_datetimeoriginal`.
2. Go to the bundle's **Manage form display** and set each of those fields to use
   one of the three Exif **form widgets**:

   - **Exif readonly** (`exif_readonly`) — shows the extracted value read‑only on
     the edit form. Works with string, text, entity‑reference, and date/datetime
     fields.
   - **Exif hidden** (`exif_hidden`) — populates the field but hides it on the
     form (useful for values you only want to filter on in Views).
   - **Exif html** (`exif_html`) — stores a full HTML table of **every** tag
     found in the image.

3. In each widget's settings, choose:
   - **Image field** — which image/file field on the bundle supplies the
     metadata.
   - **Metadata tag** — the specific tag to read, or **naming convention** to
     derive it from the field's machine name (see below).
   - **Separator** — an optional single character to split a multi‑value
     metadata string into multiple field values.

### The naming convention

If you set the tag to **naming convention**, Exif derives the tag from the field
machine name by stripping the `field_` prefix and reading it as
`<section>_<tag>`:

- `field_exif_model` → EXIF section, `model` tag
- `field_ifd0_datetime` → IFD0 section, `datetime` tag
- `field_gps_gpslatitude` → GPS section

## Helper and sample pages

Two extra pages (same permission) speed up setup:

- **Helper** (`/admin/config/media/exif/helper`) — a quick‑start guide that can
  scaffold a ready‑made "photography" vocabulary, node type, or media type for
  you. (Note: these scaffolding links create real config as a side effect of
  visiting them.)
- **Sample** (`/admin/config/media/exif/sample`) — renders every tag read from a
  bundled `sample.jpg`; replace that file to inspect the tags in your own image.

## Command line (Drush)

Exif declares three legacy (Drush 8/9‑style) commands: `exif-list` (show which
bundles have extraction enabled), `exif-update` (re‑save all entities of a type
so metadata is re‑read), and `exif-import` (recursively import a folder of JPEGs
as new entities). Note these live in a legacy `.drush.inc` file that **modern
Drush 10+ may not load**, so treat them as reference; `exif-update` also runs
unbatched, so it is memory‑heavy on large sites.
