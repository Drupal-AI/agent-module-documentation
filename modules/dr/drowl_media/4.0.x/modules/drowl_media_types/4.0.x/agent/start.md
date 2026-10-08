<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DROWL Media Types (drowl_media_types) — agent index

Config-heavy submodule of the DROWL Media project. Installs DROWL's media types, fields, view modes,
image/responsive styles, Slick optionsets, crop types and Bootstrap Twig templates, plus a settings
form for slide/slideshow defaults. Version **4.0.18**, dir `4.0.x`. Core `^10.3 || ^11`.
License GPL-2.0-or-later. `configure: drowl_media_types.settings`.

## Dependencies (from `drowl_media_types.info.yml`)

`drowl_media` + core `content_translation, field, file, image, language, link, media, media_library,
options, path, responsive_image, taxonomy, text, views` + contrib `blazy, crop, focal_point, slick,
svg_image (+ svg_image_responsive), photoswipe (+ photoswipe_dynamic_caption), fences,
field_formatter, field_group, file_download_link, link_attributes, media_library_edit, micon,
smart_trim, entity_access_by_role_field`. Large stack — install with `--with-all-dependencies`.

## What it provides

- **Media types** (`config/install/media.type.*`, `config/override/media.type.*`): `slide`,
  `slideshow`, `vector_image` (new) and reconfigured core `image`, `document`, `video`,
  `remote_video`, `audio`. See [media-types/types.md](media-types/types.md).
- **Fields**: dozens of `field.storage.media.*` / `field.field.media.*` (caption, copyright,
  media_folder, media_tags, mime_type, size, note_internal, slide overlay/animation fields,
  slideshow slick fields, `field_svg_as_markup`, …). Vocabularies `media_folder`, `media_tags`.
- **Display**: extra view modes, many image styles + 6 responsive image styles, Slick optionsets,
  crop types (`media_crop`, focal_point). Bootstrap Twig **templates** in `templates/` (+
  `templates/media-library/`). See [theming/templates.md](theming/templates.md).
- **Config object** `drowl_media_types.settings` (schema `config/schema/drowl_media_types.schema.yml`,
  install defaults `config/install/drowl_media_types.settings.yml`).
- **Settings form** `DrowlMediaTypesSettingsForm` at route `drowl_media_types.settings`
  (`/admin/config/media/drowl-media-types-settings`), permission `administer drowl media types
  settings` (`restrict access: TRUE`). `DrowlMediaTypesFieldValuesProvider` supplies the field
  allowed-values + default-value callbacks. See [config/settings.md](config/settings.md).
- **Hooks** (`drowl_media_types.module`): `hook_form_alter` (#states on slide overlay fields),
  `hook_preprocess_media` (document + slideshow), `hook_preprocess_slick` (per-media Slick option
  overrides), `hook_theme` + `hook_theme_suggestions_media_alter` (registers the templates).
- One JS **library** `slideshow` (`drowl_media_types.libraries.yml`). No Drush, no services.

## Routes & permission

- `drowl_media_types.settings` — `GET /admin/config/media/drowl-media-types-settings`, `_permission:
  administer drowl media types settings` (restricted, admin-only). The **only** route. No anonymous
  or state-changing GET routes.

## Solution docs

- Media types + their fields → [media-types/types.md](media-types/types.md)
- Settings form, route, permission, FieldValuesProvider → [config/settings.md](config/settings.md)
- Display templates (document, slide, slideshow, remote-video, vector-image) →
  [theming/templates.md](theming/templates.md)
