<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Block Types (EBT): Slick Slider (ebt_slick_slider) — agent index

Ships a ready-made **Slick Slider block type** built on the Slick (kenwheeler) jQuery carousel.
Installing the module imports (via `config/install`) a `block_content` bundle `ebt_slick_slider`
plus a `paragraph` bundle `ebt_slick_slider` ("EBT Slick Slide"): each slide is a paragraph with a
**required** media-image (`field_ebt_slick_slider_image`), optional text (`field_ebt_slick_slider_text`)
and an optional link (`field_ebt_slick_slider_link`); the block holds an unlimited-cardinality
reference to those slides (`field_ebt_slick_slider`) alongside the shared settings field
(`field_ebt_settings`, from `ebt_core`) and a `body`. At render time four Twig templates wrap the
slides in Slick markup (`.slides > .slide`) and attach the library `ebt_slick_slider/slick_slider`;
the behavior `Drupal.behaviors.ebtSlickSlider` reads per-block options out of
`drupalSettings.ebtSlickSlider` and calls `.slick(options)`. The only PHP is one field widget,
`ebt_settings_slick_slider` (`EbtSettingsSlickSliderWidget`), which extends `ebt_core`'s
`EbtSettingsDefaultWidget` to add the full set of Slick knobs (slidesToShow/Scroll, autoplay, arrows,
dots, centerMode, fade, lazyLoad, per-breakpoint responsive settings, and an "Additional settings"
group).

It is one of the **Extra Block Types** family (`ebt_core ^2.0`): many one-component-per-module block
types over a shared core that supplies the `ebt_settings` field type, the design/background options,
and the CSS-variable machinery. Components here are **block content types** (placeable in regions and
in Layout Builder), which is the difference from the EPT family (paragraph types). `paragraphs`
remains a hard dependency because each slide is itself a paragraph; `media`/`media_library` are
required for the slide images (`hook_requirements` errors on install if no `image` media type exists).
There are **no routes, no services, no permissions, no drush, and no own config schema** — the whole
surface is the shipped block/paragraph types, the settings widget, the templates, and the client-side
Slick glue.

- Depends on: `drupal:media`, `drupal:media_library`, `ebt_core:ebt_core`, `paragraphs:paragraphs`
  (info.yml declares only `ebt_core` and `paragraphs`; `media`/`media_library`/`field_group`/`link`/
  `text`/`entity_reference_revisions` come in as config-install dependencies).
- Composer: `drupal/ebt_core ^2.0`, `drupal/paragraphs ^1.0`, `levmyshkin/slick ^1.8.2` (a maintained
  Slick fork installed to `/libraries/slick`).
- Core: `^10.1 || ^11 || ^12`. Package: `Extra Block Types`.
- No settings page / `configure` route. Provides no permissions, no drush, no plugin types, no own
  config schema. Provides one field **widget** plugin (`ebt_settings_slick_slider`).

## Choosing it

- **Reach for it when Slick is already in the theme.** Slick is a jQuery library; on a site that has
  moved past jQuery, `ebt_slideshow` (FlexSlider) is the sibling that avoids reintroducing the
  dependency.
- **Carousel accessibility, as always:** auto-advance must be pausable (WCAG) and controls need
  accessible names and keyboard operation. Slick's `accessibility` option (tabbing/arrow-key nav) is
  on by default; still test.

## What you'd do → where

- **Place a slider, understand the block/paragraph structure, fields, displays, templates and the
  Slick JS runtime** → [configure/block-type.md](configure/block-type.md)
- **Set the Slick options (slidesToShow, autoplay, dots, responsive breakpoints, additional) from the
  settings tab or from code / see every `ebt_settings` option key and default** →
  [fields/widget.md](fields/widget.md)

## Key facts (real machine names)

- Block content type: `ebt_slick_slider` (label "EBT Slick Slider"). Paragraph type:
  `ebt_slick_slider` (label "EBT Slick Slide", description "Slide for EBT Slick Slider").
- Block fields: `field_ebt_slick_slider` (`entity_reference_revisions` → paragraph `ebt_slick_slider`,
  `cardinality: -1`), `field_ebt_settings` (`ebt_settings`, storage owned by `ebt_core`), `body`
  (`text_with_summary`).
- Paragraph (slide) fields: `field_ebt_slick_slider_image` (`entity_reference` → media bundle `image`,
  **required**), `field_ebt_slick_slider_text` (`text_long`), `field_ebt_slick_slider_link` (`link`).
- Field widget: id `ebt_settings_slick_slider`, class
  `Drupal\ebt_slick_slider\Plugin\Field\FieldWidget\EbtSettingsSlickSliderWidget`, field type
  `ebt_settings`, extends `Drupal\ebt_core\Plugin\Field\FieldWidget\EbtSettingsDefaultWidget`.
- Libraries: `ebt_slick_slider/slick_slider` (`js/slick-slider.js` + `/libraries/slick/slick/slick.js`,
  `/libraries/slick/slick/slick.css`, `/libraries/slick/slick/slick-theme.css`; deps `core/drupal`,
  `core/jquery`, `core/once`, `core/drupalSettings`) and `ebt_slick_slider/basic`
  (`css/basic/slick-basic.css`, attached only when the "Basic" style is selected).
- JS: behavior `Drupal.behaviors.ebtSlickSlider`; reads `drupalSettings.ebtSlickSlider[i].{blockClass,options}`;
  slider selector `.<blockClass> .slides`; run-once guard class `slick-slider-added`; forces the
  parent `.layout__region` to `overflow:hidden`.
- Templates (theme hook suggestions): `block--block-content--ebt-slick-slider.html.twig`,
  `block--inline-block--ebt-slick-slider.html.twig`,
  `field--block-content--field-ebt-slick-slider--ebt-slick-slider.html.twig`,
  `paragraph--ebt-slick-slider--default.html.twig`.
- Image style: `slick_slider_card` (scale-and-crop 400×300, center) — the default slide-image display.
- `.install`: `hook_requirements` (install phase — requires an `image` media type),
  `ebt_slick_slider_uninstall` (keeps the block type on uninstall), update `..._update_9101` (makes
  `field_ebt_slick_slider_image` required).
- Block form display groups fields into `field_group` tabs "Content" (`body`, `field_ebt_slick_slider`)
  and "Settings" (`field_ebt_settings`).
