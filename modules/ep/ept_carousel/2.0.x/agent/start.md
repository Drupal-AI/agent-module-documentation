<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Paragraph Types (EPT): Carousel (ept_carousel) — agent index

Ships two Paragraphs bundles — **`ept_carousel`** (the wrapper: title/text + a nested Paragraphs
field of slides) and **`ept_carousel_item`** (one slide: a required media image, caption, optional
link) — plus a settings widget that exposes the **Tiny Slider** JavaScript options. An editor adds
the paragraph, adds slide items, and picks each slide image from the **media library**; on render,
ept_core copies the picked Tiny Slider options into `drupalSettings.eptCarousel` and this module's
`js/tiny-slider/tiny-slider.js` calls `tns()` to build the slider. Everything is installed as
**config + templates + two hooks + one settings widget** — there is no controller, route, service
(other than the hook class), permission, Drush command, or config schema of its own; the shared EPT
design options (margin/padding/border/background/container width) and all the render plumbing that
emits the `{{ styles|raw }}` block and attaches the JS come from **`ept_core`**.

- Depends on: `drupal:link`, `drupal:media`, `drupal:media_library`, `ept_core:ept_core`,
  `paragraphs:paragraphs`. Composer also requires `levmyshkin/tiny-slider:^2.9` (the Tiny Slider
  JS/CSS placed under `/libraries/tiny-slider/`).
- Core: `^10.1 || ^11 || ^12`. Package: `Extra Paragraph Types`. Version `2.0.1`.
- No settings page / `configure` route. No permissions, no Drush, no config schema, no plugin types
  (it provides one field **widget** plugin, `ept_settings_carousel`, but no plugin *type*).
- **Install note:** `hook_requirements()` (`ept_carousel.install`) blocks install until an **`image`**
  media type (`MediaType` id `image`) exists — the item's `field_ept_carousel_image` config depends
  on `media.type.image`. Create one at `/admin/structure/media` first. This is why the module
  **failed to enable** in the harness (its `ept_core` dependency / image media type were not fully
  available); everything here is verified from source, Drupal 11.x.

## What you'd do → where

- **The two paragraph bundles, their fields, form/view displays** → [fields/paragraph-types.md](fields/paragraph-types.md)
- **The `ept_settings_carousel` widget + every Tiny Slider option key + how options reach the JS** → [configure/settings.md](configure/settings.md)
- **Templates, the two hooks (`theme_registry_alter`, `preprocess_paragraph`), `{{ styles|raw }}`, the `tns()` init, libraries** → [theme/rendering.md](theme/rendering.md)

## Key facts (real machine names)

- Paragraph bundles: `ept_carousel` (`paragraphs.paragraphs_type.ept_carousel`, label "EPT
  Carousel"), `ept_carousel_item` (`…ept_carousel_item`, label "EPT Carousel Item").
- Wrapper `ept_carousel` fields: `field_ept_title` (text_long, from ept_core), `field_ept_text`
  (text_long, from ept_core), `field_ept_carousel` (entity_reference_revisions → paragraph,
  cardinality **-1**, target bundle `ept_carousel_item`), `field_ept_settings` (`ept_settings`, from
  ept_core; widget `ept_settings_carousel`).
- Item `ept_carousel_item` fields: `field_ept_carousel_image` (entity_reference → media, `image`
  bundle, cardinality 1, **required**), `field_ept_carousel_caption` (text_long),
  `field_ept_carousel_item_link` (link, `link_type: 17`).
- Settings widget: id **`ept_settings_carousel`** →
  `Drupal\ept_carousel\Plugin\Field\FieldWidget\EptSettingsCarouselWidget` (field type
  `ept_settings`; extends ept_core `EptSettingsDefaultWidget`).
- Hook service (autowired, `ept_carousel.services.yml`): `Drupal\ept_carousel\Hook\EptCarouselHooks`
  — implements `hook_theme_registry_alter()`. `ept_carousel.module` also keeps a plain
  `ept_carousel_preprocess_paragraph()` (swaps the slide image style to the wrapper's `image_size`
  setting) and a `#[LegacyHook]` wrapper for the theme registry alter.
- Libraries (`ept_carousel.libraries.yml`): `ept_carousel/tiny_slider`
  (`/libraries/tiny-slider/dist/min/tiny-slider.js` + `js/tiny-slider/tiny-slider.js`; CSS
  `/libraries/tiny-slider/dist/tiny-slider.css`; deps `core/drupal`, `core/jquery`, `core/once`,
  `core/drupalSettings`) and `ept_carousel/basic` (`css/basic/basic.css`). JS reads
  `drupalSettings.eptCarousel`.
- Templates: `paragraph--ept-carousel--default.html.twig`,
  `paragraph--ept-carousel-item--default.html.twig`,
  `field--paragraph--field-ept-carousel--ept-carousel.html.twig`.
- Registered theme hooks (via `EptCarouselHooks::themeRegistryAlter`):
  `paragraph__ept_carousel_item__default`, `field__paragraph__field_ept_carousel__ept_carousel`.
- Install/update hooks (`ept_carousel.install`): `hook_requirements` (image media type),
  `update_8001` (installs `media` + `media_library`), `update_9101` (relabels the bundle),
  `update_9102` (marks `field_ept_carousel_image` required).

Siblings: `ept_slideshow` (Flexslider, wave 73), `ept_tiles`, `ept_tabs`.
