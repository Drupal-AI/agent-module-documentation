<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DXPR Theme Helper — agent index

Companion module for **DXPR Theme**: search & registration blocks, per-node page-layout fields,
a `dxt:*` Drush suite for DXPR Theme settings, and AI palette/font generators. Depends on core
`node`, `text`, `media`, `media_library`, `media_library_form_element`. No permissions of its
own (routes use `administer themes`), no configure route in info.yml (`configure: null`).
Config schema provided. `drupal/ai` is an optional suggest that enables the AI generators.

- **Blocks (full-screen search, user registration) + per-node page-layout fields** →
  [configure/blocks-and-fields.md](configure/blocks-and-fields.md)
- **The `dxt:*` Drush command suite (config get/set/list/export/import/reset, palette, page, subtheme, setup-ai)** →
  [drush/dxt-commands.md](drush/dxt-commands.md)
- **AI color-palette & font generators (services, `drupal/ai` requirement, `dxt:generate:*`)** →
  [api/ai-generators.md](api/ai-generators.md)

Key facts: block plugin ids `full_screen_search` and `dxpr_theme_helper_user_register`; node
fields `field_dth_page_layout` (fullwidth/boxed), `field_dth_main_content_width`,
`field_dth_hide_regions`, `field_dth_body_background`, `field_dth_page_title_backgrou`; Drush
namespace `dxt:` (aliases `dxt-*`) with settings driven by bundled `data/settings-schema.json`.
The config-writing `dxt:config:*` / `dxt:palette:*` commands need a DXPR Theme installed to
target; `dxt:config:list` reads the bundled schema without one.
