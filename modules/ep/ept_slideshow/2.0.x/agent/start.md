<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Paragraph Types (EPT): Slideshow (ept_slideshow) — agent index

Ships two Paragraphs bundles — **`ept_slideshow`** (the wrapper, with title/text and a nested
Paragraphs field) and **`ept_slideshow_item`** (one slide: media image, title, text, link) — plus a
settings widget that exposes the **Flexslider** JavaScript options. An editor adds the paragraph,
adds slide items, and picks slides from the **media library**; on render, ept_core hands the picked
Flexslider options to `drupalSettings` and this module's `js/flexslider/flexslider.js` initialises
the slider (fade slideshow or `animation:slide` carousel). Everything is installed **config +
templates + one hook + one settings widget** — there is no controller, route, service (other than
the hook class), permission, Drush command, or config schema of its own; the shared EPT design
options (margin/padding/border/background/container width) and all rendering plumbing come from
`ept_core`.

- Depends on: `drupal:media`, `drupal:media_library`, `ept_core:ept_core`, `paragraphs:paragraphs`.
  Composer also requires `levmyshkin/flexslider:^2.7` (the Flexslider JS/CSS placed at
  `/libraries/flexslider/`).
- Core: `^10.1 || ^11 || ^12`. Package: `Extra Paragraph Types`. Version `2.0.0`.
- No settings page / `configure` route. No permissions, no Drush, no config schema, no plugin types.
- **Install note:** `hook_requirements()` (`ept_slideshow.install`) blocks install until an
  **`image`** media type (`MediaType` id `image`) exists — the item's `field_ept_slideshow_slide`
  config depends on `media.type.image`. Create one at `/admin/structure/media` first.

## What you'd do → where

- **The two paragraph bundles, their fields, form/view displays** → [fields/paragraph-types.md](fields/paragraph-types.md)
- **The `ept_settings_slideshow` widget + every Flexslider option key + how options reach the JS** → [configure/settings.md](configure/settings.md)
- **Templates, the `theme_registry_alter` hook, `{{ styles|raw }}`, the FlexSlider init behavior, libraries** → [theme/rendering.md](theme/rendering.md)

## Key facts (real machine names)

- Paragraph bundles: `ept_slideshow` (`paragraphs.paragraphs_type.ept_slideshow`, label "EPT
  Slideshow"), `ept_slideshow_item` (`…ept_slideshow_item`, label "EPT Slideshow Item").
- Wrapper `ept_slideshow` fields: `field_ept_title` (text_long), `field_ept_text` (text_long),
  `field_ept_slideshow` (entity_reference_revisions → paragraph, cardinality **-1**, target bundle
  `ept_slideshow_item`), `field_ept_settings` (`ept_settings`, from ept_core).
- Item `ept_slideshow_item` fields: `field_ept_slideshow_slide` (entity_reference → media, `image`
  bundle, cardinality 1), `field_ept_slideshow_title` (text_long), `field_ept_slideshow_text`
  (text_long), `field_ept_slideshow_link` (link, `link_type: 17`).
- Settings widget: id **`ept_settings_slideshow`** →
  `Drupal\ept_slideshow\Plugin\Field\FieldWidget\EptSettingsSlideshowWidget` (field type
  `ept_settings`; extends ept_core `EptSettingsDefaultWidget`).
- Hook service (autowired): `Drupal\ept_slideshow\Hook\EptSlideshowHooks` — implements
  `hook_theme_registry_alter()` only. `ept_slideshow.module` keeps a thin `#[LegacyHook]` wrapper.
- Library: `ept_slideshow/flexslider` (`js/flexslider/flexslider.js` + a vendored
  `/libraries/flexslider/jquery.flexslider-min.js`; CSS `css/flexslider/flexslider.css`). JS reads
  `drupalSettings.eptSlideshow`.
- Templates: `paragraph--ept-slideshow--default.html.twig`,
  `paragraph--ept-slideshow-item--default.html.twig`,
  `field--paragraph--field-ept-slideshow--ept-slideshow.html.twig`.
- Registered theme hooks (via the hook): `paragraph__ept_slideshow_item__default`,
  `field__paragraph__field_ept_slideshow__ept_slideshow`.
