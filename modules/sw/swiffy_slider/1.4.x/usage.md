<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Swiffy Slider integrates the Swiffy Slider JavaScript library, adding three field formatters and a Views style that render field items or view rows as a lightweight, CSS-scroll-snap slider/carousel configured by a permalink from the swiffyslider.com configurator.

---

The module wraps the bundled `dynamicweb/swiffy-slider` library (shipped under `assets/vendor/`, overridable with a locally installed copy via `hook_library_info_alter`). It gives you four render integrations, all driven by the same idea: a slider is described by a **configuration URL** — a permalink you build and copy from `https://swiffyslider.com/configuration/`. The service `swiffy_slider.configuration` (`Drupal\swiffy_slider\Configuration`, implementing `ConfigurationInterface`) parses that URL's query string in `toAttributes()` and turns query keys that start with `slider-` into CSS classes, keys starting with `data` into HTML data-attributes, and keys starting with `--swiffy-slider` into `style` custom properties, all placed on the slider container `<div>` (emitted through Drupal's `Attribute` object). The three formatters share `SwiffySliderFieldFormatterTrait`: `SwiffySliderEntityReferenceFormatter` (`swiffy_slider_entity_reference`, extends core `EntityReferenceEntityFormatter`, for `entity_reference` / `entity_reference_revisions`), `SwiffySliderImageFormatter` (`swiffy_slider_image`, extends core `ImageFormatter`, for `image`), and `SwiffySliderTextDefaultFormatter` (`swiffy_slider_text_default`, extends core `TextDefaultFormatter`, for `text` / `text_long` / `text_with_summary`). Each adds a single `swiffy_slider_permalink` setting (a URL, max length 1000) and attaches the `swiffy_slider/swiffy_slider-lib` library. The Views style `SwiffySlider` (`swiffy_slider`, extends `StylePluginBase`, uses row plugin, no grouping) adds a `configuration_url` option. Templates `field--swiffy-slider-entity-reference.html.twig` and `views-style-swiffy-slider.html.twig` wrap the items/rows in a `<ul class="slider-container">` with previous/next `slider-nav` buttons and `slider-indicators` dots. A global default configuration URL is stored in the config object `swiffy_slider.settings` (`configuration_url`) via `SettingsForm` at `/admin/config/content/swiffy_slider` (permission `administer site configuration`); when a formatter or style leaves its own URL empty, `toAttributes()` falls back to that global default, then to the configurator's base URL. `RenderHelper::attachCacheTags()` adds the settings config as a cacheable dependency when the global default is used. The module has no permissions of its own, no Drush commands, and no hard module dependencies declared (though the image/text formatters and the Views style rely on core `image`, `text` and `views` respectively).

---

- Turn a multi-value image field into a swipeable image carousel on a node display.
- Display a multi-value entity-reference field (e.g. referenced media or paragraphs) as a slider of rendered sub-entities.
- Slide referenced entities rendered in a chosen view mode via the entity-reference formatter's `view_mode` setting.
- Render a multi-value long-text field as a set of sliding text panels.
- Present the results of a View (e.g. latest articles as teasers) as a carousel using the Swiffy Slider Views style.
- Build a homepage "featured content" rotator from a node view without writing JavaScript.
- Ship a touch-friendly, trackpad-friendly slider that uses native browser scroll-snap instead of a JS animation loop.
- Configure slider look and behaviour visually on swiffyslider.com and paste the permalink — no per-option Drupal form to fill in.
- Enable previous/next navigation arrows and indicator dots through the configurator permalink's `slider-nav-*` options.
- Set a site-wide default slider configuration once at `/admin/config/content/swiffy_slider` and reuse it everywhere.
- Override the global default configuration URL per field display or per view.
- Add responsive per-breakpoint slide counts by choosing the relevant `slider-item-*` options in the configurator URL.
- Apply CSS custom-property tweaks (gaps, item widths) via `--swiffy-slider-*` values carried in the permalink.
- Pass through `data-*` slider behaviour flags (autoplay, loop, snap) encoded in the configurator URL query string.
- Provide an accessible carousel (WCAG-oriented, keyboard/scroll traversable) without adding heavy dependencies.
- Reuse the module's bundled library, or point it at a self-installed newer `swiffy-slider` release under `/libraries` for version control.
- Give editors a consistent slider across many content types by standardising on one saved permalink.
- Slide taxonomy-term or user references (any entity_reference target) rendered as cards.
- Build a logo/partner strip that scrolls horizontally with snap points.
- Create a testimonial slider from a long-text or entity-reference field.
- Combine with a teaser view mode to make a "related content" slider under an article.
- Avoid contributing custom Twig/JS for a carousel by relying on the module's templates and library attachment.
