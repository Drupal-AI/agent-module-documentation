<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Paragraph Types (EPT): Slick Slider (ept_slick_slider) — agent index

Provides two Paragraphs bundles that render a set of slides as a Slick.js carousel, with the full
Slick option set exposed per-paragraph. Version **2.0.1**. Core `^10.1 || ^11 || ^12`.

## Dependencies
- `ept_core` (shared `ept_settings` field type, default design widget, `GenerateCSS`, `{{ styles }}`).
- `paragraphs`.
- `levmyshkin/slick` Composer package → Slick JS/CSS served **locally** from `/libraries/slick`
  (no CDN). Slide images use the `media` Image type (soft dep; `hook_requirements` warns if missing).
- Config also pulls in `entity_reference_revisions`, `link`, `text`, `field_group`.

## What it provides
- **Paragraphs types:** `ept_slick_slider` (container) and `ept_slick_slider_item` (one slide).
- **Fields on the container:** `field_ept_slick_slider` (entity_reference_revisions → slide items,
  cardinality -1), plus shared `field_ept_settings`, `field_ept_title`, `field_ept_text` from ept_core.
- **Fields on the item:** `field_ept_slick_slider_image` (required media/Image ref),
  `field_ept_slick_slider_text` (text_long), `field_ept_slick_slider_link` (link).
- **Field widget plugin:** `ept_settings_slick_slider` (`EptSettingsSlickSliderWidget` extends
  `ept_core`'s `EptSettingsDefaultWidget`) — the Slick options form.
- **Image style:** `ept_slick_slider_card` (scale-and-crop 400x300).
- **Libraries:** `ept_slick_slider/slick_slider` (Slick + `js/slick-slider.js`) and
  `ept_slick_slider/basic` (`css/basic/slick-basic.css`).
- **Hook:** `theme_registry_alter` (OOP `EptSlickSliderHooks`) registers the two module templates.
- **No routes, permissions, services, config schema, drush, or admin settings form of its own.**

## How it renders
`js/slick-slider.js` (`Drupal.behaviors.eptSlickSlider`) reads `drupalSettings.eptSlickSlider[i].options`
(set by ept_core because the widget flags `pass_options_to_javascript = TRUE`), builds a Slick options
object, and calls `.slick(options)` on the `.slides` wrapper produced by the field template. All string
options are passed through `Drupal.checkPlain()`.

## Solution docs
- [agent/config/settings.md](config/settings.md) — the bundles, fields, config/install, the
  `ept_settings_slick_slider` widget option map, templates, libraries, and how to operate it.
