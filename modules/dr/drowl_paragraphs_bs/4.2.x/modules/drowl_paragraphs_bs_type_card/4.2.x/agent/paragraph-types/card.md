<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The 'Card / Tile' paragraph type (drowl_paragraphs_bs_type_card)

## Install & enable

```bash
drush en drowl_paragraphs_bs_type_card -y
```

Enabling pulls in its dependencies (`drowl_paragraphs_bs:drowl_paragraphs_bs`, `link_attributes:link_attributes`, `media_library:media_library`, `media_library_edit:media_library_edit`, `fences:fences`, `field_formatter:field_formatter`, `drupal:media`) and imports the shipped `config/install` (paragraphs_type, fields, entity form/view displays, optional language content settings). It has no permissions, routes, services or config schema of its own.

## Bundle(s) & fields

`field_image` (media ref), `field_image_zoomable` (bool), `field_link` (link), `field_resp_imagestyle`, `field_subtitle`, `field_text`, `field_title`, and `field_settings`.

## `.module` (preprocess)

`drowl_paragraphs_bs_type_card_preprocess_paragraph()` (bundle `card`) determines `card_type` from a `card--type-*` class (default `card`). For a `tile`, `bg-*`/`backdrop-filter-*` classes move to `card_body_attributes` (the overlay); `btn-*` classes move to `button_attributes`.

## Template

`templates/paragraph--drowl-paragraphs-bs--card.html.twig` includes the base `inc/flexible_image.html.twig` for the picture, then renders the title (optionally linked via Twig `link()`), subtitle, `card-text`, and either a `.card-buttons` button or an overlay link. External links get `target="_blank"`. Title/subtitle/text are printed with `|field_value` (rendered field output).

## UI Styles

`drowl_paragraphs_bs_type_card.ui_styles.yml` defines `card_type` (`card--type-card` regular vs `card--type-tile` overlay).

## Notes

- This is a presentational bundle for the Paragraphs / Layout Paragraphs stack; it is not standalone.
- Per-instance options are UI Styles selected under the Paragraphs 'Settings', not a config form.
- Override the template in your Bootstrap 5 / Radix / DROWL Base theme to change markup.
