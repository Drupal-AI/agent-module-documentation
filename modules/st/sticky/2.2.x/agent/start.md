<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sticky — agent index

Makes one site-wide element stay visible on scroll by applying the **garand/sticky** jQuery
plugin to a **DOM selector** you configure. One global settings form; the chosen selector +
options are stored in `sticky.settings` and pushed to `drupalSettings.sticky` on every page.

- **All settings keys, defaults, config name, route/permission, how it attaches, the external library** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Config object: **`sticky.settings`**. Admin form: `/admin/config/system/sticky`
  (route `sticky.sticky_settings_form`, permission `administer sticky`). `configure` =
  `sticky.sticky_settings_form`.
- The **`selector`** key (default `.menu--main`) chooses which element becomes sticky. It is
  global — one selector for the whole site; no per-page/per-block UI.
- Other keys: `top_spacing` (0), `bottom_spacing` (0), `class_name` (`is-sticky`),
  `wrapper_class_name` (`sticky-wrapper`), `center` (false), `get_width_from` (''),
  `width_from_wrapper` (true), `responsive_width` (false), `z_index` (`auto`).
- Delivery: `sticky_page_attachments()` → `StickyManager::getJsSettings()` →
  `drupalSettings.sticky` + attach `sticky/sticky` library, which needs the external file
  `/libraries/sticky/jquery.sticky.js` (download garand/sticky yourself).
- No config schema shipped, no plugins, no Drush, no module dependencies.
