<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Paragraph Types (EPT): Stats (ept_stats) — agent index

Ships a **Stats** Paragraphs component: a container paragraph (`ept_stats`) holding an optional
Title, Text and a repeatable **stats item** sub-paragraph (`ept_stats_item`: number, text, image,
link), rendered in one of three predefined CSS layouts. Part of the **Extra Paragraph Types (EPT)**
family. Version **2.0.0**. License GPL-2.0-or-later. Core `^10.1 || ^11 || ^12`.

- **Dependencies:** `ept_core:ept_core`, `paragraphs:paragraphs`. Field configs also pull in core
  `entity_reference_revisions`, `text`, `link`, and `media` (Media Image type for the item image).
- **Configuration:** none of its own. All EPT design/settings config lives in **ept_core**
  (sitewide form at `/admin/config/content/ept-core`). No routes, no permissions, no Drush.

## What it provides (all from `config/install/`)

- **Paragraphs types:** `ept_stats` (label "EPT Stats") and `ept_stats_item` ("EPT Stats Item").
- **`ept_stats` fields:** `field_ept_title` (text_long), `field_ept_text` (text_long),
  `field_ept_stats` (entity_reference_revisions → `ept_stats_item`, **required**, multi),
  `field_ept_settings` (ept_core's `ept_settings` type, holds design + style choice).
- **`ept_stats_item` fields:** `field_ept_stats_item_number` (text_long),
  `field_ept_stats_item_text` (text_long), `field_ept_stats_item_image` (entity_reference → Media
  `image`), `field_ept_stats_item_link` (link).
- **Widget:** `EptSettingsStatsWidget` (id `ept_settings_stats`), extends ept_core's
  `EptSettingsDefaultWidget`; adds a `styles` radios element
  (`stats_with_vertical_dividers` | `stats_in_squares` | `stats_in_column`, default first).
- **Libraries:** three component CSS bundles `stats_with_vertical_dividers`, `stats_in_squares`,
  `stats_in_column` (attached by template based on the chosen style).
- **Templates:** `paragraph--ept-stats--default.html.twig`,
  `field--paragraph--field-ept-stats--ept-stats.html.twig`.
- **Hook:** `EptStatsHooks::themeRegistryAlter()` (`hook_theme_registry_alter`, OOP via
  `#[Hook]`/`#[LegacyHook]`, wired in `ept_stats.services.yml`) registers the field template.

## Docs

- **Paragraph types, fields, styles, templates, how to place & operate** →
  [structure/paragraph-type.md](structure/paragraph-type.md)
