<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Splide — agent index

Vanilla-JS slider/carousel integration (no jQuery), built on **Blazy**. Sliders are configured as
reusable **`splide` optionset** config entities and rendered by field formatters, a Views style, or
a text-filter shortcode.

- **The `splide` optionset config entity, `splide.settings`, and where the admin UI lives** →
  [configure/optionsets.md](configure/optionsets.md)
- **Field formatters, the Views style, and the text filter (how to render a slider)** →
  [configure/renderers.md](configure/renderers.md)
- **The `@SplideSkin` plugin type: add a custom skin** → [plugins/skin.md](plugins/skin.md)
- **Alter hooks (`hook_splide_optionset_alter`, `_options_alter`, `_settings_alter`, …)** →
  [hooks/alter.md](hooks/alter.md)

Key facts:
- Depends on **`blazy`** (>= 2.17) and the external **Splide JS library** (v4+) in `/libraries`.
- No configure route on the main module (`configure: null`); the UI is in the **splide_ui**
  submodule at `/admin/config/media/splide` (permission `administer splide`).
- Config entity type `splide` (optionsets), config `splide.settings` (`module_css`, `splide_css`,
  `sitewide`). Provides config schema.
- Skin plugin type `@SplideSkin` (manager `splide.skin_manager`, dir `Plugin/splide`); shipped skin
  ids include `default`, `classic`, `fullwidth`, `seagreen`, `split`.
- Services: `splide.manager`, `splide.formatter` (extend Blazy), `splide.admin`, `splide.skin_manager`.
- Submodules: **splide_ui** (optionset admin), **splide_x** (example optionsets/image styles/View/skin)
  — see [../../modules/splide_ui/2.0.x/agent/start.md](../../modules/splide_ui/2.0.x/agent/start.md)
  and [../../modules/splide_x/2.0.x/agent/start.md](../../modules/splide_x/2.0.x/agent/start.md).
