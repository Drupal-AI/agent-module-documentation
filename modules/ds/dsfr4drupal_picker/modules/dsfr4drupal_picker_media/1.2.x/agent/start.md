<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DSFR for Drupal - Picker - Media (dsfr4drupal_picker_media) — agent index

Submodule of DSFR for Drupal - Picker. Lets editors contribute custom pictograms as media entities and feeds them into the picker via hooks.

- Machine name: `dsfr4drupal_picker_media`
- Dependencies: `dsfr4drupal_picker` (parent), `media`, `taxonomy`, `svg_image`.
- Core: `^10.3 || ^11 || ^12`. License: GPL-2.0-or-later. No permissions, routes.

## What it provides
- Optional config installed on enable (`config/optional/`): media type `pictogram` (SVG image source, `field_media_pictogram`), taxonomy vocabulary `pictograms_custom_categories`, category reference field `field_media_pictogram_category`, and the default + `media_library` form/view displays.
- Hook class `Drupal\dsfr4drupal_picker_media\Hook\Dsfr4drupalPickerMediaHooks` (autowired in `dsfr4drupal_picker_media.services.yml`; `#[LegacyHook]` shims in the `.module`), injecting `EntityTypeManager`, `FileUrlGenerator`, `LanguageManager`.
- Implements `dsfr4drupal_picker_pictograms`, `dsfr4drupal_picker_pictogram_path_alter`, `dsfr4drupal_picker_group_label_alter`.
- `dsfr4drupal_picker_media.install`: `hook_update_10001` re-imports the optional category config on existing sites.

## Solution docs
- [Pictogram media integration](config/pictogram-media.md) — the media type/vocabulary/fields and the three hooks.
