<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Swiffy Slider (swiffy_slider) — agent index

Drupal integration of the **Swiffy Slider** JS library (bundled `dynamicweb/swiffy-slider`, MIT).
Renders field items or Views rows as a lightweight CSS-scroll-snap **slider/carousel**. Version
**1.4.0**, version dir **1.4.x**. Core `^10 || ^11` (composer requires `drupal/core ^10.3 || ^11`).
License GPL-2.0-or-later. **No permissions, no Drush, no declared module dependencies**; the
image/text formatters and the Views style rely on core `image`, `text`, `views`.

Sliders are described by a **configuration URL** — a permalink copied from
`https://swiffyslider.com/configuration/`. The service parses that URL's query string into CSS
classes / data-attributes / style custom properties on the slider container.

## What it provides (from source)

- **Service `swiffy_slider.configuration`** — `Drupal\swiffy_slider\Configuration` (impl.
  `ConfigurationInterface`), `swiffy_slider.services.yml`. `toAttributes(?string $url)` parses the
  permalink and builds the container `Attribute` object; `configurationUrlElement()` builds the
  reusable URL form element (`#maxlength` 1000). Helper `RenderHelper::attachCacheTags()`.
- **Three field formatters** (share `SwiffySliderFieldFormatterTrait`,
  `src/Plugin/Field/FieldFormatter/`):
  - `swiffy_slider_entity_reference` — `SwiffySliderEntityReferenceFormatter` extends core
    `EntityReferenceEntityFormatter`; field types `entity_reference`, `entity_reference_revisions`.
  - `swiffy_slider_image` — `SwiffySliderImageFormatter` extends core `ImageFormatter`; `image`.
  - `swiffy_slider_text_default` — `SwiffySliderTextDefaultFormatter` extends core
    `TextDefaultFormatter`; `text`, `text_long`, `text_with_summary`.
  Each adds one setting `swiffy_slider_permalink` and attaches library `swiffy_slider/swiffy_slider-lib`.
- **Views style `swiffy_slider`** — `SwiffySlider` (`src/Plugin/views/style/SwiffySlider.php`),
  extends `StylePluginBase`, uses a row plugin, no grouping; adds option `configuration_url`.
- **Settings form / route** `swiffy_slider.settings` at `/admin/config/content/swiffy_slider`
  (`SettingsForm`, permission `administer site configuration`), config object
  `swiffy_slider.settings` key `configuration_url`. Menu link in `*.links.menu.yml`.
- **Templates** `templates/field--swiffy-slider-entity-reference.html.twig` and
  `templates/views-style-swiffy-slider.html.twig` (wrap items/rows in `<ul class="slider-container">`
  with `slider-nav` buttons + `slider-indicators`). Theme hooks & preprocess in `swiffy_slider.module`.
- **Library** `swiffy_slider-lib` (`swiffy_slider.libraries.yml`) — bundled min JS/CSS under
  `assets/vendor/dynamicweb/swiffy-slider`; `hook_library_info_alter` swaps to a self-installed
  `/libraries/swiffy-slider` copy when present.
- **`swiffy_slider.post_update.php`** — three post-updates migrating empty-string
  `configuration_url` values (settings, view styles, formatter settings) to `NULL`.

## Solution docs

- Formatters (the three field formatters, settings, templates) →
  [fields/formatters.md](fields/formatters.md)
- Views style + global settings, the configuration-URL mechanism, config objects/schema →
  [config/settings-and-views.md](config/settings-and-views.md)
