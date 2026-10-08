<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pictogram media integration

Makes the picker's pictogram catalogue editable as media entities.

## Install / enable
- `drush en dsfr4drupal_picker_media -y` (pulls in `dsfr4drupal_picker`, `media`, `taxonomy`, `svg_image`).
- On enable, Drupal imports the optional config in `config/optional/`. For sites enabled before that config shipped, `dsfr4drupal_picker_media_update_10001()` (in `.install`) calls `config.installer` `installOptionalConfig()` to add only the still-missing objects.

## Installed configuration (`config/optional/`)
- `media.type.pictogram` — media type **Pictogram**, `source: image`, source field `field_media_pictogram`, `new_revision: true`.
- `field.storage.media.field_media_pictogram` + `field.field.media.pictogram.field_media_pictogram` — required image field; `file_extensions: 'svg'`, `uri_scheme: public`, cardinality 1, `alt_field: true`. (SVG display relies on `svg_image`.)
- `taxonomy.vocabulary.pictograms_custom_categories` — vocabulary **Pictograms custom categories**.
- `field.storage.media.field_media_pictogram_category` + `field.field.media.pictogram.field_media_pictogram_category` — optional entity_reference to that vocabulary; `auto_create: true`, `auto_create_bundle: pictograms_custom_categories`.
- `core.entity_form_display.media.pictogram.default` / `.media_library` and `core.entity_view_display.media.pictogram.default` / `.media_library` — form/view displays incl. a Media Library variant.

No config schema is shipped by this submodule (`provides_config_schema: false`); it reuses core media/field/taxonomy schemas.

## Hook class: `Dsfr4drupalPickerMediaHooks`
File: `src/Hook/Dsfr4drupalPickerMediaHooks.php`. Constants: `GROUP_DEFAULT = 'custom'`, `GROUP_CATEGORY_PREFIX = 'taxonomy_term:'`. Constructor injects `EntityTypeManagerInterface`, `FileUrlGeneratorInterface`, `LanguageManagerInterface`.

- `dsfr4drupal_picker_pictograms()` — entity query for `media` of `bundle = pictogram` with `->accessCheck()` (access checking on), loads each, and builds `$pictograms[$group][] = $group . '/' . $media->id()`. `$group` is `taxonomy_term:<tid>` when the pictogram has a category, otherwise `custom`. Returns the grouped list of pictogram identifiers.

- `dsfr4drupal_picker_pictogram_path_alter($pictogram, &$path)` — splits `$pictogram` into `[$group, $mediaId]` (limit 2). Only when the group is `custom` or starts with `taxonomy_term:`, `$mediaId` is set, and `(int) $mediaId == $mediaId`, it loads the media, verifies it is a `MediaInterface` of bundle `pictogram`, reads the source file value, loads the `File`, and sets `$path` to the file URL via `FileUrlGenerator::generateString()` (leading slash trimmed). Resolves a pictogram entry to its SVG file URL.

- `dsfr4drupal_picker_group_label_alter($group, &$label)` — for groups prefixed `taxonomy_term:`, loads the term id after the prefix, applies the current-language translation if present, and sets `$label` to the term's label. Gives category groups human-readable, translatable names in the picker UI.

## Operating it
Create/edit pictograms at the media UI (bundle **Pictogram**): upload an SVG, optionally assign a category term (auto-created if new). They then appear in the icon/pictogram picker grouped under their category label. Removing/unpublishing a pictogram media removes it from the picker on the next build (subject to the access check in the pictograms hook).
