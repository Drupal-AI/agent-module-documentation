<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image WebP Converter (image_webp_converter) — agent index

Converts **already-stored source images** to WebP **in place** and **rewrites the file entity and the
references** that point at it. Conversion is done by the `rosell-dk/webp-convert` library
(`WebPConvert::convert()`); the module itself does **not** invoke `cwebp` on the shell. Depends on core
`file` and `image`. Core requirement `^10 | ^11` (single pipe — worth confirming it behaves as intended).
Release **1.0.1**, doc version dir `1.0.x`.

**Know the alternative first.** Core image styles already produce WebP **derivatives**, leaving originals
untouched — the right choice for most sites. **This converts the sources**, reducing stored size too, and
**is not reversible**.

## What it does

- **Site-wide batch** — form at `/admin/config/media/image-webp-converter` (permission
  `convert images to webp`) → `ImageBatchConverter::startBatch()`. Queries every managed `image/jpeg` /
  `image/png` file (`accessCheck(FALSE)`), converts in chunks of 30, repoints each file's URI/filename to
  `.webp` and sets `filemime` = `image/webp`, then `updateContentReferences()` rewrites image fields,
  CKEditor `text_with_summary` bodies, and media names.
- **Per-node** — when *per_node_conversion* is on, `hook_form_alter` adds a *Convert images to WebP*
  checkbox to node add/edit forms; `hook_entity_presave` (in `.module`) converts the node's image fields,
  `text`/`text_long`/`text_with_summary` `<img>` refs under `public://`, and referenced media.
- **Upload tool** — form at `/admin/config/media/image-webp-uploader` (`UploadWebpConverter`) converts one
  uploaded JPG/PNG to `public://converted_images/` and returns a download link.
- **Field alter** — `hook_form_field_config_edit_form_alter` auto-appends `webp` to a field's allowed
  file extensions.

## Converters & settings

Settings form `/admin/config/media/image-webp-settings-form` (`administer image webp converter`,
`restrict access: true`) → config `image_webp_converter.settings`: `selected_converter` (`gd` default /
`cwebp` / `imagick`), `quality` (0–100, default 85, form-validated `#min`/`#max`), `lossless` (PNG only),
`per_node_conversion`. GD/Imagick availability is checked via `extension_loaded()`; an invalid converter
falls back to `gd` (batch service comments say cwebp but code falls back to gd).

## Plan before running the batch

1. **It edits content.** Rewriting references writes to entities — **back up and run on a copy first**. A
   missed reference is a broken image; a wrongly rewritten one is a wrong image.
2. **Originals are the archive.** Converting rather than deriving **discards the original permanently**.
3. **External URLs do not update.** Anything linking the old filename (email, PDF, other site, search
   index) now points at a file that no longer exists.

## Detail files

- `config/settings-and-converters.md` — the settings form, the three converters, quality/lossless
  semantics, and the `rosell-dk/webp-convert` options actually passed.
- `conversion/paths.md` — the batch, per-node, and upload conversion paths, plus reference rewriting and
  the field-extension alter, with the routes/permissions and gotchas for each.
