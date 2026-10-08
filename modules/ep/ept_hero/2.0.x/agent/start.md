<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EPT Hero (ept_hero) — agent index

Ready-made **Hero paragraph type** for the Extra Paragraph Types (EPT) family: a media image,
title prefix, title, body text and **two call-to-action buttons**, in a two-column or one-column
layout. Version **2.0.1**, core `^10.1 || ^11 || ^12`.

**Dependencies:** `ept_core` (shared "EPT Settings" field + `GenerateCSS`), **`ept_basic_button`**
(the CTA buttons are its shared component + `GenerateCustomCSS`), and `paragraphs`.

## What it installs
- **Paragraph type** `ept_hero` (`config/install/paragraphs.paragraphs_type.ept_hero.yml`).
- **Fields on the bundle:** `field_ept_hero_column_image` (entity_reference → `media.type.image`,
  media-library widget), `field_ept_hero_title_prefix` / `field_ept_title` / `field_ept_text`
  (all `text_long`), `field_ept_hero_link` + `field_ept_hero_second_link` (core `link`), and
  `field_ept_settings` (the shared `ept_settings` field type from ept_core).
- **Form display** uses the custom widget `ept_settings_hero`; view display uses formatter
  `ept_settings_default`. Content vs Settings split across field_group tabs.
- **CSS libraries** `common`, `one_column`, `two_columns` (`ept_hero.libraries.yml`), attached by
  the template per selected style.

## How it works (the real mechanism)
- **Template** `templates/paragraph--ept-hero--default.html.twig` reads settings out of
  `content.field_ept_settings['#object'].field_ept_settings.0.ept_settings.*`, builds a wrapper
  class list (style, image-position, alignment, shape, size, custom classes, per-element classes),
  and lays out `hero-col-1` (image) + `hero-col-2` (title prefix, title, text, buttons).
- **Buttons** render as `<a href="{{ ...link.0['#url'] }}">{{ ...link.0['#title'] }}</a>` from the
  two core link fields (URL + title autoescaped by Twig; core link validation blocks dangerous
  protocols).
- **Per-paragraph CSS.** `ept_hero_preprocess_paragraph()` (in `src/Hook/EptHeroHooks.php`) calls
  two services and stores their output as `button_styles` (ept_basic_button `GenerateCustomCSS`)
  and `hero_styles` (this module's `src/Services/GenerateHeroCSS.php`); the `styles` variable comes
  from ept_core's `GenerateCSS`. The template prints all three with `|raw`:
  `{{ styles|raw }}{{ button_styles|raw }}{{ hero_styles|raw }}`. `GenerateHeroCSS` emits the mobile
  media query (from the **mobile_breakpoint** setting), the column `order` swap for
  image-position/mobile-order, and the overlay `:after` (overlay_color parsed via `sscanf` to RGB).
- **Widget** `src/Plugin/Field/FieldWidget/EptSettingsHeroWidget.php` extends
  `EptSettingsBasicButtonWidget`, adding the hero-only form elements (styles, overlay, image
  position/order, mobile breakpoint, a second `link_options2` group, and the `elements_classes`
  additional-class fields, which ARE validated by `EptGenericValidator::validateClassElement`).

## No configuration route of its own
Global EPT defaults (primary/secondary colours, breakpoints, container widths) live in **ept_core**
at `admin/config/content/ept-core` (`ept_core.settings`). ept_hero ships no admin route, no
permissions, no drush commands, no config schema of its own.

## Family trade-offs (same as ept_tiles / ept_slideshow / ept_carousel)
- Pre-built is quick to adopt and **awkward to diverge from** — the markup and field structure are
  the module's; an uncovered design means template overrides, at which point a local type is often
  cheaper.
- **It becomes a dependency of the content** — removing the module later leaves `ept_hero`
  paragraph entities with no type.
- **Heading level is your responsibility** — the title is a plain text field; a mid-page hero is
  usually not the page's `h1`.

## Subpages
- `paragraphs/hero-paragraph.md` — full field + settings reference and render path.
- `config/settings-and-css.md` — how per-paragraph settings become classes and inline CSS.
