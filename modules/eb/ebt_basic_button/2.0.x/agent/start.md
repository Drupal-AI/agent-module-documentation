<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EBT Basic Button — agent index

Installs an `ebt_basic_button` block content type (Link + EBT settings fields) with a styled-button
settings widget for use in Layout Builder / the block library. Part of the Extra Block Types suite;
requires `ebt_core`, `paragraphs`, core `link`. No module `configure` route (global colour/breakpoint
defaults live in EBT Core), no permissions, no Drush.

- **Block type + fields, the `ebt_settings_basic_button` widget settings, EBT Core defaults, generated CSS** →
  [configure/block.md](configure/block.md)
- **Button templates and the `button_styles` variable** → [theming/templates.md](theming/templates.md)

Key facts:
- Bundle `block_content:ebt_basic_button` with fields `field_ebt_basic_button_link` (link) and
  `field_ebt_settings` (`ebt_settings`, from ebt_core).
- Widget `ebt_settings_basic_button` (`EbtSettingsBasicButtonWidget` extends
  `EbtSettingsDefaultWidget`) exposes: open_in_new_tab, add_nofollow, title_color, background_color,
  custom_hover_colors + hover_title_color/hover_background_color, alignment, shape, size, stretched,
  custom_class_name. Colours validated by `EbtSettingsDefaultWidget::validateColorElement`, classes
  by `EbtGenericValidator::validateClassElement`.
- `EbtBasicButtonHooks::preprocessBlock()` → `ebt_basic_button.generate_custom_css` service builds a
  scoped inline `<style>` (colours `Html::escape`d) exposed as `button_styles`.
