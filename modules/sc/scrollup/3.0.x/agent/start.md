<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Scrollup (scrollup) — agent index

Adds a floating "scroll to top" button that appears after the visitor scrolls down a page and
smooth-scrolls back to the top when clicked. Pure config + a vanilla-JS `Drupal.behaviors`; no
dependencies beyond core. Core: `^10.3 || ^11.0`.

- Configure route: `scrollup.form` at `/admin/config/system/scrollup` (permission
  `administer site configuration`). Menu link `scrollup.admin` under `system.admin_config_ui`.
- Defines no permissions, no services, no drush, no plugins. Provides config schema.

Solution docs:
- **Set the label, position, colors, appear-threshold, speed, and which themes show it** →
  [configure/settings.md](configure/settings.md)
- **How the button is attached and rendered (library, drupalSettings, JS behavior, CSS)** →
  [theme/button.md](theme/button.md)

Key facts:
- Config object: `scrollup.settings` (schema `config/schema/scrollup.schema.yml`, type `config_object`).
- Config keys: `scrollup_themename` (sequence), `scrollup_title`, `scrollup_window_position`,
  `scrollup_speed`, `scrollup_position`, `scrollup_button_bg_color`, `scrollup_button_hover_bg_color`.
- Form: `\Drupal\scrollup\Form\ScrollupForm` (`ConfigFormBase`, form id `scrollup_form`), injects
  `theme_handler`.
- Attach hook: `scrollup_preprocess_page()` attaches library `scrollup/scrollup` + drupalSettings
  only when the active theme is listed in `scrollup_themename`.
- Library `scrollup/scrollup`: `js/scrollup_top.js`, `css/scrollup_top.css`; deps
  `core/drupalSettings`, `core/drupal`, `core/once`. JS behavior `Drupal.behaviors.scrollup`.
- Defaults seeded by `scrollup_install()`: position `1`, bg `#CCCCCC`, hover `#000000`,
  title `Scroll up`, window position `600`, speed `0`, themename `[<default theme>]`.
