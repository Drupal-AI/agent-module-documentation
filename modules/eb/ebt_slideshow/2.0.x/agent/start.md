<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Block Types (EBT): Slideshow (ebt_slideshow) — agent index

Ships a ready-made **Slideshow block type** built on FlexSlider. Installing the module imports (via
`config/install`) a `block_content` bundle `ebt_slideshow` plus a `paragraph` bundle `ebt_slideshow`
("EBT Slide"): each slide is a paragraph with a required media-image (`field_ebt_slideshow_slide`),
an optional title/text/link, and the block holds an unlimited-cardinality reference to those slides
(`field_ebt_slideshow`) alongside a shared settings field (`field_ebt_settings`, from `ebt_core`).
At render time four Twig templates wrap the slides in FlexSlider markup (`.ebt-slideshow-wrapper`,
`.slides > .slide`) and attach the library `ebt_slideshow/flexslider`; the behavior
`Drupal.behaviors.ebtSlideshow` reads per-block options out of `drupalSettings.ebtSlideshow` and calls
`.flexslider(options)`. The only PHP in the module is one field widget,
`ebt_settings_slideshow` (`EbtSettingsSlideshowWidget`), which extends `ebt_core`'s
`EbtSettingsDefaultWidget` to add all the FlexSlider knobs (animation, direction, slideshow timing,
navigation, carousel min/max items) to the block's settings tab.

It is one of the **Extra Block Types** family (`ebt_core ^2.0`): many one-component-per-module block
types over a shared core that supplies the `ebt_settings` field type, the design/background options,
and the CSS-variable machinery. Components here are **block content types** (placeable in regions and
in Layout Builder), which is the difference from the EPT family (paragraph types). `paragraphs`
remains a hard dependency because each slide is itself a paragraph; `media`/`media_library` are
required for the slide images (install fails via `hook_requirements` if no `image` media type exists).
There are **no routes, no services, no permissions, no drush, and no own config schema** — the whole
surface is the shipped block/paragraph type, the settings widget, the templates, and the client-side
FlexSlider glue.

- Depends on: `drupal:media`, `drupal:media_library`, `ebt_core:ebt_core`, `paragraphs:paragraphs`.
- Composer: `drupal/ebt_core ^2.0`, `drupal/paragraphs ^1.0`, `levmyshkin/flexslider ^2.7` (a maintained
  FlexSlider fork installed to `/libraries/flexslider`).
- Core: `^10.1 || ^11 || ^12`. Package: `Extra Block Types`.
- No settings page / `configure` route. Provides no permissions, no drush, no plugin types, no own
  config schema. Provides one field **widget** plugin (`ebt_settings_slideshow`).

## What you'd do → where

- **Place a slideshow, understand the block/paragraph structure, fields, displays, templates and the
  FlexSlider JS runtime** → [configure/block-type.md](configure/block-type.md)
- **Set the slideshow options (animation, timing, nav, carousel) from the settings tab or from code /
  see every `ebt_settings` option key and default** → [fields/widget.md](fields/widget.md)

## Key facts (real machine names)

- Block content type: `ebt_slideshow` (label "EBT Slideshow"). Paragraph type: `ebt_slideshow`
  (label "EBT Slide", `description` "Slideshow section for EBT Slideshow").
- Block fields: `field_ebt_slideshow` (`entity_reference_revisions` → paragraph `ebt_slideshow`,
  `cardinality: -1`), `field_ebt_settings` (`ebt_settings`, storage owned by `ebt_core`).
- Paragraph (slide) fields: `field_ebt_slideshow_slide` (`entity_reference` → media bundle `image`,
  **required**), `field_ebt_slideshow_title` (`text_long`), `field_ebt_slideshow_text` (`text_long`),
  `field_ebt_slideshow_link` (`link`).
- Field widget: id `ebt_settings_slideshow`, class
  `Drupal\ebt_slideshow\Plugin\Field\FieldWidget\EbtSettingsSlideshowWidget`, field type `ebt_settings`,
  extends `Drupal\ebt_core\Plugin\Field\FieldWidget\EbtSettingsDefaultWidget`.
- Library: `ebt_slideshow/flexslider` (`js/flexslider/flexslider.js` + `css/flexslider/flexslider.css`
  plus `/libraries/flexslider/jquery.flexslider-min.js` and `/libraries/flexslider/flexslider.css`;
  deps `core/drupal`, `core/jquery`, `core/once`, `core/drupalSettings`).
- JS: behavior `Drupal.behaviors.ebtSlideshow`; reads `drupalSettings.ebtSlideshow[i].{blockClass,options}`;
  slider selector `.slides > .slide`; init target `.ebt-slideshow-wrapper`; run-once guard class
  `flexslider-added`.
- Templates (theme hook suggestions): `block--block-content--ebt-slideshow.html.twig`,
  `block--inline-block--ebt-slideshow.html.twig`,
  `field--block-content--field-ebt-slideshow--ebt-slideshow.html.twig`,
  `paragraph--ebt-slideshow--default.html.twig`.
- `.install`: `hook_requirements` (install phase — requires an `image` media type),
  `ebt_slideshow_uninstall` (keeps the block type on uninstall), updates `..._update_8001`
  (installs `media` + `media_library`), `..._update_9101` (relabels paragraph type to "EBT Slide"),
  `..._update_9102` (makes `field_ebt_slideshow_slide` required).
- Block form display groups fields into `field_group` tabs "Content" (`field_ebt_slideshow`) and
  "Settings" (`field_ebt_settings`).
