<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Block Types (EBT): Hero (ebt_hero) — agent index

A single custom **`block_content` type `ebt_hero`** for building hero/banner sections, meant for
**Layout Builder**. Package *Extra Block Types*. Core `^10.1 || ^11 || ^12`. License
GPL-2.0-or-later. Version 2.0.0.

Depends on: **ebt_core** (`^2.0`, shared design settings + `ebt_settings` field type), **ebt_basic_button**
(`^2.0`, the base settings widget + button-CSS service), **paragraphs** (`^1.0`), core **link** and
**media**. Requires a Media **`image`** type to exist before install — otherwise
`ebt_hero_requirements()` blocks it with an error naming "Media type Image".

No routes, no permissions, no Drush, no `config/schema`, no settings form of its own. All output is
config-installed fields + a preprocess hook + two Twig templates + a per-block CSS service.

## What it provides (from source)

- **Block type `ebt_hero`** with fields (config/install): `field_ebt_hero_title` (text_long),
  `field_ebt_hero_title_prefix` (text_long), `body` (text_with_summary),
  `field_ebt_hero_column_image` (entity_reference → media `image`, cardinality 1),
  `field_ebt_hero_link` + `field_ebt_hero_second_link` (link), and `field_ebt_settings`
  (`ebt_settings` field type from ebt_core).
- **Field widget** `EbtSettingsHeroWidget` (id **`ebt_settings_hero`**,
  `src/Plugin/Field/FieldWidget/EbtSettingsHeroWidget.php`) — extends
  `ebt_basic_button`'s `EbtSettingsBasicButtonWidget` and adds hero controls (styles, overlay,
  image position/order, mobile breakpoint, second-link options).
- **Service** `ebt_hero.generate_hero_css` → `GenerateHeroCSS` (`src/Services/GenerateHeroCSS.php`)
  — turns block settings into an inline `<style>` (responsive column stacking + overlay).
- **Hooks** `EbtHeroHooks` (`src/Hook/EbtHeroHooks.php`, attribute + `#[LegacyHook]` shims in
  `ebt_hero.module`): `hook_help` and `hook_preprocess_block` (injects `button_styles` +
  `hero_styles`).
- **Templates** `block--block-content--ebt-hero.html.twig`, `block--inline-block--ebt-hero.html.twig`.
- **Libraries** `ebt_hero/common`, `ebt_hero/one_column`, `ebt_hero/two_columns` (CSS only).

## Solution docs

- Block type, fields, form/view displays, install requirement, EBT Core relationship →
  [config/block-type.md](config/block-type.md)
- The `ebt_settings_hero` widget, the `GenerateHeroCSS` service, the preprocess hook and the
  templates (rendering pipeline) → [plugins/settings-widget-and-rendering.md](plugins/settings-widget-and-rendering.md)
